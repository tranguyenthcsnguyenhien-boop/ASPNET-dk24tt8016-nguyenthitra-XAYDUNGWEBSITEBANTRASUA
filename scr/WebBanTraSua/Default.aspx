<%@ Page Title="Trang Chủ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebBanTraSua._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .hero-section {
            background: linear-gradient(135deg, #fdfbf7 0%, #faedcd 100%);
            padding: 80px 0;
            overflow: hidden;
            position: relative;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            color: #2C1E16;
            line-height: 1.2;
            margin-bottom: 24px;
        }
        
        .hero-title span {
            color: #C87941;
        }

        .hero-img {
            max-width: 100%;
            border-radius: 40px;
            box-shadow: 0 20px 40px rgba(135, 76, 39, 0.15);
            transform: rotate(-3deg);
            transition: transform 0.5s ease;
        }
        
        .hero-img:hover {
            transform: rotate(0) scale(1.02);
        }

        .btn-primary-custom {
            background-color: #C87941;
            color: white;
            padding: 15px 35px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            border: none;
            box-shadow: 0 10px 20px rgba(200, 121, 65, 0.2);
            transition: all 0.3s;
        }

        .btn-primary-custom:hover {
            background-color: #874C27;
            transform: translateY(-3px);
            box-shadow: 0 15px 25px rgba(135, 76, 39, 0.3);
            color: white;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2C1E16;
            text-align: center;
            margin-bottom: 50px;
        }

        /* Giao diện Thẻ Sản phẩm (Card) */
        .product-card {
            border: none;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.04);
            transition: all 0.4s ease;
            background: white;
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(200, 121, 65, 0.12);
        }

        .product-img {
            height: 280px;
            object-fit: cover;
            width: 100%;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            transition: transform 0.5s ease;
        }
        
        .product-card:hover .product-img {
            transform: scale(1.05);
        }

        .price-tag {
            font-family: 'Outfit', sans-serif;
            font-size: 1.4rem;
            font-weight: 700;
            color: #C87941;
        }

        /* Hộp tính năng */
        .feature-box {
            background: white;
            padding: 40px 30px;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.03);
            height: 100%;
            transition: transform 0.3s ease;
        }

        .feature-box:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(200, 121, 65, 0.08);
        }

        .feature-icon {
            width: 75px;
            height: 75px;
            background: #faedcd;
            color: #C87941;
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 24px;
        }
    </style>

    <!-- Bắt đầu Banner (Hero Section) -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-5 mb-lg-0 text-center text-lg-start">
                    <div class="badge bg-white text-dark mb-4 py-2 px-3 rounded-pill shadow-sm" style="font-weight: 600; color: #C87941 !important;">
                        <i class="fa-solid fa-star text-warning"></i> 100% Nguyên liệu tự nhiên
                    </div>
                    <h1 class="hero-title">Đánh thức mọi giác quan cùng <span>Trà Sữa</span></h1>
                    <p class="fs-5 text-muted mb-5 pe-lg-5">Sự hòa quyện hoàn hảo giữa lá trà tinh tuyển và dòng sữa ngọt ngào, mang đến cho bạn trải nghiệm tuyệt vời nhất mỗi ngày.</p>
                    <div class="d-flex gap-3 justify-content-center justify-content-lg-start">
                        <a href="SanPham.aspx" class="btn btn-primary-custom text-decoration-none">
                            Khám phá Menu <i class="fa-solid fa-arrow-right ms-2"></i>
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <!-- Ảnh đã được xóa phông chuẩn PNG -->
                    <img src="Images/hero_banner.png" alt="Ly Trà Sữa Thơm Ngon" class="hero-img img-fluid" />
                </div>
            </div>
        </div>
    </section>

    <!-- Bắt đầu Danh sách Bán chạy -->
    <section class="container py-5 mt-5">
        <h2 class="section-title">Món Bán Chạy Nhất</h2>
        <div class="row g-4">
            <asp:Repeater ID="rptSanPhamBanChay" runat="server">
                <ItemTemplate>
                    <div class="col-md-4">
                        <div class="card product-card h-100">
                            <div class="overflow-hidden" style="height: 280px; display: flex; align-items: center; justify-content: center; background-color: #f8f9fa;">
                                <img src='Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=500&q=80'" class="product-img w-100 h-100" style="object-fit: cover;" alt='<%# Eval("TenSP") %>'>
                            </div>
                            <div class="card-body p-4 text-center">
                                <h5 class="card-title fw-bold fs-4" style="color: #d4a373; min-height: 55px;"><%# Eval("TenSP") %></h5>
                                <p class="card-text text-muted small mb-3">Hương vị tuyệt hảo từ nguyên liệu tự nhiên tươi ngon nhất.</p>
                                <div class="d-flex justify-content-between align-items-center mt-4">
                                    <span class="price-tag"><%# Convert.ToDecimal(Eval("Gia")).ToString("N0") %>đ</span>
                                    <a href='GioHang.aspx?action=add&id=<%# Eval("ID") %>' class="btn btn-outline-dark rounded-circle" style="width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; transition: all 0.3s;" onmouseover="this.style.backgroundColor='#C87941'; this.style.color='white'; this.style.borderColor='#C87941';" onmouseout="this.style.backgroundColor='transparent'; this.style.color='#212529'; this.style.borderColor='#212529';">
                                        <i class="fa-solid fa-plus"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="text-center mt-5">
            <a href="SanPham.aspx" class="text-decoration-none" style="color: #C87941; font-weight: 600; font-size: 1.1rem; border-bottom: 2px solid transparent; transition: all 0.3s;" onmouseover="this.style.borderBottom='2px solid #C87941';" onmouseout="this.style.borderBottom='2px solid transparent';">
                Xem toàn bộ thực đơn <i class="fa-solid fa-arrow-right-long ms-2"></i>
            </a>
        </div>
    </section>

    <!-- Bắt đầu Cam kết chất lượng -->
    <section class="py-5 mt-5" style="background-color: #fefae0;">
        <div class="container py-4">
            <div class="row g-4 text-center">
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fa-solid fa-leaf"></i>
                        </div>
                        <h4 class="fw-bold mb-3" style="color: #2C1E16;">Nguyên liệu sạch</h4>
                        <p class="text-muted mb-0">Cam kết 100% lá trà hữu cơ và trái cây tươi trong ngày, tuyệt đối không sử dụng hóa chất.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fa-solid fa-motorcycle"></i>
                        </div>
                        <h4 class="fw-bold mb-3" style="color: #2C1E16;">Giao hàng 30 phút</h4>
                        <p class="text-muted mb-0">Đội ngũ shipper chuyên nghiệp đảm bảo đồ uống luôn mát lạnh khi đến tay bạn.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="feature-icon">
                            <i class="fa-solid fa-award"></i>
                        </div>
                        <h4 class="fw-bold mb-3" style="color: #2C1E16;">Pha chế độc quyền</h4>
                        <p class="text-muted mb-0">Công thức được nghiên cứu kỹ lưỡng bởi chuyên gia pha chế hàng đầu Đài Loan.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
