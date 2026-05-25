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
    }
}
