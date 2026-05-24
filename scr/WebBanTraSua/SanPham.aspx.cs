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
            if (Request.QueryString["catId"] != null)
            {
                int catId = int.Parse(Request.QueryString["catId"]);
                rptSanPham.DataSource = sanPhamBLL.LaySanPhamTheoLoai(catId);
            }
            else
            {
                rptSanPham.DataSource = sanPhamBLL.LayDanhSachSanPham();
            }
            rptSanPham.DataBind();
        }
    }
}