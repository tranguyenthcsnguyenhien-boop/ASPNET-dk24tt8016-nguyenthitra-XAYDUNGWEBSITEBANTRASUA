using System;
using System.Web;
using System.Web.UI;
using WebBanTraSua.DTO;

namespace WebBanTraSua.Admin
{
    public partial class AdminMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                string returnUrl = Request.RawUrl;
                Response.Redirect("~/DangNhap.aspx?ReturnUrl=" + Server.UrlEncode(returnUrl));
                return;
            }

            UserDTO user = (UserDTO)Session["User"];
            if (user.Role != "Admin")
            {
                // Xoa phien dang nhap vi khong co quyen truy cap trang quan tri
                Session.Abandon();
                
                // Chuyen huong ve trang dang nhap
                Response.Redirect("~/DangNhap.aspx?msg=not_admin");
                return;
            }

            if (!IsPostBack)
            {
                lblAdminName.Text = user.FullName;
            }
        }
    }
}
