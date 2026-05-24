namespace WebBanTraSua.DTO
{
    public class CartItemDTO
    {
        public int ID { get; set; }
        public string TenSP { get; set; }
        public string HinhAnh { get; set; }
        public decimal Gia { get; set; }
        public int SoLuong { get; set; }
        public decimal ThanhTien 
        {
            get { return Gia * SoLuong; }
        }
    }
}