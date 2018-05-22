<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="MyReceipts.aspx.vb" Inherits="Advataxes.MyReceipts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">    
    <script  type="text/javascript">

        function createExpense(id) {
            window.location = "reports.aspx?ce=1&rID=" + id + "&empID=" + $("#<%=cboCreateFor.ClientID %>").val();
        }

        function myConfirm(dialogText, okFunc, cancelFunc, dialogTitle) {
            var buttons = {};
            var ok = 'OK';
            var c = 'Cancel';

            buttons[ok] = function () { if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); } $(this).dialog('destroy'); }
            buttons[c] = function () { if (typeof (cancelFunc) == 'function') { setTimeout(cancelFunc, 50); } $(this).dialog('close'); }

            $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                draggable: false,
                modal: true,
                resizable: false,
                width: '400',
                title: dialogTitle || 'Confirm',
                minHeight: 75,
                show: "fade",
                hide: "fade",
                buttons: buttons
            });
        }

        $(document).ready(function () {
            var length = $("#<%=cboViewFor.ClientID %> > option").length;

            if (length > 1) {
                $("#<%=cboViewFor.ClientID %>").show();
                $("#<%=lbl373.ClientID %>").show(); //lblViewFor
                $("#<%=cboCreateFor.ClientID %>").show();
                $("#<%=lbl377.ClientID %>").show(); //lblCreateFor
            }
            else {
                $("#<%=cboViewFor.ClientID %>").hide();
                $("#<%=lbl373.ClientID %>").hide(); //lblViewFor
                $("#<%=cboCreateFor.ClientID %>").hide();
                $("#<%=lbl377.ClientID %>").hide(); //lblCreateFor
            }

            $(".delReceipt").click(function () {
                var record_id = $(this).attr("id");
                var row = $(this).parent("td").parent('tr');
                var puk = $("#<%=hdnPUK.ClientID %>").val();

                myConfirm("Do you want to delete this receipt?",
                    function () {
                        $.ajax({
                            type: "POST",
                            url: "myreceipts.aspx/DeleteReceipt",
                            data: "{'rID': '" + record_id + "','puk': '" + puk + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                row.css("background-color", "red");
                                row.fadeOut(1000, function () {
                                    row.remove();
                                });

                                $("#msg2").hide();
                                $("#msg").show();
                                $("#txtMsg").val("Receipt was deleted");
                            },
                            error: function () {
                                myMsg("There was an error while deleting receipt", function () { return true; }, "Error");
                            }
                        });
                    },
                    function () { return false; }, "Delete");
            });

        });


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
            <asp:HiddenField ID="hdnEmpID" runat="server" />
            <asp:SqlDataSource ID="sqlDelegate" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT * FROM [vEmpWithOpenReport] WHERE ([DELEGATE_EMP_ID] = @EmpID AND ACTIVE=1)">
                 <SelectParameters>
                     <asp:ControlParameter ControlID="hdnEmpID" DefaultValue="0" Name="EmpID" PropertyName="Value" Type="Int32" />
                 </SelectParameters>
            </asp:SqlDataSource>
    <table>
        <tr>
            <td><asp:Label ID="lbl377" class="labelText" runat="server" Text="Create expense for:"></asp:Label>
                <asp:DropDownList ID="cboCreateFor" runat="server" DataSourceID="sqlDelegate" DataTextField="Name" DataValueField="EMP_ID" />                
            </td>
            <td width="30px"></td>
            <td><asp:Label ID="lbl373" class="labelText" runat="server" Text="View receipts for:"></asp:Label>
                <asp:DropDownList ID="cboViewFor" runat="server"  DataSourceID="sqlDelegate" DataTextField="Name" DataValueField="EMP_ID" AutoPostBack="true"  />
            </td>
        </tr>
    </table>
    
    <%If hdnOpenReport.Value = False Then %>
        <div id="msg" class="ui-widget">
		    <div class="ui-state-highlight ui-corner-all" style="padding: 0 .7em;"> 
			    <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
                    <asp:Label ID="lbl420" runat="server" Text="You have no open reports"></asp:Label></p>
		    </div>
	    </div>  
    <%End If%>

    <div style="height:500px; overflow:scroll;">
        <asp:GridView ID="gridViewReceipts" runat="server" AutoGenerateColumns="False" CssClass="mGrid" DataKeyNames="ID" DataSourceID="sqlUploads" EmptyDataText="" ShowHeaderWhenEmpty="true" >
            <Columns>
                <asp:BoundField ItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" InsertVisible="False" ReadOnly="True" HeaderText="374" DataField="ID" ItemStyle-ForeColor="#cd1e1e" SortExpression="ID" />
                <asp:BoundField ItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" InsertVisible="False" ReadOnly="True" HeaderText="Date" DataField="RECEIPT_DATE" DataFormatString="{0:yyyy'-'MM'-'dd}" SortExpression="RECEIPT_DATE" />
                
                <asp:TemplateField ItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" HeaderText="Image" >
                    <ItemTemplate>
                        <a href="MyReceipts.aspx?ImageID=<%# Eval("ID") %>" />
                           <img src="MyReceipts.aspx?ImageID=<%# Eval("ID") %>&resized=1" />
                        </a>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate><input id='<%# Eval("ID") %>' class="button3" type="button" value="<%=hdnCreateExpense.Value %>" onclick="javascript: createExpense(this.id);" <%#IIf(hdnOpenReport.Value = False, "disabled", "") %> /></ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                    <ItemTemplate><a href="#" id='<%# Eval("ID") %>' class="delReceipt" title="<%=hdnDelete.Value %>"><img  border='0' src='/images/del.png' alt='Delete' /></a></ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:HiddenField ID="hdnCreateExpense" runat="server" />

        <asp:SqlDataSource ID="sqlUploads" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
            SelectCommand="SELECT * FROM [tblUploadedReceipt] ORDER BY ID" 
            FilterExpression="EMP_ID={0}" >

            <FilterParameters>                        
                <asp:ControlParameter ControlID="cboViewFor" Name="EMP_ID" PropertyName="SelectedValue" />
            </FilterParameters>              
        </asp:SqlDataSource>
    </div>
    
    <asp:HiddenField ID="hdnPUK" runat="server" Value="0"  />
    <asp:HiddenField ID="hdnOpenReport" runat="server" Value="false"  />
    <asp:HiddenField ID="hdnDelete" runat="server" Value=""  />
    
</asp:Content>