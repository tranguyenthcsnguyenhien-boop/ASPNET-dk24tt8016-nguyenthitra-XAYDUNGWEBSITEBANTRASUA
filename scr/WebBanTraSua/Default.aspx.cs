using System;
using System.Data;
using WebBanTraSua.BLL;

namespace WebBanTraSua
{
    public partial class _Default : System.Web.UI.Page
    {
        SanPhamBLL sanPhamBLL = new SanPhamBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSanPhamBanChay();
            }
        }

        private void LoadSanPhamBanChay()
        {
            DataTable dt = sanPhamBLL.LaySanPhamBanChay(3);
            if (dt.Rows.Count > 0)
            {
                rptSanPhamBanChay.DataSource = dt;
                rptSanPhamBanChay.DataBind();
            }
        }
    }
}
