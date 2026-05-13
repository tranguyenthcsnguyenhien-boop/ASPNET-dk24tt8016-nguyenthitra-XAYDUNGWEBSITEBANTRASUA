<%@ Page Title="Quản Lý Người Dùng" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyKhachHang.aspx.cs" Inherits="WebBanTraSua.Admin.QuanLyKhachHang" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Quản Lý Tài Khoản
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row g-4">
        <!-- Cột duy nhất hiển thị danh sách người dùng rộng rãi -->
        <div class="col-12">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-2 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-users text-warning me-2"></i>Danh Sách Tài Khoản Người Dùng
                    </h5>
                    <span class="badge rounded-pill px-3 py-2 fw-bold text-dark bg-warning-subtle" style="background-color: #fff3cd; color: #856404;">
                        Tổng số: <asp:Label ID="lblUserCount" runat="server">0</asp:Label> thành viên
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover align-middle" GridLines="None"
                            DataKeyNames="ID" OnRowCommand="gvUsers_RowCommand" OnRowDataBound="gvUsers_RowDataBound">
                            <Columns>
                                <asp:TemplateField HeaderText="Mã số">
                                    <ItemTemplate>
                                        <span class="fw-bold text-muted">#<%# Eval("ID") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Họ và Tên">
                                    <ItemTemplate>
                                        <span class="fw-bold" style="color: #8c5a2b;"><%# Eval("FullName") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tên đăng nhập">
                                    <ItemTemplate>
                                        <span class="badge bg-light text-dark border px-2.5 py-1.5 fw-semibold"><%# Eval("Username") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <%# string.IsNullOrEmpty(Eval("Email").ToString()) ? "<em class='text-muted small'>Chưa thiết lập</em>" : Eval("Email") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Số điện thoại">
                                    <ItemTemplate>
                                        <%# string.IsNullOrEmpty(Eval("Phone").ToString()) ? "<em class='text-muted small'>Chưa thiết lập</em>" : Eval("Phone") %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vai trò">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleBadge" runat="server" CssClass="badge px-3 py-2 rounded-pill fw-bold" 
                                            Text='<%# Eval("Role") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Hành động chuyển đổi">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnToggleRole" runat="server" CommandName="ToggleRole" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-warning btn-action-admin me-1" style="border-radius: 8px; font-weight: 600;">
                                            <i class="fa-solid fa-arrows-spin-reverse"></i> Chuyển quyền
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Gỡ bỏ tài khoản" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteUser" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-danger btn-action-admin" style="border-radius: 8px;"
                                            OnClientClick="return confirm('Bạn có thực sự muốn xóa vĩnh viễn tài khoản người dùng này không? Hành động này không thể hoàn tác!');">
                                            <i class="fa-solid fa-trash-can"></i> Xóa tài khoản
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
