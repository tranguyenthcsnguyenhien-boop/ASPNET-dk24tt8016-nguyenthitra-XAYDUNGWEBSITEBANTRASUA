<%@ Page Title="Liên Hệ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebBanTraSua.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Google Fonts for premium typography -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .contact-section {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #fdfbf7;
            color: #2C1E16;
        }
        
        .contact-title {
            font-family: 'Outfit', sans-serif;
            font-weight: 800;
            color: #8c5a2b;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Profile Card Styling */
        .member-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(200, 121, 65, 0.05);
            border: 1px solid rgba(200, 121, 65, 0.08);
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            overflow: hidden;
            position: relative;
        }

        .member-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, #C87941, #E2B15B);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .member-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(200, 121, 65, 0.12);
            border-color: rgba(200, 121, 65, 0.2);
        }

        .member-card:hover::before {
            opacity: 1;
        }

        .avatar-wrapper {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: linear-gradient(135deg, #fff3eb, #ffe6d4);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            font-size: 2rem;
            color: #C87941;
            box-shadow: 0 8px 20px rgba(200, 121, 65, 0.08);
            border: 2px solid #ffffff;
            transition: all 0.3s ease;
        }

        .member-card:hover .avatar-wrapper {
            transform: scale(1.08);
            background: linear-gradient(135deg, #C87941, #874C27);
            color: #ffffff;
        }

        .role-badge {
            background-color: #fff5ec;
            color: #C87941;
            font-size: 0.75rem;
            font-weight: 700;
            padding: 6px 14px;
            border-radius: 30px;
            display: inline-block;
            margin-bottom: 15px;
            letter-spacing: 0.5px;
        }

        .btn-mail {
            background-color: #C87941;
            color: #ffffff !important;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(200, 121, 65, 0.2);
        }

        .btn-mail:hover {
            background-color: #874C27;
            transform: translateY(-1px);
            box-shadow: 0 6px 18px rgba(200, 121, 65, 0.3);
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(0,0,0,0.02);
            box-shadow: 0 4px 15px rgba(0,0,0,0.01);
        }

        .info-icon {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            background-color: #fff9f5;
            color: #C87941;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
    </style>

    <div class="contact-section py-5">
        <div class="container py-4">
            
            <!-- Tiêu đề chính trang nhã -->
            <div class="text-center mb-5">
                <span class="badge bg-warning-subtle text-warning-emphasis px-3 py-2 rounded-pill fw-bold text-uppercase small mb-2" style="background-color: #fff3cd; color: #856404;">Kết Nối Ngay</span>
                <h2 class="contact-title display-5 mb-3">Liên Hệ Với Ban Phát Triển</h2>
                <p class="text-muted mx-auto" style="max-width: 600px;">
                    Mọi ý kiến đóng góp, phản hồi về chất lượng dịch vụ hoặc hỗ trợ kỹ thuật liên quan đến hệ thống bán trà sữa <strong>Oolong Tea Premium</strong>, xin vui lòng gửi trực tiếp đến các thành viên ban phát triển dưới đây.
                </p>
            </div>

            <!-- Khối 3 thẻ thành viên cực kỳ Premium -->
            <div class="row g-4 mb-5 justify-content-center">
                <!-- Thành viên 1: Trà -->
                <div class="col-lg-4 col-md-6">
                    <div class="member-card text-center p-4 h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="avatar-wrapper">
                                <i class="fa-solid fa-leaf"></i>
                            </div>
                            <span class="role-badge">DATABASE ARCHITECT</span>
                            <h4 class="fw-bold mb-1" style="color: #2C1E16; font-family: 'Outfit', sans-serif;">Nguyễn Thị Trà</h4>
                            <p class="text-muted small mb-4">Trưởng nhóm dự án & Quản trị Cơ sở dữ liệu, phụ trách cấu trúc dữ liệu giao dịch.</p>
                        </div>
                        <div>
                            <p class="text-secondary small text-truncate mb-3" title="tranguyenthcsnguyenhien@gmail.com">
                                <i class="fa-regular fa-envelope me-1 text-muted"></i> tranguyenthcsnguyenhien@gmail.com
                            </p>
                            <a href="mailto:tranguyenthcsnguyenhien@gmail.com" class="btn btn-mail py-2.5 w-100">
                                <i class="fa-solid fa-paper-plane me-2"></i> Gửi Thư Cho Trà
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Thành viên 2: Hải -->
                <div class="col-lg-4 col-md-6">
                    <div class="member-card text-center p-4 h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="avatar-wrapper">
                                <i class="fa-solid fa-mug-hot"></i>
                            </div>
                            <span class="role-badge">BACKEND DEVELOPER</span>
                            <h4 class="fw-bold mb-1" style="color: #2C1E16; font-family: 'Outfit', sans-serif;">Phan Việt Hải</h4>
                            <p class="text-muted small mb-4">Lập trình viên Logic & Xử lý nghiệp vụ chính, hoàn thiện các thuật toán sắp xếp nâng cao.</p>
                        </div>
                        <div>
                            <p class="text-secondary small text-truncate mb-3" title="lehai.lita6@gmail.com">
                                <i class="fa-regular fa-envelope me-1 text-muted"></i> lehai.lita6@gmail.com
                            </p>
                            <a href="mailto:lehai.lita6@gmail.com" class="btn btn-mail py-2.5 w-100">
                                <i class="fa-solid fa-paper-plane me-2"></i> Gửi Thư Cho Hải
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Thành viên 3: Quyên -->
                <div class="col-lg-4 col-md-6">
                    <div class="member-card text-center p-4 h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="avatar-wrapper">
                                <i class="fa-solid fa-wand-magic-sparkles"></i>
                            </div>
                            <span class="role-badge">UI/UX FRONTEND DESIGNER</span>
                            <h4 class="fw-bold mb-1" style="color: #2C1E16; font-family: 'Outfit', sans-serif;">Nguyễn Thị Ngọc Quyên</h4>
                            <p class="text-muted small mb-4">Nhà thiết kế giao diện & Trải nghiệm khách hàng, kiến tạo phong cách Oolong sang trọng.</p>
                        </div>
                        <div>
                            <p class="text-secondary small text-truncate mb-3" title="ngothingocquyen.thtanthanha.lp@soctrang.edu.vn">
                                <i class="fa-regular fa-envelope me-1 text-muted"></i> ngothingocquyen.thtanthanha.lp...
                            </p>
                            <a href="mailto:ngothingocquyen.thtanthanha.lp@soctrang.edu.vn" class="btn btn-mail py-2.5 w-100">
                                <i class="fa-solid fa-paper-plane me-2"></i> Gửi Thư Cho Quyên
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Thông tin bổ sung cửa hàng & bản đồ -->
            <div class="row g-4 mt-2">
                <div class="col-lg-5">
                    <div class="h-100 d-flex flex-column gap-3">
                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-solid fa-map-location-dot"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Trụ sở chính</h6>
                                <p class="text-muted small mb-0">Số 1 Võ Văn Ngân, Linh Chiểu, Thủ Đức, TP. Hồ Chí Minh</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-solid fa-phone-volume"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Đường dây nóng</h6>
                                <p class="text-muted small mb-0">034.567.8999 / (028) 3896 8641</p>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="info-icon">
                                <i class="fa-solid fa-clock"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Gi giờ mở cửa</h6>
                                <p class="text-muted small mb-0">Tất cả các ngày trong tuần: 7:00 AM - 10:00 PM</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-7">
                    <div class="card border-0 shadow-sm overflow-hidden h-100" style="border-radius: 20px; min-height: 220px; border: 1px solid rgba(200, 121, 65, 0.08);">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.4854676757134!2d106.76930267570438!3d10.85063235781447!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1m3!1d3918.4854676757134!2d106.76930267570438!3d10.85063235781447!2m2!1d106.77187759999999!2d10.8506323!3m2!1i1024!2i768!4f13.1!5e0!3m2!1svi!2s!4v1700000000000!5m2!1svi!2s" 
                            width="100%" height="100%" style="border:0; min-height: 220px;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
