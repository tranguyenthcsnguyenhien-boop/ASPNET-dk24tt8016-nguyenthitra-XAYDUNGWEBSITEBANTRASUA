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

        public DataTable LaySanPhamTheoLoai(int maLoai)
        {
            return dal.LaySanPhamTheoLoai(maLoai);
        }

        public DataTable LaySanPhamBanChay(int top = 3)
        {
            return dal.LaySanPhamBanChay(top);
        }

        public DataTable LaySanPhamNangCao(int? maLoai, string search, string sortPrice)
        {
            return dal.LaySanPhamNangCao(maLoai, search, sortPrice);
        }

        // --- ADMIN METHODS ---

        public DataTable LayDanhSachSanPhamTatCa()
        {
            return dal.LayDanhSachSanPhamTatCa();
        }

        public bool ThemSanPham(DTO.SanPhamDTO sp)
        {
            return dal.ThemSanPham(sp);
        }

        public bool CapNhatSanPham(DTO.SanPhamDTO sp)
        {
            return dal.CapNhatSanPham(sp);
        }

        public bool XoaSanPham(int id)
        {
            return dal.XoaSanPham(id);
        }
    }
}

