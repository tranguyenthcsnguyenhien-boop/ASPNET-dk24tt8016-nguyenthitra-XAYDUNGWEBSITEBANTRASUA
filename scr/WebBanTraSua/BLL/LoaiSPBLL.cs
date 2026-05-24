using System.Collections.Generic;
using WebBanTraSua.DAL;
using WebBanTraSua.DTO;

namespace WebBanTraSua.BLL
{
    public class LoaiSPBLL
    {
        LoaiSPDAL loaiSPDAL = new LoaiSPDAL();

        public List<LoaiSPDTO> LayDanhSachLoai()
        {
            return loaiSPDAL.LayDanhSachLoai();
        }
    }
}