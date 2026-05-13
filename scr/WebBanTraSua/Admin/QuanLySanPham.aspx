<%@ Page Title="Quản Lý Sản Phẩm" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="QuanLySanPham.aspx.cs" Inherits="WebBanTraSua.Admin.QuanLySanPham" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Quản Lý Sản Phẩm
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row g-4">
        <!-- Cột trái: Danh sách sản phẩm -->
        <div class="col-lg-8">
            <div class="card border-0 shadow-sm" style="border-radius: 16px;">
                <div class="card-header border-0 bg-white pt-4 px-4 pb-2 d-flex justify-content-between align-items-center">
                    <h5 class="fw-bold m-0" style="color: #2C1E16;">
                        <i class="fa-solid fa-mug-hot text-primary me-2"></i>Danh Sách Thực Đơn
                    </h5>
                    <asp:LinkButton ID="btnAddNew" runat="server" CssClass="btn btn-sm text-white py-2 px-3 fw-bold" 
                        style="background-color: #C87941; border-radius: 10px;" OnClick="btnAddNew_Click">
                        <i class="fa-solid fa-plus me-1"></i> Thêm món mới
                    </asp:LinkButton>
                </div>
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                            CssClass="table table-hover align-middle" GridLines="None"
                            DataKeyNames="ID" OnRowCommand="gvProducts_RowCommand">
                            <Columns>
                                <asp:TemplateField HeaderText="Món ăn">
                                    <ItemTemplate>
                                        <div class="d-flex align-items-center gap-3">
                                            <img src='../Images/<%# Eval("HinhAnh") %>' onerror="this.src='https://images.unsplash.com/photo-1589396575653-c09c794a6c7a?auto=format&fit=crop&w=150&q=80'" class="rounded-3" style="width: 50px; height: 50px; object-fit: cover;" />
                                            <div>
                                                <h6 class="mb-0 fw-bold" style="color: #8c5a2b;"><%# Eval("TenSP") %></h6>
                                                <span class="badge bg-light text-muted border small"><%# Eval("TenLoai") %></span>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Giá bán">
                                    <ItemTemplate>
                                        <span class="fw-bold" style="color: #2C1E16;"><%# Convert.ToDecimal(Eval("Gia")).ToString("N0") %>đ</span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trạng thái">
                                    <ItemTemplate>
                                        <%# Convert.ToBoolean(Eval("TrangThai")) ? 
                                            "<span class='badge bg-success-subtle text-success px-2.5 py-1.5' style='border-radius:20px;'><i class='fa-solid fa-check-circle me-1'></i> Đang bán</span>" : 
                                            "<span class='badge bg-danger-subtle text-danger px-2.5 py-1.5' style='border-radius:20px;'><i class='fa-solid fa-circle-xmark me-1'></i> Hết hàng</span>" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Thao tác" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditProduct" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-primary me-1 btn-action-admin">
                                            <i class="fa-solid fa-pen"></i> Sửa
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteProduct" CommandArgument='<%# Eval("ID") %>' 
                                            CssClass="btn btn-sm btn-outline-danger btn-action-admin"
                                            OnClientClick="return confirm('Bạn có chắc chắn muốn ngưng bán món này không?');">
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

        <!-- Cột phải: Form nhập dữ liệu -->
        <div class="col-lg-4">
            <asp:Panel ID="pnlForm" runat="server" Visible="false">
                <div class="card border-0 shadow-sm" style="border-radius: 16px; background-color: #fdfbf7;">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4" style="color: #2C1E16;">
                            <asp:Label ID="lblFormTitle" runat="server" Text="Thêm Sản Phẩm Mới"></asp:Label>
                        </h5>
                        
                        <asp:HiddenField ID="hdnProductID" runat="server" />
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Tên sản phẩm *</label>
                            <asp:TextBox ID="txtTenSP" runat="server" CssClass="form-control" placeholder="Nhập tên món trà sữa" style="border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTenSP" runat="server" ControlToValidate="txtTenSP" 
                                ErrorMessage="Vui lòng nhập tên sản phẩm!" CssClass="text-danger small fw-bold mt-1 d-block" 
                                Display="Dynamic" ValidationGroup="ValProduct"></asp:RequiredFieldValidator>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Giá bán *</label>
                            <asp:TextBox ID="txtGia" runat="server" CssClass="form-control" placeholder="Nhập giá bán (VD: 35000)" style="border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvGia" runat="server" ControlToValidate="txtGia" 
                                ErrorMessage="Vui lòng nhập giá bán!" CssClass="text-danger small fw-bold mt-1 d-block" 
                                Display="Dynamic" ValidationGroup="ValProduct"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revGia" runat="server" ControlToValidate="txtGia" 
                                ValidationExpression="^\d+$" ErrorMessage="Giá phải là một số nguyên dương!" 
                                CssClass="text-danger small fw-bold mt-1 d-block" Display="Dynamic" ValidationGroup="ValProduct"></asp:RegularExpressionValidator>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Danh mục sản phẩm</label>
                            <asp:DropDownList ID="ddlLoai" runat="server" CssClass="form-select" style="border-radius: 10px;"></asp:DropDownList>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Hình ảnh món *</label>
                            <div class="mb-2">
                                <asp:Image ID="imgPreview" runat="server" class="rounded-3" style="width: 100px; height: 100px; object-fit: cover;" Visible="false" />
                                <asp:HiddenField ID="hdnExistingImage" runat="server" />
                            </div>
                            <asp:FileUpload ID="fuHinhAnh" runat="server" CssClass="form-control" style="border-radius: 10px;" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold text-muted small">Mô tả sản phẩm</label>
                            <asp:TextBox ID="txtMoTa" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Mô tả hương vị, topping kèm theo..." style="border-radius: 10px;"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <div class="form-check form-switch">
                                <asp:CheckBox ID="chkTrangThai" runat="server" CssClass="form-check-input" Checked="true" />
                                <label class="form-check-label fw-semibold text-muted small" for="chkTrangThai">Đang kinh doanh (Đang bán)</label>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnSave" runat="server" Text="Lưu món" ValidationGroup="ValProduct"
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
                        <i class="fa-solid fa-mug-saucer fs-1 mb-3 opacity-25"></i>
                        <p class="mb-0">Hãy bấm <strong>"Thêm món mới"</strong> hoặc <strong>"Sửa"</strong> một sản phẩm để quản lý dữ liệu.</p>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
