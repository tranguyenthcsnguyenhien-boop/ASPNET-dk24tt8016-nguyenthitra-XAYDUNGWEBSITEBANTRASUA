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

        // --- ADMIN METHODS ---

        public bool KiemTraLoaiCoSanPham(int loaiId)
        {
            return loaiSPDAL.KiemTraLoaiCoSanPham(loaiId);
        }

        public bool ThemLoai(LoaiSPDTO loai)
        {
            if (loai == null || string.IsNullOrEmpty(loai.TenLoai))
                return false;
            return loaiSPDAL.ThemLoai(loai);
        }

        public bool CapNhatLoai(LoaiSPDTO loai)
        {
            if (loai == null || string.IsNullOrEmpty(loai.TenLoai))
                return false;
            return loaiSPDAL.CapNhatLoai(loai);
        }

        public string XoaLoai(int id)
        {
            if (loaiSPDAL.KiemTraLoaiCoSanPham(id))
            {
                return "Không thể xóa danh mục đang chứa sản phẩm!";
            }
            if (loaiSPDAL.XoaLoai(id))
            {
                return "OK";
            }
            return "Có lỗi xảy ra khi xóa danh mục!";
        }
    }
}