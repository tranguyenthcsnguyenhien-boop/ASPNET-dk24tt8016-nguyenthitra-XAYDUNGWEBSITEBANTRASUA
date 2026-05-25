using System.Collections.Generic;
using System.Linq;
using WebBanTraSua.DAL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.BLL
{
    public class GioHangBLL
    {
        GioHangDAL gioHangDAL = new GioHangDAL();

        public List<CartItemDTO> LayGioHang(int userId)
        {
            return gioHangDAL.LayGioHang(userId);
        }

        public void ThemVaoGio(int userId, int sanPhamId, int soLuong = 1)
        {
            gioHangDAL.ThemVaoGio(userId, sanPhamId, soLuong);
        }

        public void CapNhatSoLuong(int userId, int sanPhamId, int soLuongMoi)
        {
            gioHangDAL.CapNhatSoLuong(userId, sanPhamId, soLuongMoi);
        }

        public void XoaKhoiGio(int userId, int sanPhamId)
        {
            gioHangDAL.XoaKhoiGio(userId, sanPhamId);
        }

        public decimal TinhTongTien(List<CartItemDTO> gioHang)
        {
            return gioHang.Sum(x => x.ThanhTien);
        }

        public int DemSoLuongMon(int userId)
        {
            return gioHangDAL.DemSoLuongMon(userId);
        }
    }
}