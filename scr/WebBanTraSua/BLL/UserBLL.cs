using WebBanTraSua.DAL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.BLL
{
    public class UserBLL
    {
        UserDAL dal = new UserDAL();

        public bool KiemTraDangNhap(string username, string password, out UserDTO user)
        {
            return dal.KiemTraDangNhap(username, password, out user);
        }

        public string DangKy(UserDTO user)
        {
            if (dal.KiemTraTonTai(user.Username))
                return "Tên đăng nhập đã tồn tại!";
            
            if (dal.DangKy(user))
                return "OK";
            else
                return "Có lỗi xảy ra khi đăng ký!";
        }

        public UserDTO LayThongTinNguoiDung(int userId)
        {
            return dal.LayThongTinNguoiDung(userId);
        }

        public int DemSoLuongKhachHang()
        {
            return dal.DemSoLuongKhachHang();
        }

        public System.Data.DataTable LayDanhSachTatCaUser()
        {
            return dal.LayDanhSachTatCaUser();
        }

        public bool CapNhatQuyenUser(int userId, string newRole)
        {
            return dal.CapNhatQuyenUser(userId, newRole);
        }

        public bool XoaUser(int userId)
        {
            return dal.XoaUser(userId);
        }
    }
}
