package org.dacracot.bulb.util;
//---------------------------------------------------
import java.util.*;
import java.io.*;
//---------------------------------------------------
import javax.xml.transform.*;
import javax.xml.transform.stream.*;
//----------------------------------------------------
public class Xslt
	{
	//-----------------------------------------------
	TransformerFactory tFactory;
	//-----------------------------------------------
	public Xslt()
		{
		try
			{
			tFactory = TransformerFactory.newInstance();
			}
		catch (Exception e)
			{
			Debug.logger("org.dacracot.bulb.util.Xslt","error: construct>> ",e);
			}
		}
	//-----------------------------------------------
	public String morph(String xml, String xslUrl)
		{
		String result;
		ByteArrayInputStream xmlStream;
		if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Xslt","morph(xslUrl)>> "+xslUrl);
		//-------------------------------------------
		try
			{
			//-----------------------------------
			Transformer transformer = tFactory.newTransformer(new StreamSource(xslUrl));
			//-----------------------------------
			if (xml != null)
				xmlStream = new ByteArrayInputStream(xml.getBytes());
			else
				xmlStream = null;
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			DataOutputStream dataOut = new DataOutputStream(baos);
			//-----------------------------------
			transformer.transform(new StreamSource(xmlStream), new StreamResult(new OutputStreamWriter(dataOut)));
			result = baos.toString();
			if (Debug.VERBOSE) Debug.logger("org.dacracot.bulb.util.Xslt","morph(output)>> "+result);
			//-----------------------------------
			}
		catch (Exception e)
			{
			result = Debug.logger("org.dacracot.bulb.util.Xslt","error: morph>> ",e);
			}
		return(result);
		}
	//-----------------------------------------------
	}
//---------------------------------------------------
