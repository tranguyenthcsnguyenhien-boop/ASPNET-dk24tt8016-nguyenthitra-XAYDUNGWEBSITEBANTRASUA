<%@ Page Title="Thanh Toán" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="WebBanTraSua.ThanhToan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 mt-4">
        <asp:Panel ID="pnlThanhToan" runat="server">
            <h2 class="fw-bold mb-4" style="color: #2C1E16;">Thanh Toán Đơn Hàng</h2>
            
            <div class="row">
                <!-- Cột trái: Thông tin nhận hàng -->
                <div class="col-lg-7">
                    <div class="card border-0 shadow-sm mb-4" style="border-radius: 20px;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4" style="color: #8c5a2b;">
                                <i class="fa-solid fa-truck-fast me-2 text-warning"></i>Thông Tin Giao Hàng
                            </h5>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted">Họ và tên người nhận</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control py-2.5" placeholder="Nhập tên người nhận" style="border-radius: 10px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" 
                                    ErrorMessage="Vui lòng nhập tên người nhận!" CssClass="text-danger small mt-1 d-block fw-bold" 
                                    Display="Dynamic" ValidationGroup="Checkout"></asp:RequiredFieldValidator>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted">Số điện thoại</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control py-2.5" placeholder="Nhập số điện thoại giao hàng" style="border-radius: 10px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                                    ErrorMessage="Vui lòng nhập số điện thoại!" CssClass="text-danger small mt-1 d-block fw-bold" 
                                    Display="Dynamic" ValidationGroup="Checkout"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone"
                                    ValidationExpression="^\d{10,11}$" ErrorMessage="Số điện thoại phải từ 10 - 11 chữ số!"
                                    CssClass="text-danger small mt-1 d-block fw-bold" Display="Dynamic" ValidationGroup="Checkout"></asp:RegularExpressionValidator>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label fw-semibold text-muted">Địa chỉ nhận hàng</label>
                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control py-2" placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành..." style="border-radius: 10px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" 
                                    ErrorMessage="Vui lòng nhập địa chỉ nhận hàng!" CssClass="text-danger small mt-1 d-block fw-bold" 
                                    Display="Dynamic" ValidationGroup="Checkout"></asp:RequiredFieldValidator>
                            </div>

                            <hr class="my-4 text-muted opacity-25">
                            
                            <h5 class="fw-bold mb-3" style="color: #8c5a2b;">
                                <i class="fa-regular fa-credit-card me-2 text-warning"></i>Phương thức thanh toán
                            </h5>
                            <div class="mb-3">
                                <div class="card border border-2 border-primary-subtle p-3 mb-2" style="border-radius: 12px; background-color: #faf8f5;">
                                    <div class="form-check d-flex align-items-center gap-2">
                                        <input class="form-check-input mt-0 fs-5" type="radio" name="paymentMethod" id="payCOD" checked />
                                        <label class="form-check-label fw-bold" for="payCOD" style="color: #2C1E16;">
                                            Thanh toán khi nhận hàng (COD)
                                        </label>
                                    </div>
                                    <p class="text-muted small mb-0 ms-4 ps-2 mt-1">
                                        Thanh toán bằng tiền mặt trực tiếp cho shipper khi nhận được hàng.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Cột phải: Tóm tắt đơn hàng -->
                <div class="col-lg-5">
                    <div class="card border-0 shadow-sm mb-4" style="border-radius: 20px; background-color: #fdfbf7;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4" style="color: #2C1E16;">Tóm tắt đơn hàng</h5>
                            
                            <!-- Danh sách sản phẩm mua -->
                            <div class="mb-4" style="max-height: 350px; overflow-y: auto;">
                                <asp:Repeater ID="rptSummary" runat="server">
                                    <ItemTemplate>
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div class="d-flex align-items-center gap-3">
                                                <img src='Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=150&q=80'" class="rounded-2" style="width: 55px; height: 55px; object-fit: cover;" />
                                                <div>
                                                    <h6 class="mb-0 fw-bold small-text" style="color: #8c5a2b; max-width: 180px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><%# Eval("TenSP") %></h6>
                                                    <span class="text-muted small">x<%# Eval("SoLuong") %></span>
                                                </div>
                                            </div>
                                            <span class="fw-bold text-end" style="color: #2C1E16;"><%# (Convert.ToDecimal(Eval("Gia")) * Convert.ToInt32(Eval("SoLuong"))).ToString("N0") %>đ</span>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            
                            <hr class="text-muted opacity-25">
                            
                            <div class="d-flex justify-content-between mb-3 mt-2">
                                <span class="text-muted">Tạm tính</span>
                                <span class="fw-bold"><asp:Label ID="lblTongTienPhu" runat="server"></asp:Label></span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Phí giao hàng</span>
                                <span class="fw-bold text-success">Miễn phí</span>
                            </div>
                            <hr class="text-muted opacity-25">
                            <div class="d-flex justify-content-between mb-4">
                                <span class="fw-bold fs-5">Tổng cộng</span>
                                <span class="fw-bold fs-4" style="color: #C87941;"><asp:Label ID="lblTongTien" runat="server"></asp:Label></span>
                            </div>
                            
                            <asp:Button ID="btnOrder" runat="server" Text="Xác Nhận Đặt Hàng" ValidationGroup="Checkout"
                                CssClass="btn w-100 fw-bold shadow-sm py-3 mb-2" style="background-color: #C87941; color: white; border-radius: 12px; font-size: 1.05rem;" 
                                OnClick="btnOrder_Click" />
                            <a href="GioHang.aspx" class="btn btn-outline-secondary w-100 fw-bold py-2.5 mt-2" style="border-radius: 12px;">
                                Quay lại Giỏ hàng
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- Panel hiển thị khi đặt hàng thành công -->
        <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
            <div class="row justify-content-center py-5">
                <div class="col-md-7 text-center">
                    <div class="card border-0 shadow-sm p-5" style="border-radius: 24px;">
                        <div class="card-body">
                            <div class="mb-4">
                                <i class="fa-solid fa-circle-check text-success" style="font-size: 5rem;"></i>
                            </div>
                            <h2 class="fw-bold mb-3" style="color: #2C1E16;">Đặt Hàng Thành Công!</h2>
                            <p class="text-muted fs-5 mb-4 pe-lg-3 ps-lg-3">
                                Cảm ơn bạn đã lựa chọn Oolong Tea. Đơn hàng của bạn đã được tiếp nhận và đang được chuẩn bị. Chúng tôi sẽ giao hàng trong thời gian sớm nhất!
                            </p>
                            
                            <div class="d-inline-block text-start p-4 bg-light rounded-4 border mb-4 w-100" style="max-width: 500px;">
                                <h6 class="fw-bold mb-3 border-bottom pb-2" style="color: #8c5a2b;">Chi tiết nhận hàng:</h6>
                                <p class="mb-2"><strong>Mã đơn hàng:</strong> #<asp:Label ID="lblOrderCode" runat="server" CssClass="text-danger fw-bold"></asp:Label></p>
                                <p class="mb-2"><strong>Họ tên:</strong> <asp:Label ID="lblSuccessName" runat="server"></asp:Label></p>
                                <p class="mb-2"><strong>Điện thoại:</strong> <asp:Label ID="lblSuccessPhone" runat="server"></asp:Label></p>
                                <p class="mb-2"><strong>Địa chỉ giao:</strong> <asp:Label ID="lblSuccessAddress" runat="server"></asp:Label></p>
                                <p class="mb-0"><strong>Tổng cộng:</strong> <span class="fw-bold text-success"><asp:Label ID="lblSuccessTotal" runat="server"></asp:Label></span></p>
                            </div>
                            
                            <div class="d-flex justify-content-center gap-3 flex-wrap">
                                <a href="SanPham.aspx" class="btn fw-bold px-4 py-2.5 shadow-sm" style="background-color: #C87941; color: white; border-radius: 12px;">
                                    Tiếp tục mua hàng
                                </a>
                                <a href="LichSuMuaHang.aspx" class="btn btn-outline-dark fw-bold px-4 py-2.5" style="border-radius: 12px;">
                                    Lịch sử đơn hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
