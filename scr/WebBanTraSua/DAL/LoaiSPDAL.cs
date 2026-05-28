using System.Collections.Generic;
using System.Data;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class LoaiSPDAL
    {
        KetNoiDB db = new KetNoiDB();

        public List<LoaiSPDTO> LayDanhSachLoai()
        {
            List<LoaiSPDTO> list = new List<LoaiSPDTO>();
            string sql = "SELECT * FROM tblLoaiSP ORDER BY ThuTu ASC";
            DataTable dt = db.LayDuLieu(sql);
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new LoaiSPDTO
                {
                    ID = int.Parse(row["ID"].ToString()),
                    TenLoai = row["TenLoai"].ToString(),
                    ThuTu = row["ThuTu"] != System.DBNull.Value ? int.Parse(row["ThuTu"].ToString()) : 0
                });
            }
            return list;
        }

        // --- ADMIN METHODS ---

        public bool KiemTraLoaiCoSanPham(int loaiId)
        {
            string sql = "SELECT COUNT(*) FROM tblSanPham WHERE MaLoai = " + loaiId;
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                return int.Parse(dt.Rows[0][0].ToString()) > 0;
            }
            return false;
        }

        public bool ThemLoai(LoaiSPDTO loai)
        {
            string chuoiKetNoi = System.Configuration.ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(chuoiKetNoi))
            {
                string sql = "INSERT INTO tblLoaiSP (TenLoai, ThuTu) VALUES (@TenLoai, @ThuTu)";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@TenLoai", loai.TenLoai);
                    cmd.Parameters.AddWithValue("@ThuTu", loai.ThuTu);
                    
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool CapNhatLoai(LoaiSPDTO loai)
        {
            string chuoiKetNoi = System.Configuration.ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(chuoiKetNoi))
            {
                string sql = "UPDATE tblLoaiSP SET TenLoai = @TenLoai, ThuTu = @ThuTu WHERE ID = @ID";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", loai.ID);
                    cmd.Parameters.AddWithValue("@TenLoai", loai.TenLoai);
                    cmd.Parameters.AddWithValue("@ThuTu", loai.ThuTu);
                    
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool XoaLoai(int id)
        {
            string sql = "DELETE FROM tblLoaiSP WHERE ID = " + id;
            return db.ThucThiLenh(sql);
        }
    }
}