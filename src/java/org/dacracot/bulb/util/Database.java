package org.dacracot.bulb.util;
//---------------------------------------------------
import java.sql.*;
//----------------------------------------------------
import javax.naming.*;
import javax.sql.*;
//----------------------------------------------------
import org.json.*;
//----------------------------------------------------
public class Database
	{
	private Connection conn;
	private Statement stmt;
	private ResultSet rset;
	//-----------------------------------------------
	public Database()
		{
		conn = null;
		}
	//-----------------------------------------------
	public void getConn() throws Exception
		{
		Context initContext = new InitialContext();
		Context envContext  = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/bulb");
		conn = ds.getConnection();
		}
	//-----------------------------------------------
	public void releaseConn() throws Exception
		{
		conn.close();
		}
	//-----------------------------------------------
	private enum outputs
		{
		JSON,
		XML,
		CSV
		}
	//------------------------------------------------
	private String doSqlWithResult (String call, outputs output)
		{
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSqlWithResult(call,output)>> "+call+" - "+output);
		JSONArray jsonResult = new JSONArray();
		String result = "";
		try
			{
			stmt = conn.createStatement();
			stmt.setQueryTimeout(30);
			//----------------------------------------
			try
				{
				rset = stmt.executeQuery(call);
				ResultSetMetaData meta = rset.getMetaData();
				int colCnt = meta.getColumnCount();
				//------------------------------------
				if (!rset.next())
					result = "no records found";
				else
					{
					boolean hasNext = false;
					do
						{
						JSONObject jsonRow = new JSONObject();
						for (int i=1; i<=colCnt; i++)
							{
							jsonRow.put(meta.getColumnName(i),rset.getObject(i).toString());
							}
						jsonResult.put(jsonRow);
						} while (rset.next());
					switch (output)
						{
						case JSON:
							{
							result = jsonResult.toString();
							break;
							}
						case XML:
							{
							result = "<result>"+XML.toString(jsonResult,"row")+"</result>";
							break;
							}
						case CSV:
							{
							result = CDL.toString(jsonResult);
							break;
							}
						}
					}
				//------------------------------------
				}
			catch(Exception e)
				{
				result = Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithResult:execute>> " + call,e);
				}
			finally
				{
				try
					{
					rset.close();
					stmt.close();
					}
				catch(Exception e)
					{
					Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithResult:finally>> ",e);
					}
				}
			}
		catch(Exception e)
			{
			result = Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithResult:prepareCall>> " + call,e);
			}
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSqlWithResult(output)>> "+result);
		return(result);
		}
	//-----------------------------------------------
	private String doSqlWithoutResult (String call)
		{
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSqlWithoutResult(call)>> "+call);
		String result = "";
		try
			{
			stmt = conn.createStatement();
			stmt.setQueryTimeout(30);
			//----------------------------------------
			try
				{
				stmt.executeUpdate(call);
				}
			catch(Exception e)
				{
				Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithoutResult:execute>> " + call,e);
				}
			finally
				{
				try
					{
					stmt.close();
					}
				catch(Exception e)
					{
					Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithoutResult:finally>> ",e);
					}
				}
			}
		catch(Exception e)
			{
			Debug.logger("org.dacracot.bulb.util.Database","error: doSqlWithoutResult:prepareCall>> " + call,e);
			}
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSqlWithoutResult(output)>> "+result);
		return(result);
		}
	//-----------------------------------------------
	public String doSql (String call, String outputType)
		{
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSql(call,outputType)>> "+call+","+outputType);
		String result = "";
		//-------------------------------------------
		if (call.toUpperCase().startsWith("SELECT"))
			{
			outputs output = null;
			try
				{
				output = outputs.valueOf(outputType.toUpperCase());
				}
			catch (IllegalArgumentException e)
				{
				return("No such output type >> "+outputType);
				}
			result = doSqlWithResult(call,output);
			}
		else
			{
			result = doSqlWithoutResult(call);
			}
		//-------------------------------------------
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Database","doSql(output)>> "+result);
		return(result);
		}
	//-----------------------------------------------
	}
//----------------------------------------------------