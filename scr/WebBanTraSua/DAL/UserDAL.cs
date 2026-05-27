using System.Data;
using System.Data.SqlClient;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class UserDAL
    {
        KetNoiDB db = new KetNoiDB();

        private string MaHoaSHA256(string input)
        {
            if (string.IsNullOrEmpty(input)) return "";
            using (System.Security.Cryptography.SHA256 sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(input));
                System.Text.StringBuilder builder = new System.Text.StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        public bool KiemTraDangNhap(string username, string password, out UserDTO user)
        {
            user = null;
            string sql = $"SELECT * FROM tblUser WHERE Username = '{username}'";
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                string dbPassword = dt.Rows[0]["Password"].ToString();
                string hashedInput = MaHoaSHA256(password);
                
                // Tuong thich nguoc: Kiem tra khop băm SHA256 HOAC khop text thuong (cho user cu)
                if (dbPassword == hashedInput || dbPassword == password)
                {
                    user = new UserDTO();
                    user.ID = (int)dt.Rows[0]["ID"];
                    user.Username = dt.Rows[0]["Username"].ToString();
                    user.FullName = dt.Rows[0]["FullName"].ToString();
                    user.Role = dt.Rows[0]["Role"].ToString();
                    return true;
                }
            }
            return false;
        }

        public bool DangKy(UserDTO user)
        {
            string hashedPwd = MaHoaSHA256(user.Password);
            string sql = $"INSERT INTO tblUser(Username, Password, FullName, Role) VALUES(N'{user.Username}', '{hashedPwd}', N'{user.FullName}', 'Customer')";
            return db.ThucThiLenh(sql);
        }
        
        public bool KiemTraTonTai(string username)
        {
            string sql = $"SELECT * FROM tblUser WHERE Username = '{username}'";
            return db.LayDuLieu(sql).Rows.Count > 0;
        }

        public UserDTO LayThongTinNguoiDung(int userId)
        {
            string sql = $"SELECT * FROM tblUser WHERE ID = {userId}";
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                UserDTO user = new UserDTO();
                user.ID = (int)dt.Rows[0]["ID"];
                user.Username = dt.Rows[0]["Username"].ToString();
                user.FullName = dt.Rows[0]["FullName"].ToString();
                user.Email = dt.Rows[0]["Email"] != System.DBNull.Value ? dt.Rows[0]["Email"].ToString() : "";
                user.Phone = dt.Rows[0]["Phone"] != System.DBNull.Value ? dt.Rows[0]["Phone"].ToString() : "";
                user.Role = dt.Rows[0]["Role"].ToString();
                return user;
            }
            return null;
        }

        public int DemSoLuongKhachHang()
        {
            string sql = "SELECT COUNT(*) FROM tblUser WHERE Role = 'Customer'";
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                return int.Parse(dt.Rows[0][0].ToString());
            }
            return 0;
        }

        public DataTable LayDanhSachTatCaUser()
        {
            string sql = "SELECT ID, Username, FullName, Email, Phone, Role FROM tblUser ORDER BY Role ASC, Username ASC";
            return db.LayDuLieu(sql);
        }

        public bool CapNhatQuyenUser(int userId, string newRole)
        {
            string sql = $"UPDATE tblUser SET Role = '{newRole}' WHERE ID = {userId}";
            return db.ThucThiLenh(sql);
        }

        public bool XoaUser(int userId)
        {
            string sql = $"DELETE FROM tblUser WHERE ID = {userId}";
            return db.ThucThiLenh(sql);
        }
    }
}
