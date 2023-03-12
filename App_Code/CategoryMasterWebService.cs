using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for CategoryMasterWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class CategoryMasterWebService : System.Web.Services.WebService
{

    public CategoryMasterWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string CategoryMasterManage(Int32 CategoryID, String CategoryName,String CategoryPhoto)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        String msg = "";
        try
        {
            if (CategoryID == 0)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("CategoryMasterInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CategoryName", CategoryName).DbType = DbType.String;
                cmd.Parameters.AddWithValue("@CategoryPhoto", CategoryPhoto).DbType = DbType.String;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                msg = "Record Saved Successfully";
                con.Close();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("CategoryMasterUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.Int32;
                cmd.Parameters.AddWithValue("@CategoryName", CategoryName).DbType = DbType.String;
                cmd.Parameters.AddWithValue("@CategoryPhoto", CategoryPhoto).DbType = DbType.String;
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
    public string CategoryMasterGet(Int32 CategoryID)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        SqlCommand cmd = new SqlCommand("CategoryMasterGet", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.Int32;
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
    public string CategoryMasterDelete(Int32 CategoryID, String CategoryPhoto)
    {
        string msg = "";
        SqlConnection con = new SqlConnection(Global.StrCon);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("CategoryMasterDelete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.Int32;
            cmd.Parameters.AddWithValue("@CategoryPhoto", CategoryPhoto).DbType = DbType.String;
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            msg = "Record Deleted successfully.";
            con.Close();
            System.IO.FileInfo fileInfo = new System.IO.FileInfo(HttpContext.Current.Server.MapPath("~/Assets/Images/" + CategoryPhoto + ""));
            if (fileInfo.Exists)
                fileInfo.Delete();
        }
        catch (Exception ex)
        {
            msg = "Error" + ex.Message;
        }
        return msg;

    }

    [WebMethod]
    public List<ListItem> ListAllCategory()
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        List<ListItem> list = new List<ListItem>();

        try
        {
            SqlCommand cmd = new SqlCommand("ListAllCategory", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    list.Add(new ListItem
                    {
                        Value = sdr["CategoryID"].ToString(),
                        Text = sdr["CategoryName"].ToString()
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
