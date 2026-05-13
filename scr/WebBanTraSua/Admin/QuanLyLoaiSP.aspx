<%@ Page Title="Quản Lý Danh Mục" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLyLoaiSP.aspx.cs" Inherits="WebBanTraSua.Admin.QuanLyLoaiSP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Quản Lý Danh Mục
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row g-4">
        <!-- Cột trái: Bảng danh sách danh mục -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-2 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-tags text-primary me-2"></i>Danh Mục Loại Trà Sữa
                    </h5>
                    <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-sm text-white py-2 px-3 fw-bold" 
                        style="background-color: #C87941; border-radius: 10px;" OnClick="btnAddNew_Click">
                        <i class="fa-solid fa-plus me-1"></i> Thêm loại mới
                    </asp:LinkButton>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover align-middle" GridLines="None"
                            DataKeyNames="ID" OnRowCommand="gvCategories_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Mã loại">
                                    <ItemTemplate>
                                        <span class="fw-bold text-muted">#<%# Eval("ID") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tên danh mục">
                                    <ItemTemplate>
                                        <span class="fw-bold" style="color: #8c5a2b;"><%# Eval("TenLoai") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thứ tự hiển thị">
                                    <ItemTemplate>
                                        <span class="badge bg-light text-dark border px-2.5 py-1.5"><%# Eval("ThuTu") %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thao tác" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditCategory" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-primary me-1 btn-action-admin">
                                            <i class="fa-solid fa-pen"></i> Sửa
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteCategory" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-danger btn-action-admin"
                                            OnClientClick="return confirm('Bạn có thực sự muốn xóa danh mục này?');">
                                            <i class="fa-solid fa-trash-can"></i> Xóa
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>

        <!-- Cột phải: Form quản trị nhanh -->
        <div class="col-lg-4">
            <asp:Panel ID="pnlForm" runat="server" Visible="false">
                <div class="card border-0 shadow-sm" style="border-radius: 16px; background-color: #fdfbf7;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4" style="color: #2C1E16;">
                            <asp:Label ID="lblFormTitle" runat="server" Text="Thêm Loại Mới"></asp:Label>
                        </h5>
                        
                        <asp:HiddenField ID="hdnCategoryID" runat="server" />
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Tên danh mục *</label>
                            <asp:TextBox ID="txtTenLoai" runat="server" CssClass="form-control" placeholder="Nhập tên danh mục (VD: Trà Đậm Vị)" style="border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTenLoai" runat="server" ControlToValidate="txtTenLoai" 
                                ErrorMessage="Vui lòng nhập tên danh mục!" CssClass="text-danger small fw-bold mt-1 d-block" 
                                Display="Dynamic" ValidationGroup="ValCategory"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-semibold text-muted small">Thứ tự hiển thị *</label>
                            <asp:TextBox ID="txtThuTu" runat="server" CssClass="form-control" placeholder="Nhập số thứ tự sắp xếp" style="border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvThuTu" runat="server" ControlToValidate="txtThuTu" 
                                ErrorMessage="Vui lòng nhập số thứ tự hiển thị!" CssClass="text-danger small fw-bold mt-1 d-block" 
                                Display="Dynamic" ValidationGroup="ValCategory"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revThuTu" runat="server" ControlToValidate="txtThuTu" 
                                ValidationExpression="^\d+$" ErrorMessage="Thứ tự hiển thị phải là số nguyên dương!" 
                                CssClass="text-danger small fw-bold mt-1 d-block" Display="Dynamic" ValidationGroup="ValCategory"></asp:RegularExpressionValidator>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Lưu lại" ValidationGroup="ValCategory"
                                CssClass="btn flex-grow-1 text-white fw-bold shadow-sm py-2.5" style="background-color: #C87941; border-radius: 10px;" 
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Hủy" CausesValidation="false"
                                CssClass="btn btn-outline-secondary py-2.5" style="border-radius: 10px;" 
                                OnClick="btnCancel_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlSelectAlert" runat="server">
                <div class="card border-0 shadow-sm p-4 text-center text-muted" style="border-radius: 16px; border: 2px dashed rgba(0,0,0,0.05) !important;">
                    <div class="py-5">
                        <i class="fa-solid fa-tags fs-1 mb-3 opacity-25"></i>
                        <p class="mb-0">Hãy bấm <strong>"Thêm loại mới"</strong> hoặc <strong>"Sửa"</strong> để thiết lập các nhóm thực đơn.</p>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
