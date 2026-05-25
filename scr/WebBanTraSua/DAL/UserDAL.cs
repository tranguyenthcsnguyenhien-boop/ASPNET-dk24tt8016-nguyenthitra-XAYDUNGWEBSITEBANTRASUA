using System.Data;
using System.Data.SqlClient;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class UserDAL
    {
        KetNoiDB db = new KetNoiDB();

        public bool KiemTraDangNhap(string username, string password, out UserDTO user)
        {
            user = null;
            string sql = $"SELECT * FROM tblUser WHERE Username = '{username}' AND Password = '{password}'";
            DataTable dt = db.LayDuLieu(sql);
            if (dt.Rows.Count > 0)
            {
                user = new UserDTO();
                user.ID = (int)dt.Rows[0]["ID"];
                user.Username = dt.Rows[0]["Username"].ToString();
                user.FullName = dt.Rows[0]["FullName"].ToString();
                user.Role = dt.Rows[0]["Role"].ToString();
                return true;
            }
            return false;
        }

        public bool DangKy(UserDTO user)
        {
            string sql = $"INSERT INTO tblUser(Username, Password, FullName, Role) VALUES(N'{user.Username}', '{user.Password}', N'{user.FullName}', 'Customer')";
            return db.ThucThiLenh(sql);
        }
        
        public bool KiemTraTonTai(string username)
        {
            string sql = $"SELECT * FROM tblUser WHERE Username = '{username}'";
            return db.LayDuLieu(sql).Rows.Count > 0;
        }
    }
}
