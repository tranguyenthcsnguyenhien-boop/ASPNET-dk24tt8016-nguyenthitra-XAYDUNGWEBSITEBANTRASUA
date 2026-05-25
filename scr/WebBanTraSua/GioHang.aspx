<%@ Page Title="Giỏ Hàng" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GioHang.aspx.cs" Inherits="WebBanTraSua.GioHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 mt-4">
        <h2 class="fw-bold mb-4" style="color: #2C1E16;">Giỏ Hàng Của Bạn</h2>
        
        <asp:Label ID="lblThongBao" runat="server" CssClass="alert alert-warning d-block fs-5" Visible="false"></asp:Label>
        
        <asp:Panel ID="pnlGioHang" runat="server">
            <div class="row">
                <div class="col-lg-8">
                    <div class="card border-0 shadow-sm" style="border-radius: 20px;">
                        <div class="card-body p-4">
                            <table class="table align-middle">
                                <thead>
                                    <tr class="text-muted">
                                        <th scope="col" style="width: 5%;">Chọn</th>
                                        <th scope="col" style="width: 40%;">Sản phẩm</th>
                                        <th scope="col" style="width: 15%;">Đơn giá</th>
                                        <th scope="col" style="width: 20%;">Số lượng</th>
                                        <th scope="col" style="width: 15%;">Thành tiền</th>
                                        <th scope="col" style="width: 5%;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="rptGioHang" runat="server" OnItemCommand="rptGioHang_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkChon" runat="server" AutoPostBack="true" OnCheckedChanged="chkChon_CheckedChanged" CssClass="form-check-input fs-5" />
                                                    <asp:HiddenField ID="hdnID" runat="server" Value='<%# Eval("ID") %>' />
                                                    <asp:HiddenField ID="hdnThanhTien" runat="server" Value='<%# Eval("ThanhTien") %>' />
                                                </td>
                                                <td>
                                                    <div class="d-flex align-items-center gap-3">
                                                        <img src='Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=500&q=80'" class="rounded-3" style="width: 80px; height: 80px; object-fit: cover;" />
                                                        <div>
                                                            <h6 class="mb-0 fw-bold" style="color: #8c5a2b;"><%# Eval("TenSP") %></h6>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="fw-bold"><%# Convert.ToDecimal(Eval("Gia")).ToString("N0") %>đ</td>
                                                <td>
                                                    <div class="input-group input-group-sm" style="width: 110px;">
                                                        <asp:LinkButton ID="btnGiam" runat="server" CommandName="Giam" CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-outline-secondary px-3">-</asp:LinkButton>
                                                        <input type="text" class="form-control text-center px-1 fw-bold bg-white" value='<%# Eval("SoLuong") %>' readonly />
                                                        <asp:LinkButton ID="btnTang" runat="server" CommandName="Tang" CommandArgument='<%# Eval("ID") %>' CssClass="btn btn-outline-secondary px-3">+</asp:LinkButton>
                                                    </div>
                                                </td>
                                                <td class="fw-bold" style="color: #C87941;"><%# Convert.ToDecimal(Eval("ThanhTien")).ToString("N0") %>đ</td>
                                                <td>
                                                    <asp:LinkButton ID="btnXoa" runat="server" CommandName="Xoa" CommandArgument='<%# Eval("ID") %>' CssClass="text-danger border-0 bg-transparent" OnClientClick="return confirm('Bạn có chắc muốn bỏ món này?');"><i class="fa-solid fa-trash fs-5"></i></asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 mt-4 mt-lg-0">
                    <div class="card border-0 shadow-sm" style="border-radius: 20px; background-color: #fdfbf7;">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4" style="color: #2C1E16;">Tóm tắt đơn hàng</h5>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Tổng phụ</span>
                                <span class="fw-bold"><asp:Label ID="lblTongTienPhu" runat="server"></asp:Label></span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span class="text-muted">Phí giao hàng</span>
                                <span class="fw-bold text-success">Miễn phí</span>
                            </div>
                            <hr />
                            <div class="d-flex justify-content-between mb-4">
                                <span class="fw-bold fs-5">Tổng cộng</span>
                                <span class="fw-bold fs-4" style="color: #C87941;"><asp:Label ID="lblTongTien" runat="server"></asp:Label></span>
                            </div>
                            <asp:LinkButton ID="btnThanhToan" runat="server" CssClass="btn w-100 fw-bold shadow-sm mb-3" style="background-color: #C87941; color: white; border-radius: 10px; padding: 14px;" OnClick="btnThanhToan_Click">Tiến hành thanh toán</asp:LinkButton>
                            <a href="SanPham.aspx" class="btn btn-outline-dark w-100 fw-bold" style="border-radius: 10px; padding: 12px;">Tiếp tục mua hàng</a>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>