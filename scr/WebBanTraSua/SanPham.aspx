<%@ Page Title="Thực Đơn" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SanPham.aspx.cs" Inherits="WebBanTraSua.SanPham" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container py-5 mt-4">
        <h2 class="text-center mb-5" style="color: #8c5a2b; font-weight: 800; font-family: 'Outfit', sans-serif; text-transform: uppercase;">Thực Đơn Của Chúng Tôi</h2>
        
        <!-- Bộ tìm kiếm và Sắp xếp nâng cao -->
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4 p-3 bg-white shadow-sm border-0" style="border-radius: 20px;">
            <!-- Bộ lọc danh mục -->
            <div class="d-flex flex-wrap gap-2">
                <a href="SanPham.aspx" class='btn <%= Request.QueryString["catId"] == null ? "btn-dark" : "btn-outline-dark" %> rounded-pill px-3 py-1.5 fw-bold btn-sm'>Tất cả</a>
                <asp:Repeater ID="rptLoaiSP" runat="server">
                    <ItemTemplate>
                        <a href='SanPham.aspx?catId=<%# Eval("ID") %>' class='btn <%# Request.QueryString["catId"] == Eval("ID").ToString() ? "btn-dark" : "btn-outline-dark" %> rounded-pill px-3 py-1.5 fw-bold btn-sm'>
                            <%# Eval("TenLoai") %>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            
            <!-- Tìm kiếm và Sắp xếp -->
            <div class="d-flex gap-2 flex-grow-1 justify-content-end align-items-center" style="max-width: 600px;">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control form-control-sm py-2 px-3 bg-light border-0" placeholder="Tìm kiếm trà sữa..." style="border-radius: 20px; width: 220px;"></asp:TextBox>
                <asp:LinkButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" CssClass="btn btn-sm text-white px-3 py-2 fw-bold" style="background-color: #C87941; border-radius: 20px;">
                    <i class="fa-solid fa-magnifying-glass"></i>
                </asp:LinkButton>
                
                <asp:DropDownList ID="ddlSortPrice" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSortPrice_SelectedIndexChanged" 
                    CssClass="form-select form-select-sm py-2 px-3 border-0 bg-light" style="border-radius: 20px; width: 180px;">
                    <asp:ListItem Value="default">Sắp xếp: Mặc định</asp:ListItem>
                    <asp:ListItem Value="low">Giá: Thấp đến Cao</asp:ListItem>
                    <asp:ListItem Value="high">Giá: Cao đến Thấp</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <!-- Bắt đầu vòng lặp Repeater để đổ dữ liệu từ SQL -->
        <div class="row g-4">
            <asp:Repeater ID="rptSanPham" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                        <div class="card h-100 shadow-sm border-0" style="border-radius: 20px; transition: all 0.3s;" onmouseover="this.style.transform='translateY(-10px)'; this.style.boxShadow='0 15px 35px rgba(200, 121, 65, 0.15)';" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 10px 30px rgba(0,0,0,0.04)';">
                            <div style="height: 250px; display: flex; align-items: center; justify-content: center; overflow: hidden; border-radius: 20px 20px 0 0; background-color: #f8f9fa; position: relative;">
                                <img src='Images/<%# Eval("HinhAnh") %>' 
                                     onerror="this.src='https://images.unsplash.com/photo-1558857563-b37102e99e00?auto=format&fit=crop&w=500&q=80'" 
                                     class="img-fluid w-100 h-100" style="object-fit: cover;" alt='<%# Eval("TenSP") %>' />
                                
                                <!-- Badge hết hàng nổi lên góc trên ảnh -->
                                <%# Convert.ToBoolean(Eval("TrangThai")) ? "" : "<span class='position-absolute top-0 end-0 bg-secondary text-white px-3 py-1.5 m-3 fw-bold small' style='border-radius: 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.15);'><i class='fa-solid fa-ban me-1'></i> Hết hàng</span>" %>
                            </div>
                            <div class="card-body text-center p-4" style="background-color: #fffcf5;">
                                <h5 class="card-title fw-bold" style="color: #d4a373; font-size: 1.15rem; min-height: 55px;"><%# Eval("TenSP") %></h5>
                                <p class="fw-bold fs-4 mt-2" style="color: #e63946;"><%# Convert.ToDecimal(Eval("Gia")).ToString("N0") %> đ</p>
                                
                                <!-- Hiển thị nút bấm tuỳ trạng thái Đang bán hay Hết hàng -->
                                <%# Convert.ToBoolean(Eval("TrangThai")) ? 
                                    $"<a href='GioHang.aspx?action=add&id={Eval("ID")}' class='btn btn-outline-dark rounded-pill px-4 py-2 mt-2 w-100 fw-bold' style='transition: all 0.3s;' onmouseover=\"this.style.backgroundColor='#C87941'; this.style.color='white'; this.style.borderColor='#C87941';\" onmouseout=\"this.style.backgroundColor='transparent'; this.style.color='#212529'; this.style.borderColor='#212529';\"><i class='fa-solid fa-cart-plus'></i> Đặt Mua</a>" :
                                    "<button class='btn btn-secondary rounded-pill px-4 py-2 mt-2 w-100 fw-bold' style='background-color:#95a5a6; border-color:#95a5a6;' disabled><i class='fa-solid fa-circle-xmark'></i> Hết Hàng</button>" %>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
        <!-- Kết thúc vòng lặp -->

    </div>

</asp:Content>
