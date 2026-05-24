using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebBanTraSua.DAL
{
    public class KetNoiDB
    {
        private string chuoiKetNoi = ConfigurationManager.ConnectionStrings["WebBanTraSua_ConnectionString"].ConnectionString;

        private SqlConnection MoKetNoi()
        {
            SqlConnection conn = new SqlConnection(chuoiKetNoi);
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
            }
            return conn;
        }

        public DataTable LayDuLieu(string sql)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = MoKetNoi())
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            return dt;
        }

        public bool ThucThiLenh(string sql)
        {
            try
            {
                using (SqlConnection conn = MoKetNoi())
                {
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        int ketQua = cmd.ExecuteNonQuery();
                        return ketQua > 0;
                    }
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}

