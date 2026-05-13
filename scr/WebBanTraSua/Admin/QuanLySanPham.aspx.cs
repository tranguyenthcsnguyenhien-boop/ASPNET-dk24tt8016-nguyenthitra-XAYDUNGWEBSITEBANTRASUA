using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.Admin
{
    public partial class QuanLySanPham : Page
    {
        private SanPhamBLL sanPhamBLL = new SanPhamBLL();
        private LoaiSPBLL loaiSPBLL = new LoaiSPBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
                LoadCategoriesDropdown();
            }
        }

        private void LoadProducts()
        {
            DataTable dt = sanPhamBLL.LayDanhSachSanPhamTatCa();
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        private void LoadCategoriesDropdown()
        {
            var categories = loaiSPBLL.LayDanhSachLoai();
            ddlLoai.DataSource = categories;
            ddlLoai.DataTextField = "TenLoai";
            ddlLoai.DataValueField = "ID";
            ddlLoai.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            ResetForm();
            lblFormTitle.Text = "Thêm Sản Phẩm Mới";
            pnlForm.Visible = true;
            pnlSelectAlert.Visible = false;
        }

        private void ResetForm()
        {
            hdnProductID.Value = "";
            txtTenSP.Text = "";
            txtGia.Text = "";
            txtMoTa.Text = "";
            chkTrangThai.Checked = true;
            imgPreview.Visible = false;
            hdnExistingImage.Value = "";
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int sanPhamId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditProduct")
            {
                DataTable dt = sanPhamBLL.LayDanhSachSanPhamTatCa();
                DataRow[] rows = dt.Select("ID = " + sanPhamId);
                
                if (rows.Length > 0)
                {
                    DataRow row = rows[0];
                    hdnProductID.Value = row["ID"].ToString();
                    txtTenSP.Text = row["TenSP"].ToString();
                    txtGia.Text = Convert.ToDecimal(row["Gia"]).ToString("F0");
                    txtMoTa.Text = row["MoTa"].ToString();
                    ddlLoai.SelectedValue = row["MaLoai"].ToString();
                    
                    bool status = Convert.ToBoolean(row["TrangThai"]);
                    chkTrangThai.Checked = status;

                    string imageName = row["HinhAnh"].ToString();
                    if (!string.IsNullOrEmpty(imageName))
                    {
                        imgPreview.ImageUrl = "../Images/" + imageName;
                        imgPreview.Visible = true;
                        hdnExistingImage.Value = imageName;
                    }
                    else
                    {
                        imgPreview.Visible = false;
                        hdnExistingImage.Value = "";
                    }

                    lblFormTitle.Text = "Chỉnh Sửa Sản Phẩm";
                    pnlForm.Visible = true;
                    pnlSelectAlert.Visible = false;
                }
            }
            else if (e.CommandName == "DeleteProduct")
            {
                if (sanPhamBLL.XoaSanPham(sanPhamId))
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Đã ẩn món ăn thành công!');", true);
                    LoadProducts();
                    pnlForm.Visible = false;
                    pnlSelectAlert.Visible = true;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            SanPhamDTO sp = new SanPhamDTO();
            sp.TenSP = txtTenSP.Text.Trim();
            sp.Gia = Convert.ToDecimal(txtGia.Text.Trim());
            sp.MoTa = txtMoTa.Text.Trim();
            sp.MaLoai = Convert.ToInt32(ddlLoai.SelectedValue);
            sp.TrangThai = chkTrangThai.Checked;

            // Xử lý upload ảnh
            string imageName = hdnExistingImage.Value;
            if (fuHinhAnh.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuHinhAnh.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".png" || ext == ".jpeg" || ext == ".gif" || ext == ".webp")
                    {
                        string fileName = DateTime.Now.Ticks + ext;
                        string savePath = Server.MapPath("~/Images/") + fileName;
                        
                        // Đảm bảo thư mục Images tồn tại
                        string dir = Server.MapPath("~/Images/");
                        if (!Directory.Exists(dir))
                        {
                            Directory.CreateDirectory(dir);
                        }

                        fuHinhAnh.SaveAs(savePath);
                        imageName = fileName;
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Hình ảnh không đúng định dạng (chỉ nhận JPG, PNG, WEBP)!');", true);
                        return;
                    }
                }
                catch (Exception)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Có lỗi xảy ra khi tải ảnh lên!');", true);
                    return;
                }
            }

            sp.HinhAnh = imageName;

            bool isEdit = !string.IsNullOrEmpty(hdnProductID.Value);
            bool success = false;

            if (isEdit)
            {
                sp.ID = Convert.ToInt32(hdnProductID.Value);
                success = sanPhamBLL.CapNhatSanPham(sp);
            }
            else
            {
                success = sanPhamBLL.ThemSanPham(sp);
            }

            if (success)
            {
                string msg = isEdit ? "Cập nhật sản phẩm thành công!" : "Thêm mới sản phẩm thành công!";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + msg + "');", true);
                
                LoadProducts();
                ResetForm();
                pnlForm.Visible = false;
                pnlSelectAlert.Visible = true;
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Lưu sản phẩm thất bại!');", true);
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
