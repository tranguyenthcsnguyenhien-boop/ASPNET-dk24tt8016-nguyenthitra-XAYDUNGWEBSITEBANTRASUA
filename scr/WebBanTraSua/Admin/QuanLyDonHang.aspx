<%@ Page Title="Quản Lý Đơn Hàng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="WebBanTraSua.Admin.QuanLyDonHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Quản Lý Đơn Hàng
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card border-0 shadow-sm" style="border-radius: 16px;">
        <div class="card-header border-0 bg-white pt-4 px-4 pb-2">
            <h5 class="fw-bold m-0" style="color: #2C1E16;">
                <i class="fa-solid fa-receipt text-primary me-2"></i>Danh Sách Đơn Hàng Hệ Thống
            </h5>
        </div>
        <div class="card-body p-4">
            <div class="table-responsive">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" 
                    CssClass="table table-hover align-middle" GridLines="None"
                    DataKeyNames="ID" OnRowCommand="gvOrders_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Mã ĐH">
                            <ItemTemplate>
                                <span class="fw-bold text-muted">#<%# Eval("ID") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Khách hàng">
                            <ItemTemplate>
                                <div class="fw-bold" style="color: #8c5a2b;"><%# Eval("FullName") %></div>
                                <span class="text-muted small">@<%# Eval("Username") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Ngày đặt">
                            <ItemTemplate>
                                <%# Convert.ToDateTime(Eval("NgayDat")).ToString("dd/MM/yyyy HH:mm") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thông tin nhận hàng">
                            <ItemTemplate>
                                <div class="small text-truncate" style="max-width: 250px;" title='<%# Eval("DiaChiGiao") %>'>
                                    <%# FormatAddress(Eval("DiaChiGiao").ToString()) %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Tổng tiền">
                            <ItemTemplate>
                                <span class="fw-bold" style="color: #2C1E16;"><%# Convert.ToDecimal(Eval("TongTien")).ToString("N0") %>đ</span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trạng thái">
                            <ItemTemplate>
                                <%# GetStatusBadge(Eval("TrangThai").ToString()) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Thao tác" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDetails" runat="server" CommandName="ViewDetails" CommandArgument='<%# Eval("ID") %>' 
                                    CssClass="btn btn-sm btn-outline-secondary btn-action-admin me-1">
                                    <i class="fa-solid fa-eye"></i> Chi tiết
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("ID") %>' 
                                    CssClass="btn btn-sm btn-success btn-action-admin text-white me-1" 
                                    Visible='<%# Eval("TrangThai").ToString() == "Chờ Xử Lý" %>'>
                                    <i class="fa-solid fa-truck-fast"></i> Duyệt giao
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnComplete" runat="server" CommandName="Complete" CommandArgument='<%# Eval("ID") %>' 
                                    CssClass="btn btn-sm btn-primary btn-action-admin text-white me-1" 
                                    Visible='<%# Eval("TrangThai").ToString() == "Đang Giao" %>'>
                                    <i class="fa-solid fa-circle-check"></i> Hoàn thành
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("ID") %>' 
                                    CssClass="btn btn-sm btn-outline-danger btn-action-admin" 
                                    Visible='<%# Eval("TrangThai").ToString() == "Chờ Xử Lý" || Eval("TrangThai").ToString() == "Đang Giao" %>'
                                    OnClientClick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này không?');">
                                    <i class="fa-solid fa-xmark"></i> Hủy
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Bootstrap Modal hiển thị chi tiết đơn hàng cho Admin -->
    <asp:Panel ID="pnlModal" runat="server" Visible="false">
        <div class="modal fade show d-block" id="orderAdminModal" tabindex="-1" style="background: rgba(0,0,0,0.5); z-index: 1050;">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
                    <div class="modal-header border-0 pb-0 pt-4 px-4">
                        <h5 class="modal-title fw-bold" style="color: #2C1E16;">
                            <i class="fa-solid fa-receipt me-2 text-warning"></i>Chi Tiết Đơn Hàng #<asp:Label ID="lblModalOrderID" runat="server"></asp:Label>
                        </h5>
                        <asp:LinkButton ID="btnCloseModal" runat="server" CssClass="btn-close" OnClick="btnCloseModal_Click" CausesValidation="false"></asp:LinkButton>
                    </div>
                    <div class="modal-body p-4">
                        <!-- Danh sách món hàng đã chốt mua -->
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
                                                        <img src='../Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=150&q=80'" class="rounded-2" style="width: 50px; height: 50px; object-fit: cover;" />
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

                        <!-- Chi tiết thông tin giao hàng & Tổng tiền -->
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
</asp:Content>
