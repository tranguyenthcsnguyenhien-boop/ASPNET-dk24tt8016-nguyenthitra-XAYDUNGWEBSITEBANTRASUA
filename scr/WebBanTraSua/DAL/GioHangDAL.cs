using System.Collections.Generic;
using System.Data;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class GioHangDAL
    {
        KetNoiDB db = new KetNoiDB();

        public List<CartItemDTO> LayGioHang(int userId)
        {
            List<CartItemDTO> list = new List<CartItemDTO>();
            string sql = "SELECT gh.SanPhamID as ID, sp.TenSP, sp.HinhAnh, sp.Gia, gh.SoLuong " +
                         "FROM tblGioHang gh " +
                         "JOIN tblSanPham sp ON gh.SanPhamID = sp.ID " +
                         "WHERE gh.UserID = " + userId;
            DataTable dt = db.LayDuLieu(sql);
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new CartItemDTO
                {
                    ID = int.Parse(row["ID"].ToString()),
                    TenSP = row["TenSP"].ToString(),
                    HinhAnh = row["HinhAnh"].ToString(),
                    Gia = decimal.Parse(row["Gia"].ToString()),
                    SoLuong = int.Parse(row["SoLuong"].ToString())
                });
            }
            return list;
        }

        public void ThemVaoGio(int userId, int sanPhamId, int soLuong)
        {
            string checkSql = "SELECT SoLuong FROM tblGioHang WHERE UserID = " + userId + " AND SanPhamID = " + sanPhamId;
            DataTable dt = db.LayDuLieu(checkSql);
            if (dt.Rows.Count > 0)
            {
                int soLuongCu = int.Parse(dt.Rows[0]["SoLuong"].ToString());
                int soLuongMoi = soLuongCu + soLuong;
                string updateSql = "UPDATE tblGioHang SET SoLuong = " + soLuongMoi + 
                                   " WHERE UserID = " + userId + " AND SanPhamID = " + sanPhamId;
                db.ThucThiLenh(updateSql);
            }
            else
            {
                string insertSql = "INSERT INTO tblGioHang (UserID, SanPhamID, SoLuong) VALUES (" + 
                                   userId + ", " + sanPhamId + ", " + soLuong + ")";
                db.ThucThiLenh(insertSql);
            }
        }

        public void CapNhatSoLuong(int userId, int sanPhamId, int soLuongMoi)
        {
            if (soLuongMoi <= 0)
            {
                XoaKhoiGio(userId, sanPhamId);
            }
            else
            {
                string sql = "UPDATE tblGioHang SET SoLuong = " + soLuongMoi + 
                             " WHERE UserID = " + userId + " AND SanPhamID = " + sanPhamId;
                db.ThucThiLenh(sql);
            }
        }

        public void XoaKhoiGio(int userId, int sanPhamId)
        {
            string sql = "DELETE FROM tblGioHang WHERE UserID = " + userId + " AND SanPhamID = " + sanPhamId;
            db.ThucThiLenh(sql);
        }

        public int DemSoLuongMon(int userId)
        {
            string sql = "SELECT COUNT(*) FROM tblGioHang WHERE UserID = " + userId;
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                return int.Parse(dt.Rows[0][0].ToString());
            }
            return 0;
        }
    }
}