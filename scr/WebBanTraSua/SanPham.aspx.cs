using System;
using System.Web.UI.WebControls;
using WebBanTraSua.BLL;

namespace WebBanTraSua
{
    public partial class SanPham : System.Web.UI.Page
    {
        SanPhamBLL sanPhamBLL = new SanPhamBLL();
        LoaiSPBLL loaiSPBLL = new LoaiSPBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDanhMuc();
                LoadSanPham();
            }
        }

        private void LoadDanhMuc()
        {
            rptLoaiSP.DataSource = loaiSPBLL.LayDanhSachLoai();
            rptLoaiSP.DataBind();
        }

        private void LoadSanPham()
        {
            int? catId = null;
            if (Request.QueryString["catId"] != null)
            {
                int id;
                if (int.TryParse(Request.QueryString["catId"], out id))
                {
                    catId = id;
                }
            }

            string search = txtSearch.Text.Trim();
            string sort = ddlSortPrice.SelectedValue;

            rptSanPham.DataSource = sanPhamBLL.LaySanPhamNangCao(catId, search, sort);
            rptSanPham.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadSanPham();
        }

        protected void ddlSortPrice_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSanPham();
        }
    }
}