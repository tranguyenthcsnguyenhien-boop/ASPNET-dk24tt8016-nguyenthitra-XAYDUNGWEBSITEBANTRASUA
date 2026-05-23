<%@ Page Title="Thực Đơn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="WebBanTraSua.SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container py-5 mt-4">
        <h2 class="text-center mb-5" style="color: #8c5a2b; font-weight: 800; font-family: 'Outfit', sans-serif; text-transform: uppercase;">Thực Đơn Của Chúng Tôi</h2>
        
        <!-- Bắt đầu vòng lặp Repeater để đổ dữ liệu từ SQL -->
        <div class="row g-4">
            <asp:Repeater ID="rptSanPham" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 shadow-sm border-0" style="border-radius: 20px; transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'; this.style.boxShadow='0 15px 35px rgba(200, 121, 65, 0.15)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.04)';">
                            <div style="height: 250px; display: flex; align-items: center; justify-content: center; overflow: hidden; border-radius: 20px 20px 0 0; background-color: #f8f9fa;">
                                <!-- Mẹo nhỏ: Dùng onerror để nếu bạn chưa chép ảnh vào thư mục Images thì web sẽ tự lấy ảnh mạng bù vào, không bị lỗi hình dấu X xấu xí -->
                                <img src='Images/<%# Eval("HinhAnh") %>' 
                                     onerror="this.src='https://images.unsplash.com/photo-1558857563-b37102e99e00?auto=format&fit=crop&w=500&q=80'" 
                                     class="img-fluid w-100 h-100" style="object-fit: cover;" alt='<%# Eval("TenSP") %>' />
                            </div>
                            <div class="card-body text-center p-4" style="background-color: #fffcf5;">
                                <h5 class="card-title fw-bold" style="color: #d4a373; font-size: 1.15rem; min-height: 55px;"><%# Eval("TenSP") %></h5>
                                <p class="fw-bold fs-4 mt-2" style="color: #e63946;"><%# Convert.ToDecimal(Eval("Gia")).ToString("N0") %> đ</p>
                                <a href='ChiTiet.aspx?id=<%# Eval("ID") %>' class="btn btn-outline-dark rounded-pill px-4 py-2 mt-2 w-100 fw-bold" style="transition: all 0.3s;" onmouseover="this.style.backgroundColor='#C87941'; this.style.color='white'; this.style.borderColor='#C87941';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='#212529'; this.style.borderColor='#212529';">
                                    <i class="fa-solid fa-cart-plus"></i> Đặt Mua
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <!-- Kết thúc vòng lặp -->

    </div>

</asp:Content>
