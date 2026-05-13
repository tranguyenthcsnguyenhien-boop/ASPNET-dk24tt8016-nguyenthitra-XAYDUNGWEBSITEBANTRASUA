using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.Admin
{
    public partial class QuanLyKhachHang : Page
    {
        private UserBLL userBLL = new UserBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            DataTable dt = userBLL.LayDanhSachTatCaUser();
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
            lblUserCount.Text = dt.Rows.Count.ToString();
        }

        protected void gvUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // 1. Dinh dang badge cho Role
                Label lblRoleBadge = (Label)e.Row.FindControl("lblRoleBadge");
                if (lblRoleBadge != null)
                {
                    string role = lblRoleBadge.Text;
                    if (role == "Admin")
                    {
                        lblRoleBadge.CssClass = "badge rounded-pill px-3 py-1.5 fw-bold text-success bg-success-subtle";
                        lblRoleBadge.Style.Add("background-color", "#e1f5fe");
                        lblRoleBadge.Style.Add("color", "#0288d1");
                    }
                    else
                    {
                        lblRoleBadge.CssClass = "badge rounded-pill px-3 py-1.5 fw-bold text-secondary bg-secondary-subtle";
                        lblRoleBadge.Style.Add("background-color", "#f5f5f5");
                        lblRoleBadge.Style.Add("color", "#616161");
                    }
                }

                // 2. An cac nut hanh dong neu trung voi User hien tai trong phien Session
                if (Session["User"] != null)
                {
                    UserDTO currentUser = (UserDTO)Session["User"];
                    int targetUserId = Convert.ToInt32(gvUsers.DataKeys[e.Row.RowIndex].Value);

                    if (targetUserId == currentUser.ID)
                    {
                        LinkButton btnToggleRole = (LinkButton)e.Row.FindControl("btnToggleRole");
                        LinkButton btnDelete = (LinkButton)e.Row.FindControl("btnDelete");

                        if (btnToggleRole != null)
                        {
                            btnToggleRole.Visible = false;
                        }
                        if (btnDelete != null)
                        {
                            btnDelete.Visible = false;
                        }

                        // Them chu thich de thuong cho admin hien tai
                        e.Row.Cells[1].Text += " <span class='badge bg-info text-white rounded-pill fw-bold fs-7 ms-1'><i class='fa-solid fa-circle-user'></i> Bạn</span>";
                    }
                }
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (Session["User"] == null) return;
            UserDTO currentUser = (UserDTO)Session["User"];

            int userId = Convert.ToInt32(e.CommandArgument);

            if (userId == currentUser.ID)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Lỗi bảo mật: Bạn không thể tự thay đổi vai trò hoặc tự xóa tài khoản của chính mình!');", true);
                return;
            }

            if (e.CommandName == "ToggleRole")
            {
                // Lay thong tin user hien tai qua ID de xem dang co quyen gi
                UserDTO targetUser = userBLL.LayThongTinNguoiDung(userId);
                if (targetUser != null)
                {
                    string newRole = targetUser.Role == "Admin" ? "Customer" : "Admin";
                    if (userBLL.CapNhatQuyenUser(userId, newRole))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã cập nhật quyền thành công cho tài khoản " + targetUser.Username + " sang " + newRole + "!');", true);
                    }
                }
            }
            else if (e.CommandName == "DeleteUser")
            {
                // Xoa user khoi co so du lieu
                UserDTO targetUser = userBLL.LayThongTinNguoiDung(userId);
                if (targetUser != null)
                {
                    if (userBLL.XoaUser(userId))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã xóa vĩnh viễn tài khoản " + targetUser.Username + " thành công!');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Có lỗi xảy ra: Có thể người dùng này đang có đơn hàng trong lịch sử mua sắm!');", true);
                    }
                }
            }

            LoadUsers();
        }
    }
}
