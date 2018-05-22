<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="BulletinBoard.aspx.vb" Inherits="Advataxes.BulletinBoard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    
    
    <script type="text/javascript">

        function myMsg(dialogText, okFunc, dialogTitle) {
            $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                draggable: false,
                modal: true,
                resizable: false,
                width: 400,
                title: dialogTitle || 'Message',
                minHeight: 75,
                buttons: {
                    OK: function () {
                        if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                        $(this).dialog('destroy');
                    }
                }
            });
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////

        function myConfirm(dialogText, okFunc, cancelFunc, dialogTitle) {
            $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                draggable: false,
                modal: true,
                resizable: false,
                width: '400',
                title: dialogTitle || 'Confirm',
                minHeight: 75,
                show: "fade",
                hide: "fade",
                buttons: {
                    OK: function () {
                        if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); }
                        $(this).dialog('destroy');
                    },
                    Cancel: function () {
                        if (typeof (cancelFunc) == 'function') { setTimeout(cancelFunc, 50); }
                        $(this).dialog('close');
                    }
                }
            });
        }
        /////////////////////////////////////////////////////////////////////////////////////////////////////////////

        $(document).ready(function () {
            $("#Row-FileError1").hide();

            $("#<%=FileUpload1.ClientID %>").change(function () {
                var f = $("#<%=FileUpload1.ClientID %>").val().toUpperCase();
                var fType = f.substr(f.length - 3);

                $("#<%=cmdAttachFile.ClientID %>").removeAttr('disabled');

                switch (fType) {
                    case 'LSX': //XLSX file ... only check last 3 characters
                        $("#Row-FileError1").hide();
                        break;
                    case 'XLS':
                        $("#Row-FileError1").hide();
                        break;
                    case 'OCX':  //DOCX file ... only check last 3 characters
                        $("#Row-FileError1").hide();
                        break;
                    case 'DOC':
                        $("#Row-FileError1").hide();
                        break;
                    case 'JPG':
                        $("#Row-FileError1").hide();
                        break;
                    case 'JPEG':
                        $("#Row-FileError1").hide();
                        break;
                    case 'GIF':
                        $("#Row-FileError1").hide();
                        break;
                    case 'PNG':
                        $("#Row-FileError1").hide();
                        break;
                    case 'PDF':
                        $("#Row-FileError1").hide();
                        break;
                    default:
                        $("#Row-FileError1").show();
                        $("#<%=cmdAttachFile.ClientID %>").prop('disabled', 'disabled');
                }
            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            function createBB() {
                var org_id = $("#<%=hdnOrgID.ClientID %>").val();
                var emp_id = $("#<%=hdnEmpID.ClientID %>").val();

                $.ajax({
                    type: "POST",
                    url: "BulletinBoard.aspx/GetBB",
                    data: "{'orgID': '" + org_id + "','empID': '" + emp_id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (returnVal) {
                        if (emp_id == $("#<%=hdnEmpID.ClientID %>").val())
                            s = returnVal.d;
                        else
                            s = '';

                        $(s).appendTo('#BB');
                        $("#BB").fadeIn(500);
                    },
                    error: function () {
                        alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                    }
                });
                return true;
            };
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".delMsg").click(function () {
                var record_id = $(this).attr("id");
                var puk = $("#<%=hdnPUK.ClientID %>").val();
                var row = $(this).parent("td").parent('tr');

                myConfirm($("#<%=hdnDelMsg.ClientID %>").val(),
                    function () {
                        $.ajax({
                            type: "POST",
                            url: "BulletinBoard.aspx/DeleteMessage",
                            data: "{'bbCode': '" + record_id + "','puk': '" + puk + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                row.css("background-color", "red");
                                row.fadeOut(1000, function () {
                                    row.remove();
                                });
                                window.location = "BulletinBoard.aspx?action=deletedMsg";
                            }
                        });
                    }, function () { return false; }, $("#<%=hdnDelete.ClientID %>").val());

            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".attachFile").click(function () {
                $("#Row-FileError1").hide();
                $("#<%=hdnBBCode.ClientID %>").val($(this).attr("id"));
                var mpe = $find('modalAttachFile');
                if (mpe) { mpe.show(); }
            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".cancelAttach").click(function () {
                $("#<%=Fileupload1.ClientID %>").val('');
                var mpe = $find('modalAttachFile');
                if (mpe) { mpe.hide(); }
            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".viewFile").mousedown(function () {
                var id = $(this).attr("id");
                window.open("Receipt.aspx?bbCode=" + id, "Document", "width=1000,height=600,toolbar=yes,scrollbars=yes");
            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".delFile").click(function () {
                var bbCode = $(this).attr("id");

                myConfirm($("#<%=hdnDeleteDoc.ClientID %>").val(),
                    function () {
                        $.ajax({
                            type: "POST",
                            url: "BulletinBoard.aspx/DeleteFile",
                            data: "{'bbCode': '" + bbCode + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                window.location = "BulletinBoard.aspx?action=filedeleted";
                            },
                            error: function () {
                                myMsg("Error#1008: There was an unexpected error", function () { return true; }, "Error");
                            }
                        });
                    }, function () { return false; }, $("#<%=hdnDelete.ClientID %>").val());
            });
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".createMessage").click(function () {
                $("#<%=txtTitle.ClientID %>").val('');
                $("#<%=txtMsg.ClientID %>").val('');
                var mpe = $find('modalCreateMsg');
                if (mpe) { mpe.show(); }
            });


        });

    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager id="ScriptManager1" runat="server" />

    <% If Not IsNothing(Session("msg")) And Session("msg") <> "" Then%>
 	        <div class="ui-widget">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
			          <asp:Label ID="lblMsg" runat="server" ><%=Session("msg")%></asp:Label></p>
		        </div>
	        </div>
            <%Session("msg") = Nothing%>
    <% End If%>

        <asp:SqlDataSource ID="sqlBB" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
            SelectCommand="SELECT * FROM [vBB] WHERE ([ORG_ID] = @ORG_ID) OR ORG_ID=0 ORDER BY BULLETIN_ID DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnOrgID" Name="ORG_ID" PropertyName="Value" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

    <br />
    
    <%If Session("emp").isadmin Then%>
        <a href="#" class="labelText"><img src="../images/new.png"  title="<%=hdnAdd.value %>" class="createMessage" /></a>&nbsp;&nbsp;&nbsp;
    <%End If%>      
    
    <!--<span style="position:relative;top:-8px;"><asp:Label ID="lbl238"  runat="server" Text="Organization:" CssClass="labelText" />&nbsp;<asp:DropDownList ID="cboOrg" runat="server" Width="300px" Height="23px" DataSourceID="sqlActiveOrgs" DataTextField="ORG_NAME" DataValueField="ORG_ID" AutoPostBack="true" /></span>-->

    <%If Session("emp").isadvalorem Then%>
        <span class="labelText" style="position:relative;top:-7px;display:none;">&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkPostGlobal" runat="server" />Global Advataxes Message</span>
    <%End If%>
            
    <div id="BB">        
    </div>    

    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnEmpOrgID" runat="server" />
    <asp:HiddenField ID="hdnOrgName" runat="server" />
    <asp:HiddenField ID="hdnEmpID" runat="server" />
    <asp:HiddenField ID="hdnPUK" runat="server" />
    <asp:HiddenField ID="hdnAdd" runat="server" />
    <asp:HiddenField ID="hdnDelete" runat="server" />
    <asp:HiddenField ID="hdnDeleteDoc" runat="server" />
    <asp:HiddenField ID="hdnViewDoc" runat="server" />
    <asp:HiddenField ID="hdnBBCODE" runat="server" />
    <asp:HiddenField ID="hdnAttachDoc" runat="server" />
    <asp:HiddenField ID="hdnDelMsg" runat="server" />
    <asp:HiddenField ID="hdnCancel" runat="server" />

    <asp:SqlDataSource ID="sqlOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetOrgs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlActiveOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetActiveOrgs" SelectCommandType="StoredProcedure">
        <SelectParameters>            
            <asp:ControlParameter ControlID="hdnEmpOrgID" Name="OrgID" PropertyName="value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <div style=" overflow:scroll; height:500px;">
         <asp:GridView ID="gvBB" runat="server"
            AutoGenerateColumns="False"
            GridLines="None"
            AllowPaging="false"
            CssClass="mGrid"
            PagerStyle-CssClass="pgr"
            AlternatingRowStyle-CssClass="alt" 
            SelectedRowStyle-CssClass="sel"
            AllowSorting="True" 
            CellPadding="4" 
            DataSourceID="sqlBB"  
            HeaderStyle-ForeColor="White" 
            ForeColor="White" 
            BackColor="White" 
            BorderColor="#DEDFDE" 
            BorderStyle="None" 
            BorderWidth="1px" 
            Width="99.5%"
            DataKeyNames="BULLETIN_ID" 
            EmptyDataText="No messages to display" 
            ShowHeaderWhenEmpty="True" 
            ViewStateMode="Enabled">

            <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
            <Columns>
                <asp:TemplateField  ItemStyle-Width="15%" HeaderText="370">
                        <ItemTemplate>
                           <font color="#cd1e1e"> <%# Format(Eval("BULLETIN_DATE"),"dd/MM/yyyy")%></font>  <br />                               
                           <font color="blue"><%# Eval("POSTED_BY")%></font><br />
                           <i><font color="blue"><%# Eval("ORG_NAME")%></font></i>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField  ItemStyle-Width="80%" HeaderText="Message">
                        <ItemTemplate>
                           <b><font color="#cd1e1e"><%# Eval("BULLETIN_TITLE")%></font></b><br /><br />    
                           <%# Eval("BULLETIN_MSG")%>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField  ItemStyle-Width="1%" >
                        <ItemTemplate>
                            <a href="#" id='<%# Eval("BULLETIN_CODE") %>' class="<%# IIf(not isdbnull(Eval("BB_FILE")),"viewFile",iif(session("emp").isadmin,"attachFile",""))%>"><%# IIf(Eval("POSTED_BY_EMP") = Session("emp").id And IsDBNull(Eval("BB_FILE")), "<img  border='0' src='../Images/attachment1.png' title='" + hdnAttachDoc.value + "' />", IIf(Not IsDBNull(Eval("BB_FILE")), "<img  border='0' src='../Images/doc.jpg' title='" + hdnViewDoc.Value + "' />" & IIf(Eval("POSTED_BY_EMP") = Session("emp").id, "<br><a id='" + Eval("BULLETIN_CODE") + "' href='#' class='delFile' style='color:#cd1e1e;'>" + hdnDelete.Value + "</a>", ""), ""))%> </a>
                        </ItemTemplate>
                    </asp:TemplateField>
            
                    <asp:TemplateField  ItemStyle-Width="1%">
                        <ItemTemplate>
                            <a href="#" id='<%# Eval("BULLETIN_CODE") %>' class="delMsg"><%# IIf(Eval("POSTED_BY_EMP") = Session("emp").id, "<img  border='0' src='../Images/del.png' alt='Delete' title='" & hdnDelete.Value & "' />", "")%> </a>
                        </ItemTemplate>
                    </asp:TemplateField>

            </Columns>
        
            <EmptyDataRowStyle Height="20px" />
            <HeaderStyle ForeColor="White" Height="20px"></HeaderStyle>
            <RowStyle Height="20px" />
        </asp:GridView>

        <asp:Panel ID="pnlAttachFile" runat="server" CssClass="modalPopup" style="display:none" Width="500px">
            <table style="width:100%; border-collapse:collapse;"><tr style=" border-bottom:medium solid #cd1e1e;"><td  style="color:#cd1e1e; font-size:1.5em; font-weight:bold;"><%=hdnAttachDoc.Value%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table>
            <table width="100%" border=0>               
                <tr><td colspan="2"><asp:Label ID="lbl486" runat="server" Text="Label" />:<asp:FileUpload ID="FileUpload1" runat="server" Width="100%" size="40" Height="25px" /></td></tr>
                <tr id="Row-FileError1" style="height:20px;"><td  colspan="2"><asp:Label ID="Label7" ForeColor="#cd1e1e" Font-Bold="true" runat="server" Text="Invalid file type, supported files include jpg, png, gif, pdf, doc/docx, xls/xlsx"></asp:Label></td></tr>            
            </table>
        
            <table width="95%"><tr><td align="right"><br /><asp:Button ID="cmdAttachFile" runat="server" Text="140" Height="30px" class="button1" CausesValidation="true" ValidationGroup="Attach" />&nbsp;&nbsp;&nbsp;<input id="Button1" type="button" class="cancelAttach" style="width:80px;height:30px" value="<%=hdnCancel.value %>" /></td></tr></table>
   
        </asp:Panel>

        <asp:Panel ID="pnlCreateMsg" runat="server" CssClass="modalPopup" Height="300px" style="display:none" Width="500px">
            <table style="width:100%; border-collapse:collapse;"><tr style=" border-bottom:medium solid #cd1e1e;"><td  style="color:#cd1e1e; font-size:1.5em; font-weight:bold;"><asp:Label ID="lbl461" runat="server" Text="Label"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table>
            <br />
            <table width="100%">
                <tr><td width="15%"><asp:Label ID="lbl293" runat="server" Text="Title" CssClass="labelText"></asp:Label></td><td><asp:TextBox ID="txtTitle" runat="server" Width="98%"></asp:TextBox></td></tr>
                <tr><td><asp:Label ID="lblBBMsg" runat="server" Text="Message"  CssClass="labelText"></asp:Label></td></tr>
                <tr>
                    <td colspan="2"><asp:TextBox ID="txtMsg" runat="server" TextMode="MultiLine" Width="98%" Height="100px"></asp:TextBox></td>
                </tr>
                <tr><td></td><td align="right">
                    <br />
                    <asp:Button ID="cmdSave" runat="server" Text="140" CssClass="button2" />
                    <asp:Button ID="cmdCancel" runat="server" Text="142" CssClass="button2" />
                </td></tr>
            </table>
        </asp:Panel>

             <act:ModalPopupExtender ID="modalAttachFile" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlAttachFile"
                drag="false"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalAttachFile" />

             <act:ModalPopupExtender ID="modalCreateMsg" runat="server"
                TargetControlID="cmdDummy"
                PopupControlID="pnlCreateMsg"
                drag="false"
                DropShadow="false"
                BackgroundCssClass="modalBackground" 
                BehaviorID="modalCreateMsg" />

        
        <table style="display:none;"><tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr></table>

    </div>
</asp:Content>
