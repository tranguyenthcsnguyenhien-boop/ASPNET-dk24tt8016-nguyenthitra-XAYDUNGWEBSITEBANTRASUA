namespace WebBanTraSua.DTO
{
    public class SanPhamDTO
    {
        public int ID { get; set; }
        public int MaLoai { get; set; }
        public string TenSP { get; set; }
        public decimal Gia { get; set; }
        public string HinhAnh { get; set; }
        public string MoTa { get; set; }
        public bool TrangThai { get; set; }
    }
}
