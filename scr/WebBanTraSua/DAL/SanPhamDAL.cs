using System.Data;

namespace WebBanTraSua.DAL
{
    public class SanPhamDAL
    {
        KetNoiDB db = new KetNoiDB();

        public DataTable LayDanhSachSanPham()
        {
            string sql = "SELECT * FROM tblSanPham";
            return db.LayDuLieu(sql);
        }

        public DataTable LaySanPhamTheoLoai(int maLoai)
        {
            string sql = "SELECT * FROM tblSanPham WHERE MaLoai = " + maLoai;
            return db.LayDuLieu(sql);
        }

        public DataTable LaySanPhamNangCao(int? maLoai, string search, string sortPrice)
        {
            string sql = "SELECT * FROM tblSanPham WHERE 1=1";
            if (maLoai.HasValue && maLoai.Value > 0)
            {
                sql += " AND MaLoai = " + maLoai.Value;
            }
            if (!string.IsNullOrEmpty(search))
            {
                sql += " AND TenSP LIKE N'%" + search.Replace("'", "''") + "%'";
            }
            
            if (sortPrice == "low")
            {
                sql += " ORDER BY Gia ASC";
            }
            else if (sortPrice == "high")
            {
                sql += " ORDER BY Gia DESC";
            }
            else
            {
                sql += " ORDER BY ID DESC";
            }
            return db.LayDuLieu(sql);
        }

        public DataTable LaySanPhamBanChay(int top)
        {
            string sql = $"SELECT TOP {top} * FROM tblSanPham ORDER BY ID DESC";
            return db.LayDuLieu(sql);
        }

        // --- ADMIN METHODS ---

        public DataTable LayDanhSachSanPhamTatCa()
        {
            string sql = "SELECT sp.*, l.TenLoai FROM tblSanPham sp JOIN tblLoaiSP l ON sp.MaLoai = l.ID";
            return db.LayDuLieu(sql);
        }

        public bool ThemSanPham(DTO.SanPhamDTO sp)
        {
            string chuoiKetNoi = System.Configuration.ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(chuoiKetNoi))
            {
                string sql = "INSERT INTO tblSanPham (MaLoai, TenSP, Gia, HinhAnh, MoTa, TrangThai) " +
                             "VALUES (@MaLoai, @TenSP, @Gia, @HinhAnh, @MoTa, @TrangThai)";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@MaLoai", sp.MaLoai);
                    cmd.Parameters.AddWithValue("@TenSP", sp.TenSP);
                    cmd.Parameters.AddWithValue("@Gia", sp.Gia);
                    cmd.Parameters.AddWithValue("@HinhAnh", sp.HinhAnh ?? (object)System.DBNull.Value);
                    cmd.Parameters.AddWithValue("@MoTa", sp.MoTa ?? (object)System.DBNull.Value);
                    cmd.Parameters.AddWithValue("@TrangThai", sp.TrangThai);
                    
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool CapNhatSanPham(DTO.SanPhamDTO sp)
        {
            string chuoiKetNoi = System.Configuration.ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(chuoiKetNoi))
            {
                string sql = "UPDATE tblSanPham SET MaLoai = @MaLoai, TenSP = @TenSP, Gia = @Gia, " +
                             "HinhAnh = @HinhAnh, MoTa = @MoTa, TrangThai = @TrangThai WHERE ID = @ID";
                using (System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", sp.ID);
                    cmd.Parameters.AddWithValue("@MaLoai", sp.MaLoai);
                    cmd.Parameters.AddWithValue("@TenSP", sp.TenSP);
                    cmd.Parameters.AddWithValue("@Gia", sp.Gia);
                    cmd.Parameters.AddWithValue("@HinhAnh", sp.HinhAnh ?? (object)System.DBNull.Value);
                    cmd.Parameters.AddWithValue("@MoTa", sp.MoTa ?? (object)System.DBNull.Value);
                    cmd.Parameters.AddWithValue("@TrangThai", sp.TrangThai);
                    
                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        public bool XoaSanPham(int id)
        {
            // Thuc hien xoa mem de bao toan lich su don hang cu
            string sql = "UPDATE tblSanPham SET TrangThai = 0 WHERE ID = " + id;
            return db.ThucThiLenh(sql);
        }
    }
}

