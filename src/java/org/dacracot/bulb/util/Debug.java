package org.dacracot.bulb.util;
//---------------------------------------------------
import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
//----------------------------------------------------
public class Debug
	{
	//-----------------------------------------------
	private static SimpleDateFormat dateFormat;
	private static ServletContext context;
	public static boolean VERBOSE;
	//-----------------------------------------------
	public static String stackTrace(Exception e) {
		StringWriter out = new StringWriter();
		e.printStackTrace(new PrintWriter(out));
		return out.toString();
		}
	//-----------------------------------------------
	public static void init(ServletContext c, String level) {
		context = c;
		dateFormat = new SimpleDateFormat("yyyyMMddHHmmss.SSS");
 		VERBOSE = level.equals("verbose");
		}
	//-----------------------------------------------
	private static String txtFormat(String who, String txt) {
		return("[" + who + "]@" + dateFormat.format(new java.util.Date()) + " - " + txt);
		}
	//-----------------------------------------------
	public static String logger(String who, String txt) {
		String line = txtFormat(who,txt);
		context.log(line);
		return(line);
		}
	//-----------------------------------------------
	public static String logger(String who, String txt, Exception e) {
		String line = txtFormat(who,txt);
		context.log(line,e);
		return(line + "\n" + stackTrace(e));
		}
	//-----------------------------------------------
	public static String logger(String who, String txt, HttpServletRequest request, String payload) {
		StringBuffer resultBuffer = new StringBuffer();
		//---------------------------------------
		resultBuffer.append("--------------------------------------------------------\n");
		resultBuffer.append("Protocol: " + request.getProtocol() + "\n");
		resultBuffer.append("Scheme: " + request.getScheme() + "\n");
		resultBuffer.append("Server Name: " + request.getServerName() + "\n");
		resultBuffer.append("Server Port: " + request.getServerPort() + "\n");
		resultBuffer.append("Remote Addr: " + request.getRemoteAddr() + "\n");
		resultBuffer.append("Remote Host: " + request.getRemoteHost() + "\n");
		resultBuffer.append("Character Encoding: " + request.getCharacterEncoding() + "\n");
		resultBuffer.append("Content Length: " + request.getContentLength() + "\n");
		resultBuffer.append("Content Type: "+ request.getContentType() + "\n");
		resultBuffer.append("Locale: "+ request.getLocale() + "\n");
		resultBuffer.append("--------------------------------------------------------\n");
		resultBuffer.append("Headers in this request:\n");
		Enumeration<String> e = request.getHeaderNames();
		while (e.hasMoreElements())
			{
			String key = e.nextElement();
			String value = request.getHeader(key);
			resultBuffer.append("   " + key + ": " + value + "\n");
			}
		resultBuffer.append("--------------------------------------------------------\n");
		resultBuffer.append("Cookies in this request:\n");
		Cookie[] cookies = request.getCookies();
		if (cookies != null)
			{
			for (int i = 0; i < cookies.length; i++)
				{
				Cookie cookie = cookies[i];
				resultBuffer.append("   " + cookie.getName() + " = " + cookie.getValue() + "\n");
				}
			}
		resultBuffer.append("--------------------------------------------------------\n");
		resultBuffer.append("Request Is Secure: " + request.isSecure() + "\n");
		resultBuffer.append("Auth Type: " + request.getAuthType() + "\n");
		resultBuffer.append("HTTP Method: " + request.getMethod() + "\n");
		resultBuffer.append("Remote User: " + request.getRemoteUser() + "\n");
		resultBuffer.append("Request URI: " + request.getRequestURI() + "\n");
		resultBuffer.append("Context Path: " + request.getContextPath() + "\n");
		resultBuffer.append("Servlet Path: " + request.getServletPath() + "\n");
		resultBuffer.append("Path Info: " + request.getPathInfo() + "\n");
		resultBuffer.append("Path Trans: " + request.getPathTranslated() + "\n");
		resultBuffer.append("Query String: " + request.getQueryString() + "\n");
		resultBuffer.append("--------------------------------------------------------\n");
		resultBuffer.append("Parameter names in this request:\n");
		e = request.getParameterNames();
		while (e.hasMoreElements())
			{
			String key = e.nextElement();
			String[] values = request.getParameterValues(key);
			resultBuffer.append("   " + key + " = \n");
			for(int i = 0; i < values.length; i++)
				resultBuffer.append(values[i] + " \n");
			}
		resultBuffer.append("--------------------------------------------------------\n");
		if (request.getMethod().equals("POST") || request.getMethod().equals("PUT"))
			{
			resultBuffer.append("Payload in this request:\n");
			resultBuffer.append(payload);
			resultBuffer.append("\n");
			}
		resultBuffer.append("--------------------------------------------------------\n");
		//---------------------------------------
		String line = txtFormat(who,txt) + "\n" + resultBuffer.toString();
		context.log(line);
		return(line);
		}
	//-----------------------------------------------
	}
//---------------------------------------------------
