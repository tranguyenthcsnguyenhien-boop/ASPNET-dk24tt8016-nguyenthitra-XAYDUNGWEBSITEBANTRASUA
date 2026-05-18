using System;
using System.Data;
using WebBanTraSua.BLL;

namespace WebBanTraSua
{
    public partial class SanPham : System.Web.UI.Page
    {
        SanPhamBLL sanPhamBLL = new SanPhamBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPham();
            }
        }

        private void LoadSanPham()
        {
            DataTable dt = sanPhamBLL.LayDanhSachSanPham();
            
            if (dt.Rows.Count > 0)
            {
                rptSanPham.DataSource = dt;
                rptSanPham.DataBind();
            }
        }
    }
}
