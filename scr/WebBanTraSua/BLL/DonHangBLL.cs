using System.Collections.Generic;
using System.Data;
using WebBanTraSua.DAL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.BLL
{
    public class DonHangBLL
    {
        private DonHangDAL dal = new DonHangDAL();

        public bool LuuDonHang(DonHangDTO donHang, List<ChiTietDonHangDTO> dsChiTiet)
        {
            if (donHang == null || dsChiTiet == null || dsChiTiet.Count == 0)
                return false;

            return dal.LuuDonHang(donHang, dsChiTiet);
        }

        public DataTable LayLichSuDonHang(int userId)
        {
            return dal.LayLichSuDonHang(userId);
        }

        public DataTable LayChiTietDonHang(int donHangId)
        {
            return dal.LayChiTietDonHang(donHangId);
        }

        // --- ADMIN METHODS ---

        public DataTable LayTatCaDonHang()
        {
            return dal.LayTatCaDonHang();
        }

        public bool CapNhatTrangThaiDonHang(int donHangId, string trangThaiMoi)
        {
            if (string.IsNullOrEmpty(trangThaiMoi))
                return false;
            return dal.CapNhatTrangThaiDonHang(donHangId, trangThaiMoi);
        }

        public DataTable LayDoanhThu7NgayGanNhat()
        {
            return dal.LayDoanhThu7NgayGanNhat();
        }

        public DataTable LayTrongLuongDoanhThuTheoLoai()
        {
            return dal.LayTrongLuongDoanhThuTheoLoai();
        }
    }
}
