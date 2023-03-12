﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for StaffTypeWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class StaffTypeWebService : System.Web.Services.WebService
{

    public StaffTypeWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string StaffTypeMasterManage(Int32 StaffTypeID, String StaffType)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        String msg = "";
        try
        {
            if (StaffTypeID == 0)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("StaffTypeMasterInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StaffType", StaffType).DbType = DbType.String;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                msg = "Record Saved Successfully";
                con.Close();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("StaffTypeMasterUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@StaffTypeID", StaffTypeID).DbType = DbType.Int32;
                cmd.Parameters.AddWithValue("@StaffType", StaffType).DbType = DbType.String;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                msg = "Record Updated Successfully";
                con.Close();
            }
        }
        catch (Exception ex)
        {
            msg = "Error" + ex.Message;
        }
        return msg;
    }
    [WebMethod]
    public string StaffTypeMasterGet(Int32 StaffTypeID)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        SqlCommand cmd = new SqlCommand("StaffTypeMasterGet", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@StaffTypeID", StaffTypeID).DbType = DbType.Int32;
        return GetDataWithoutPagging(cmd).GetXml();
    }
    public DataSet GetDataWithoutPagging(SqlCommand cmd)
    {
        var msg = "";
        SqlConnection con = new SqlConnection(Global.StrCon);
        DataSet ds = new DataSet();

        try
        {
            con.Open();
            using (SqlDataAdapter adp = new SqlDataAdapter())
            {
                cmd.Connection = con;
                adp.SelectCommand = cmd;
                adp.Fill(ds, "DataDetails");
            }
            con.Close();
        }
        catch (Exception ex)
        {
            msg = ex.Message;
        }
        finally
        {
            if (con.State == ConnectionState.Open)
                con.Close();
        }
        return ds;
    }
    [WebMethod]
    public string StaffTypeMasterDelete(Int32 StaffTypeID)
    {
        string msg = "";
        SqlConnection con = new SqlConnection(Global.StrCon);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("StaffTypeMasterDelete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StaffTypeID", StaffTypeID).DbType = DbType.Int32;
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            msg = "Record Deleted successfully.";
            con.Close();
        }
        catch (Exception ex)
        {
            msg = "Error" + ex.Message;
        }
        return msg;

    }
    [WebMethod]
    public List<ListItem> ListAllStaffType()
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        List<ListItem> list = new List<ListItem>();

        try
        {
            SqlCommand cmd = new SqlCommand("ListAllStaffType", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    list.Add(new ListItem
                    {
                        Value = sdr["StaffTypeID"].ToString(),
                        Text = sdr["StaffType"].ToString()
                    });
                }
            }
            con.Close();
        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return list;
    }
}
