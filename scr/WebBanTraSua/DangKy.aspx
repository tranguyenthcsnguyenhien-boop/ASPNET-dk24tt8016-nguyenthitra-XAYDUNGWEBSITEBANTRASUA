<%@ Page Title="Đăng Ký" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DangKy.aspx.cs" Inherits="WebBanTraSua.DangKy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5 mt-4">
        <div class="row justify-content-center">
            <div class="col-md-5">
                <div class="card shadow-lg border-0" style="border-radius: 20px;">
                    <div class="card-body p-5">
                        <h3 class="text-center mb-4 fw-bold" style="color: #8c5a2b; font-family: 'Outfit', sans-serif;">Đăng Ký Thành Viên</h3>
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block text-center fw-bold"></asp:Label>

                        <div class="mb-3">
                            <label class="form-label text-muted">Họ và tên</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" style="border-radius: 10px;" required="true"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">Tên đăng nhập</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" style="border-radius: 10px;" required="true"></asp:TextBox>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-muted">Mật khẩu</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" style="border-radius: 10px;" required="true"></asp:TextBox>
                        </div>
                        <asp:Button ID="btnDangKy" runat="server" Text="Đăng Ký Ngay" CssClass="btn w-100 fw-bold" style="background-color: #C87941; color: white; border-radius: 10px; padding: 12px;" OnClick="btnDangKy_Click" />
                        
                        <div class="text-center mt-4">
                            <span class="text-muted">Đã có tài khoản?</span> <a href="DangNhap.aspx" style="color: #C87941; font-weight: 600; text-decoration: none;">Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
