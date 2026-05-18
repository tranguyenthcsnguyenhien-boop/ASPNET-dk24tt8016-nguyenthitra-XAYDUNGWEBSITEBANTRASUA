<%@ Page Title="Đăng Nhập" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="WebBanTraSua.DangNhap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 mt-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg border-0" style="border-radius: 20px;">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="fa-solid fa-user-circle fa-4x mb-3" style="color: #C87941;"></i>
                            <h3 class="fw-bold" style="color: #8c5a2b; font-family: 'Outfit', sans-serif;">Chào Mừng Trở Lại</h3>
                        </div>
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block text-center fw-bold"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label text-muted">Tên đăng nhập</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" style="border-radius: 10px;" required="true"></asp:TextBox>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-muted">Mật khẩu</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" style="border-radius: 10px;" required="true"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnDangNhap" runat="server" Text="Đăng Nhập" CssClass="btn w-100 fw-bold" style="background-color: #C87941; color: white; border-radius: 10px; padding: 12px;" OnClick="btnDangNhap_Click" />
                        
                        <div class="text-center mt-4">
                            <span class="text-muted">Chưa có tài khoản?</span> <a href="DangKy.aspx" style="color: #C87941; font-weight: 600; text-decoration: none;">Đăng ký ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
