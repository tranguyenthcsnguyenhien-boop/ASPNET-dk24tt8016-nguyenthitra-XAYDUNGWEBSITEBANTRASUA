using System;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua
{
    public partial class DangNhap : System.Web.UI.Page
    {
        UserBLL userBLL = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["msg"] == "success")
            {
                lblMessage.CssClass = "text-success mb-3 d-block text-center fw-bold";
                lblMessage.Text = "Đăng ký thành công! Vui lòng đăng nhập.";
            }
        }

        protected void btnDangNhap_Click(object sender, EventArgs e)
        {
            UserDTO user;
            if (userBLL.KiemTraDangNhap(txtUsername.Text.Trim(), txtPassword.Text, out user))
            {
                Session["User"] = user;
                if (user.Role == "Admin")
                    Response.Redirect("~/Admin/Default.aspx");
                else
                    Response.Redirect("Default.aspx");
            }
            else
            {
                lblMessage.CssClass = "text-danger mb-3 d-block text-center fw-bold";
                lblMessage.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
            }
        }
    }
}
