using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.Admin
{
    public partial class QuanLyLoaiSP : Page
    {
        private LoaiSPBLL loaiSPBLL = new LoaiSPBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            List<LoaiSPDTO> categories = loaiSPBLL.LayDanhSachLoai();
            gvCategories.DataSource = categories;
            gvCategories.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ResetForm();
            lblFormTitle.Text = "Thêm Danh Mục Mới";
            pnlForm.Visible = true;
            pnlSelectAlert.Visible = false;
        }

        private void ResetForm()
        {
            hdnCategoryID.Value = "";
            txtTenLoai.Text = "";
            txtThuTu.Text = "";
        }

        protected void gvCategories_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int categoryId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditCategory")
            {
                var categories = loaiSPBLL.LayDanhSachLoai();
                var cat = categories.FirstOrDefault(x => x.ID == categoryId);

                if (cat != null)
                {
                    hdnCategoryID.Value = cat.ID.ToString();
                    txtTenLoai.Text = cat.TenLoai;
                    txtThuTu.Text = cat.ThuTu.ToString();

                    lblFormTitle.Text = "Chỉnh Sửa Danh Mục";
                    pnlForm.Visible = true;
                    pnlSelectAlert.Visible = false;
                }
            }
            else if (e.CommandName == "DeleteCategory")
            {
                string result = loaiSPBLL.XoaLoai(categoryId);
                if (result == "OK")
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã xóa danh mục thành công!');", true);
                    LoadCategories();
                    pnlForm.Visible = false;
                    pnlSelectAlert.Visible = true;
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + result + "');", true);
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            LoaiSPDTO loai = new LoaiSPDTO();
            loai.TenLoai = txtTenLoai.Text.Trim();
            loai.ThuTu = Convert.ToInt32(txtThuTu.Text.Trim());

            bool isEdit = !string.IsNullOrEmpty(hdnCategoryID.Value);
            bool success = false;

            if (isEdit)
            {
                loai.ID = Convert.ToInt32(hdnCategoryID.Value);
                success = loaiSPBLL.CapNhatLoai(loai);
            }
            else
            {
                success = loaiSPBLL.ThemLoai(loai);
            }

            if (success)
            {
                string msg = isEdit ? "Cập nhật danh mục thành công!" : "Thêm mới danh mục thành công!";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "');", true);

                LoadCategories();
                ResetForm();
                pnlForm.Visible = false;
                pnlSelectAlert.Visible = true;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Lưu danh mục thất bại!');", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
            pnlForm.Visible = false;
            pnlSelectAlert.Visible = true;
        }
    }
}
