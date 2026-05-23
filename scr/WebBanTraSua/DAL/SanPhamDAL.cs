using System.Data;

namespace WebBanTraSua.DAL
{
    public class SanPhamDAL
    {
        KetNoiDB db = new KetNoiDB();

        public DataTable LayDanhSachSanPham()
        {
            string sql = "SELECT * FROM tblSanPham WHERE TrangThai = 1";
            return db.LayDuLieu(sql);
        }

        public DataTable LaySanPhamTheoLoai(int maLoai)
        {
            string sql = "SELECT * FROM tblSanPham WHERE TrangThai = 1 AND MaLoai = " + maLoai;
            return db.LayDuLieu(sql);
        }

        public DataTable LaySanPhamBanChay(int top)
        {
            string sql = $"SELECT TOP {top} * FROM tblSanPham WHERE TrangThai = 1 ORDER BY ID DESC";
            return db.LayDuLieu(sql);
        }
    }
}

