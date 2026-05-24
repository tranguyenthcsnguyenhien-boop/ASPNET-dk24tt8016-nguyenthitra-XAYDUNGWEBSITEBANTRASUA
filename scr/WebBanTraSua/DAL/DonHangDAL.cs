using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class DonHangDAL
    {
        private string chuoiKetNoi = ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;

        public bool LuuDonHang(DonHangDTO donHang, List<ChiTietDonHangDTO> dsChiTiet)
        {
            using (SqlConnection conn = new SqlConnection(chuoiKetNoi))
            {
                conn.Open();
                SqlTransaction trans = conn.BeginTransaction();

                try
                {
                    // 1. Them vao tblDonHang va lay ID moi nhat
                    string sqlDonHang = "INSERT INTO tblDonHang (UserID, NgayDat, TongTien, TrangThai, DiaChiGiao) " +
                                        "VALUES (@UserID, @NgayDat, @TongTien, @TrangThai, @DiaChiGiao); " +
                                        "SELECT SCOPE_IDENTITY();";

                    int donHangId = 0;
                    using (SqlCommand cmd = new SqlCommand(sqlDonHang, conn, trans))
                    {
                        cmd.Parameters.AddWithValue("@UserID", donHang.UserID);
                        cmd.Parameters.AddWithValue("@NgayDat", donHang.NgayDat);
                        cmd.Parameters.AddWithValue("@TongTien", donHang.TongTien);
                        cmd.Parameters.AddWithValue("@TrangThai", donHang.TrangThai);
                        cmd.Parameters.AddWithValue("@DiaChiGiao", donHang.DiaChiGiao);

                        object objId = cmd.ExecuteScalar();
                        if (objId != null)
                        {
                            donHangId = Convert.ToInt32(objId);
                            donHang.ID = donHangId;
                        }
                    }

                    if (donHangId == 0)
                    {
                        trans.Rollback();
                        return false;
                    }

                    // 2. Them vao tblChiTietDonHang cho tung san pham va xoa khoi tblGioHang
                    foreach (var ct in dsChiTiet)
                    {
                        string sqlChiTiet = "INSERT INTO tblChiTietDonHang (DonHangID, SanPhamID, SoLuong, DonGia) " +
                                            "VALUES (@DonHangID, @SanPhamID, @SoLuong, @DonGia)";
                        using (SqlCommand cmd = new SqlCommand(sqlChiTiet, conn, trans))
                        {
                            cmd.Parameters.AddWithValue("@DonHangID", donHangId);
                            cmd.Parameters.AddWithValue("@SanPhamID", ct.SanPhamID);
                            cmd.Parameters.AddWithValue("@SoLuong", ct.SoLuong);
                            cmd.Parameters.AddWithValue("@DonGia", ct.DonGia);
                            cmd.ExecuteNonQuery();
                        }

                        // Xoa mon do trong gio hang cua user nay
                        string sqlXoaGio = "DELETE FROM tblGioHang WHERE UserID = @UserID AND SanPhamID = @SanPhamID";
                        using (SqlCommand cmd = new SqlCommand(sqlXoaGio, conn, trans))
                        {
                            cmd.Parameters.AddWithValue("@UserID", donHang.UserID);
                            cmd.Parameters.AddWithValue("@SanPhamID", ct.SanPhamID);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    trans.Commit();
                    return true;
                }
                catch (Exception)
                {
                    trans.Rollback();
                    return false;
                }
            }
        }

        public DataTable LayLichSuDonHang(int userId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(chuoiKetNoi))
            {
                string sql = "SELECT ID, NgayDat, TongTien, TrangThai, DiaChiGiao FROM tblDonHang WHERE UserID = @UserID ORDER BY NgayDat DESC";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        public DataTable LayChiTietDonHang(int donHangId)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(chuoiKetNoi))
            {
                string sql = "SELECT ct.SanPhamID, sp.TenSP, sp.HinhAnh, ct.SoLuong, ct.DonGia, (ct.SoLuong * ct.DonGia) AS ThanhTien " +
                             "FROM tblChiTietDonHang ct " +
                             "JOIN tblSanPham sp ON ct.SanPhamID = sp.ID " +
                             "WHERE ct.DonHangID = @DonHangId";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@DonHangId", donHangId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }
    }
}
