using System;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua
{
    public partial class DangKy : System.Web.UI.Page
    {
        UserBLL userBLL = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnDangKy_Click(object sender, EventArgs e)
        {
            UserDTO user = new UserDTO();
            user.Username = txtUsername.Text.Trim();
            user.Password = txtPassword.Text; // Thực tế nên mã hóa
            user.FullName = txtFullName.Text.Trim();

            string result = userBLL.DangKy(user);
            if (result == "OK")
            {
                Response.Redirect("DangNhap.aspx?msg=success");
            }
            else
            {
                lblMessage.Text = result;
            }
        }
    }
}
