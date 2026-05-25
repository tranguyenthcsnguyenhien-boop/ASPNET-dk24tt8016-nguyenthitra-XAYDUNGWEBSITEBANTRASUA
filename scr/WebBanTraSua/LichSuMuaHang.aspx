<%@ Page Title="Lịch Sử Mua Hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LichSuMuaHang.aspx.cs" Inherits="WebBanTraSua.LichSuMuaHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 mt-4">
        <h2 class="fw-bold mb-4" style="color: #2C1E16;">Lịch Sử Mua Hàng Của Bạn</h2>
        
        <asp:Label ID="lblThongBao" runat="server" CssClass="alert alert-info d-block fs-5" Visible="false"></asp:Label>
        
        <asp:Panel ID="pnlOrders" runat="server">
            <div class="card border-0 shadow-sm" style="border-radius: 20px;">
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr class="text-muted">
                                    <th scope="col" style="width: 10%;">Mã ĐH</th>
                                    <th scope="col" style="width: 20%;">Ngày đặt</th>
                                    <th scope="col" style="width: 35%;">Thông tin nhận hàng</th>
                                    <th scope="col" style="width: 15%;">Tổng tiền</th>
                                    <th scope="col" style="width: 10%;">Trạng thái</th>
                                    <th scope="col" style="width: 10%;">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td class="fw-bold text-muted">#<%# Eval("ID") %></td>
                                            <td><%# Convert.ToDateTime(Eval("NgayDat")).ToString("dd/MM/yyyy HH:mm") %></td>
                                            <td class="small">
                                                <div class="text-truncate" style="max-width: 350px;" title='<%# Eval("DiaChiGiao") %>'>
                                                    <%# FormatAddress(Eval("DiaChiGiao").ToString()) %>
                                                </div>
                                            </td>
                                            <td class="fw-bold" style="color: #C87941;"><%# Convert.ToDecimal(Eval("TongTien")).ToString("N0") %>đ</td>
                                            <td>
                                                <%# GetStatusBadge(Eval("TrangThai").ToString()) %>
                                            </td>
                                            <td>
                                                <asp:LinkButton ID="btnDetails" runat="server" CommandName="Details" CommandArgument='<%# Eval("ID") %>' 
                                                    CssClass="btn btn-sm btn-outline-secondary" style="border-radius: 8px;">
                                                    <i class="fa-solid fa-eye me-1"></i> Chi tiết
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- Bootstrap Modal hiển thị chi tiết đơn hàng -->
        <asp:Panel ID="pnlModal" runat="server" Visible="false">
            <div class="modal fade show d-block" id="orderDetailModal" tabindex="-1" style="background: rgba(0,0,0,0.5);">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                        <div class="modal-header border-0 pb-0 pt-4 px-4">
                            <h5 class="modal-title fw-bold" style="color: #2C1E16;">
                                <i class="fa-solid fa-receipt me-2 text-warning"></i>Chi Tiết Đơn Hàng #<asp:Label ID="lblModalOrderID" runat="server"></asp:Label>
                            </h5>
                            <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="btn-close" OnClick="btnCloseModal_Click" CausesValidation="false"></asp:LinkButton>
                        </div>
                        <div class="modal-body p-4">
                            <!-- Danh sách sản phẩm -->
                            <div class="table-responsive mb-3">
                                <table class="table align-middle">
                                    <thead>
                                        <tr class="text-muted">
                                            <th scope="col" style="width: 50%;">Sản phẩm</th>
                                            <th scope="col" style="width: 15%;">Đơn giá</th>
                                            <th scope="col" style="width: 15%;">Số lượng</th>
                                            <th scope="col" style="width: 20%;" class="text-end">Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:Repeater ID="rptOrderDetails" runat="server">
                                            <ItemTemplate>
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center gap-3">
                                                            <img src='Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=150&q=80'" class="rounded-2" style="width: 50px; height: 50px; object-fit: cover;" />
                                                            <h6 class="mb-0 fw-bold small-text" style="color: #8c5a2b;"><%# Eval("TenSP") %></h6>
                                                        </div>
                                                    </td>
                                                    <td class="fw-semibold"><%# Convert.ToDecimal(Eval("DonGia")).ToString("N0") %>đ</td>
                                                    <td><%# Eval("SoLuong") %></td>
                                                    <td class="fw-bold text-end" style="color: #C87941;"><%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %>đ</td>
                                                </tr>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </tbody>
                                </table>
                            </div>

                            <hr class="text-muted opacity-25">

                            <!-- Địa chỉ giao hàng & Tổng tiền -->
                            <div class="row pt-2 g-3">
                                <div class="col-md-7">
                                    <h6 class="fw-bold mb-2 text-muted">Thông tin nhận hàng:</h6>
                                    <div class="p-3 bg-light rounded-3 text-muted small" style="border: 1px solid rgba(0,0,0,0.05);">
                                        <asp:Literal ID="litModalAddress" runat="server"></asp:Literal>
                                    </div>
                                </div>
                                <div class="col-md-5 text-end d-flex flex-column justify-content-center">
                                    <span class="text-muted small">Tạm tính: <asp:Label ID="lblModalSubtotal" runat="server" CssClass="fw-bold text-dark"></asp:Label></span>
                                    <span class="text-muted small">Phí giao hàng: <span class="text-success fw-bold">Miễn phí</span></span>
                                    <div class="mt-2 border-top pt-2">
                                        <span class="fs-6 fw-bold">Tổng cộng: </span>
                                        <span class="fs-4 fw-bold" style="color: #C87941;"><asp:Label ID="lblModalTotal" runat="server"></asp:Label></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-0 pt-0 pb-4 px-4">
                            <asp:Button ID="btnCloseModal2" runat="server" Text="Đóng" CssClass="btn btn-secondary px-4" style="border-radius: 10px;" OnClick="btnCloseModal_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
