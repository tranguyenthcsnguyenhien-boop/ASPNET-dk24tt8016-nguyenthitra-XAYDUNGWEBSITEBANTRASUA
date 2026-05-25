using System;

namespace WebBanTraSua.DTO
{
    public class DonHangDTO
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        public DateTime NgayDat { get; set; }
        public decimal TongTien { get; set; }
        public string TrangThai { get; set; }
        public string DiaChiGiao { get; set; }
    }
}
