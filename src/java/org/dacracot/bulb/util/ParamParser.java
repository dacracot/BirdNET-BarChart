package org.dacracot.bulb.util;
//---------------------------------------------------
import java.io.*;
import java.net.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
//---------------------------------------------------
public class ParamParser
	{
	//-----------------------------------------------
	private String findParameterValue(String key, String payload) throws Exception
		{
		String marker = key+"=";
		String[] pairs = payload.split("&");
		for (String pair : pairs)
			{
			int idx = pair.indexOf(marker);
			if (idx == -1)
				continue;
			else
				return(URLDecoder.decode(pair.substring(marker.length()), "UTF-8"));
			}
		return("");
		}
	//-----------------------------------------------
	public String getPayload(HttpServletRequest request, String name)
		{
		String result = "";
		String[] value = request.getParameterValues(name);
		if (value != null)
			result = value[0];  // only ever sending a single value
		else
			{
			StringBuilder buffer = new StringBuilder(512);
			try
				{
				BufferedReader postReader = request.getReader();
				String line = null;
				//---------------------------------------
				while((line = postReader.readLine()) != null)
					{
					buffer.append(line);
					}
				result = findParameterValue(name,buffer.toString());
				//---------------------------------------
				}
			catch(Exception e)
				{
				Debug.logger("org.dacracot.bulb.util.paramParser",result,e);
				return(result);
				}
			}
		return(result);
		}
	//-----------------------------------------------
	}
//---------------------------------------------------