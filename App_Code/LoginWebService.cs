using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for LoginWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class LoginWebService : System.Web.Services.WebService
{

    public LoginWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    [WebMethod(EnableSession = true)]
    public String LoginCheck(String UserName, String Password)
    {
        SqlConnection con = new SqlConnection(Global.StrCon);
        String msg = "";
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("AdminLogin", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Username", UserName).DbType = DbType.String;
            cmd.Parameters.AddWithValue("@Password", Password).DbType = DbType.String;

            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();

            adp.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                HttpContext.Current.Session["AdminID"] = ds.Tables[0].Rows[0]["AdminID"].ToString();
                msg = "Valid";

            }
            else
            {

                msg = "Invalid";

            }


            con.Close();
        }
        catch (Exception ex)
        {
            msg = "Error" + ex.Message;
        }
        return msg;
    }
    [WebMethod(EnableSession = true)]
    public String LogOut()
    {
        String msg = "Invalid";
        Session.Abandon();
        return msg;
    }
}
