using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
/// <summary>
/// Summary description for SubCategoryMasterWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SubCategoryMasterWebService : System.Web.Services.WebService
{

    public SubCategoryMasterWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public string SubCategoryMasterManage(Int32 SubCategoryID, Int32 CategoryID, String SubCategoryName,String SubCategoryPhoto)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        String msg = "";
        try
        {
            if (SubCategoryID == 0)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SubCategoryMasterInsert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.String;
                cmd.Parameters.AddWithValue("@SubCategoryName", SubCategoryName).DbType = DbType.String;
                cmd.Parameters.AddWithValue("@SubCategoryPhoto", SubCategoryPhoto).DbType = DbType.String;
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                msg = "Record Saved Successfully";
                con.Close();
            }
            else
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SubCategoryMasterUpdate", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@SubCategoryID", SubCategoryID).DbType = DbType.Int32;
                cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.Int32;
                cmd.Parameters.AddWithValue("@SubCategoryName", SubCategoryName).DbType = DbType.String;
                cmd.Parameters.AddWithValue("@SubCategoryPhoto", SubCategoryPhoto).DbType = DbType.String;
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
    public string SubCategoryMasterGet(Int32 SubCategoryID)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        SqlCommand cmd = new SqlCommand("SubCategoryMasterGet", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@SubCategoryID", SubCategoryID).DbType = DbType.Int32;
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
    public string SubCategoryMasterDelete(Int32 SubCategoryID,String SubCategoryPhoto)
    {
        string msg = "";
        SqlConnection con = new SqlConnection(Global.StrCon);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SubCategoryMasterDelete", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SubCategoryID", SubCategoryID).DbType = DbType.Int32;
            cmd.Parameters.AddWithValue("@SubCategoryPhoto", SubCategoryPhoto).DbType = DbType.Int32;
            cmd.ExecuteNonQuery();
            cmd.Dispose();

            msg = "Record Deleted successfully.";
            con.Close();
            System.IO.FileInfo fileInfo = new System.IO.FileInfo(HttpContext.Current.Server.MapPath("~/Assets/Images/" + SubCategoryPhoto + ""));
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
    public List<ListItem> ListAllSubCategory(Int32 CategoryID)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        List<ListItem> list = new List<ListItem>();

        try
        {
            SqlCommand cmd = new SqlCommand("ListAllSubCategory", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CategoryID", CategoryID).DbType = DbType.Int32;
            con.Open();
            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    list.Add(new ListItem
                    {
                        Value = sdr["SubCategoryID"].ToString(),
                        Text = sdr["SubCategoryName"].ToString()
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
