using System.Data;
using WebBanTraSua.DAL;

namespace WebBanTraSua.BLL
{
    public class SanPhamBLL
    {
        SanPhamDAL dal = new SanPhamDAL();

        public DataTable LayDanhSachSanPham()
        {
            return dal.LayDanhSachSanPham();
        }

        public DataTable LaySanPhamBanChay(int top = 3)
        {
            return dal.LaySanPhamBanChay(top);
        }
    }
}

