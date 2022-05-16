package org.dacracot.bulb;
//---------------------------------------------------
import java.io.*;
import java.net.*;
//---------------------------------------------------
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
//---------------------------------------------------
import org.dacracot.bulb.util.*;
//----------------------------------------------------
@WebServlet(name="bulb", urlPatterns="/db")
public class SqlServlet extends HttpServlet
	{
	//-----------------------------------------------
	private static final long serialVersionUID = 1961071705050000001L;
	private ParamParser pp = null;
	//-----------------------------------------------
	@Override
	public void init() throws ServletException
		{
		//-------------------------------------------
		try
			{
 			Debug.init(getServletContext(),getInitParameter("debugLevel"));
			Debug.init(getServletContext(),"verbose");
			Debug.logger("org.dacracot.bulb.SqlServlet","initialized bulb version: "+getInitParameter("version")+" with "+getInitParameter("debugLevel")+" logging");
			pp = new ParamParser();
			}
		catch (Exception e)
			{
			throw(new ServletException(e));
			}
		}
	//-----------------------------------------------
	private void doVerb(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		String result = null;
		Database db = new Database();
		try
			{
			db.getConn();
			PrintWriter out = response.getWriter();
			//-------------------------------------------
			response.setContentType("text/plain");
			result = db.doSql(pp.getPayload(request,"sql"),pp.getPayload(request,"outputType"));
			out.println(result);
			response.setStatus(HttpServletResponse.SC_OK);
			out.close();
			}
		catch(Exception e)
			{
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, result);
			Debug.logger("org.dacracot.bulb.SqlServlet",result,e);
			}
		}
	//-----------------------------------------------
	private void notImplemented(HttpServletResponse response) throws ServletException, IOException
		{
		response.setStatus(HttpServletResponse.SC_NOT_IMPLEMENTED);
		}
	//-----------------------------------------------
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		doVerb(request,response);
		}
	//-----------------------------------------------
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		doVerb(request,response);
		}
	//-----------------------------------------------
	@Override
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		notImplemented(response);
		}
	//-----------------------------------------------
	@Override
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		notImplemented(response);
		}
	//-----------------------------------------------
	@Override
	protected void doOptions(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		notImplemented(response);
		}
	//-----------------------------------------------
	@Override
	protected void doTrace(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
		{
		notImplemented(response);
		}
	//-----------------------------------------------
	}
//---------------------------------------------------
