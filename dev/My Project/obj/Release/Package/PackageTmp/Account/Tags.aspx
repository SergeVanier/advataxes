<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Tags.aspx.vb" Inherits="Advataxes.Tags" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link type="text/css" href="/css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
    <script type="text/javascript" src="/js/jquery-ui-1.8.18.custom.min.js"> </script>
    
    <script type="text/javascript">
        if ( $.attrFn ) { $.attrFn.text = true; }

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
                width: '500',
                title: dialogTitle || 'Confirm',
                minHeight: 75,
                show: "fade",
                hide: "fade",
                buttons: buttons
            });  
        }
        //////////////////////////////////////////////////////////////////////////////////////////////////////

        $(document).ready(function () {
                        
            if($("#<%= cboAccType.ClientID %>").val()=='TP')
                $("#HideInactive").show();
            else{                
                $("#HideInactive").hide();
            }

            if($("#<%= hdnIsAdvalorem.ClientID %>").val()=="True"){
                $("#lnkNewAccount").show();
            }else{
                if($("#<%= cboAccType.ClientID %>").val()=='Tax' || $("#<%= cboAccType.ClientID %>").val()=='Employee')
                    $("#lnkNewAccount").hide();
                else
                    $("#lnkNewAccount").show();
            }
            
            $("#tabs").tabs({
                show: function() {
                                var selectedTab = $('#tabs').tabs('option', 'selected');
                                $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);                              
                            },                            
                            selected:<%= hdnSelectedTab.Value %>,
                            select: function(event, ui){ 
                                //var selectedTab = $('#tabs').tabs('option', 'selected');
                                $("#<%= hdnSelectedTab.ClientID %>").val(ui.index);
                            }
                            
            });
            
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            $("#<%= cboVendor.ClientID %>").change(function () {
                var record_id = $("#<%= cboVendor.ClientID %>").val();
                var orgID = $("#<%=hdnOrgID.ClientID %>").val();
                    
                $.ajax({
                    type: "POST",
                    url: "Tags.aspx/CheckVendorExists",
                    data: "{'vendorNum': '" + record_id + "','orgID': '" + orgID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (val) {
                        if (val.d!='0'){                                
                            $("#Row-VendorExists").show();
                            $("#<%=cmdSavePWC.ClientID %>").prop('disabled', 'disabled');
                        }else{
                            $("#Row-VendorExists").hide();
                            $("#<%=cmdSavePWC.ClientID %>").removeAttr('disabled');
                        }
                            
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //alert("error " + textStatus);
                        //alert("incoming Text " + jqXHR.responseText);
                        alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                    }
                });
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%= cboVendorType.ClientID %>").change(function () {
                var record_id;
                var orgID = $("#<%=hdnOrgID.ClientID %>").val();

                $("#Row-VendorExists").hide();
                $("#<%= txtOkToSubmit.ClientID %>").val('True');
                
                if($("#<%= cboVendorType.ClientID %>").val()=="General")
                    $("#<%= cboVendor.ClientID %>").hide();
                else{
                    record_id = $("#<%= cboVendor.ClientID %>").val();
                    $("#<%= cboVendor.ClientID %>").show();
                }
                    
                $.ajax({
                    type: "POST",
                    url: "Tags.aspx/CheckVendorExists",
                    data: "{'vendorNum': '" + record_id + "','orgID': '" + orgID + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (accountID) {
                        //if an ID other than 0 is returned, it means the vendor exists
                        if (accountID.d!='0'){                                
                            $("#Row-VendorExists").show();
                            $("#<%=cmdSavePWC.ClientID %>").prop('disabled', 'disabled');
                        }else{
                            $("#Row-VendorExists").hide();
                            $("#<%=cmdSavePWC.ClientID %>").removeAttr('disabled');
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //alert("error " + textStatus);
                        //alert("incoming Text " + jqXHR.responseText);
                        alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                    }
                });
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////                            
                        
            $("#<%= txtVendor.ClientID %>").keyup(function () {
                    if($("#<%= txtVendor.ClientID %>").val()!='')
                        $("#<%= txtOkToSubmit.ClientID %>").val('True');
                    else
                        $("#<%= txtOkToSubmit.ClientID %>").val('');
                    
                    var record_id = $("#<%= txtVendor.ClientID %>").val();
                    var orgID = $("#<%=hdnOrgID.ClientID %>").val();
                    
                    if (record_id!=''){
                        $.ajax({
                            type: "POST",
                            url: "Tags.aspx/CheckVendorExists",
                            data: "{'vendorNum': '" + record_id + "','orgID': '" + orgID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (accountID) {
                                //if an ID other than 0 is returned, it means the vendor number exists
                                if (accountID.d!='0'){                                
                                    $("#Row-VendorExists").show();
                                    $("#<%=cmdSavePWC.ClientID %>").prop('disabled', 'disabled');
                                }else{
                                   $("#Row-VendorExists").hide();
                                   $("#<%=cmdSavePWC.ClientID %>").removeAttr('disabled');
                                }                            
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                //alert("error " + textStatus);
                                //alert("incoming Text " + jqXHR.responseText);
                                alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                            }
                        });
                    }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////
    
            $("#<%= txtPWCNumber.ClientID %>").keyup(function () {
                    var record_id = $("#<%= txtPWCNumber.ClientID %>").val();
                    var pwcType = $("#<%=hdnPWCType.ClientID %>").val();
                    var orgID = $("#<%=hdnOrgID.ClientID %>").val();
                    
                    $.ajax({
                        type: "POST",
                        url: "Tags.aspx/TagExists",
                        data: "{'pwcNum': '" + record_id + "','pwcType': '" + pwcType + "','orgID': '" + orgID + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (tagID) {
                            //if an ID other than 0 is returned, it means the tag exists
                            if (tagID.d!='0'){                                
                                $("#Row-TagAlreadyExists").show();
                                $("#<%=cmdSavePWC.ClientID %>").prop('disabled', 'disabled');
                            }else{
                               $("#Row-TagAlreadyExists").hide();
                               $("#<%=cmdSavePWC.ClientID %>").removeAttr('disabled');
                            }                            
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //alert("error " + textStatus);
                            //alert("incoming Text " + jqXHR.responseText);
                            alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                        }
                    });
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".newAccount").click(function () {                 
                $("#Row-TagAlreadyExists").hide();
                $("#Row-VendorExists").hide();
                $("#<%=txtVendor.ClientID %>").hide();
                $("#<%=txtVendor.ClientID %>").val('');
                $("#<%=hdnPWCType.ClientID %>").val('A');
                $("#<%=txtPWCNumber.ClientID %>").val('');
                $("#<%=txtPWCDescription.ClientID %>").val('');
                $("#<%=hdnPWCID.ClientID %>").val('0');                
                $("#<%=lblPWC.ClientID %>").text($("#<%=hdnAccount.ClientID %>").val());

                if ($("#<%=cboAccType.ClientID %>").val()=='Advance'){
                    $("#Row-Vendor").show();
                    $("#<%=cboVendorType.ClientID %>").show();
                    
                    if ($("#<%=cboVendorType.ClientID %>").val()=='Emp')
                        $("#<%=cboVendor.ClientID %>").show();
                    else
                        $("#<%=cboVendor.ClientID %>").hide();
                    
                }else if ($("#<%=cboAccType.ClientID %>").val()=='TP'){
                    $("#Row-Vendor").show();
                    $("#<%=txtOkToSubmit.ClientID %>").val('');
                    $("#<%=cboVendorType.ClientID %>").hide();
                    $("#<%=cboVendor.ClientID %>").hide();
                    $("#<%=txtVendor.ClientID %>").show();
                }else
                    $("#Row-Vendor").hide();
                
                var mpe = $find('modalNewPWC');
                if (mpe) { mpe.show(); }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".newDivision").click(function () {                
                $("#Row-TagAlreadyExists").hide();
                $("#Row-VendorExists").hide();
                $("#Row-Vendor").hide();
                $("#<%=txtOkToSubmit.ClientID %>").val('True');
                $("#<%=txtPWCNumber.ClientID %>").val('');
                $("#<%=txtPWCDescription.ClientID %>").val('');
                $("#<%=hdnPWCType.ClientID %>").val('D');
                $("#<%=hdnPWCID.ClientID %>").val('0');
                $("#<%=lblPWC.ClientID %>").text($("#<%=CTD.ClientID %>").text());
                var mpe = $find('modalNewPWC');
                if (mpe) { mpe.show(); }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".newProject").click(function () {
                $("#Row-TagAlreadyExists").hide();
                $("#Row-VendorExists").hide();
                $("#Row-Vendor").hide();
                $("#<%=txtOkToSubmit.ClientID %>").val('True');
                $("#<%=txtPWCNumber.ClientID %>").val('');
                $("#<%=txtPWCDescription.ClientID %>").val('');
                $("#<%=hdnPWCType.ClientID %>").val('P');
                $("#<%=hdnPWCID.ClientID %>").val('0');
                $("#<%=lblPWC.ClientID %>").text($("#<%=CTP.ClientID %>").text());
                var mpe = $find('modalNewPWC');
                if (mpe) { mpe.show(); }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".newWO").click(function () {
                $("#Row-TagAlreadyExists").hide();
                $("#Row-VendorExists").hide();
                $("#Row-Vendor").hide();
                $("#<%=txtOkToSubmit.ClientID %>").val('True');
                $("#<%=lblPWC.ClientID %>").text($("#<%=CTW.ClientID %>").text());
                $("#<%=txtPWCNumber.ClientID %>").val('');
                $("#<%=txtPWCDescription.ClientID %>").val('');
                $("#<%=hdnPWCType.ClientID %>").val('W');
                $("#<%=hdnPWCID.ClientID %>").val('0');
                var mpe = $find('modalNewPWC');
                if (mpe) { mpe.show(); }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".newCC").click(function () {
                $("#Row-TagAlreadyExists").hide();
                $("#Row-VendorExists").hide();
                $("#Row-Vendor").hide();
                $("#<%=txtOkToSubmit.ClientID %>").val('True');
                $("#<%=txtPWCNumber.ClientID %>").val('');
                $("#<%=txtPWCDescription.ClientID %>").val('');
                $("#<%=lblPWC.ClientID %>").text($("#<%=CTC.ClientID %>").text());
                $("#<%=hdnPWCType.ClientID %>").val('C');
                $("#<%=hdnPWCID.ClientID %>").val('0');
                var mpe = $find('modalNewPWC');
                if (mpe) { mpe.show(); }
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".setActiveAcc").click(function () {
                    var record_id = $(this).attr("id");                                        
                    var match = /unchecked/.test(document.getElementById('activeAcc' + record_id).src);
                    var sMessage;

                    if (match)
                        sMessage = $("#<%=hdnActiveAccount.ClientID %>").val();
                    else
                        sMessage = $("#<%=hdnInactiveAccount.ClientID %>").val();
                    myConfirm(sMessage, function(){
                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Tags.aspx/SetActiveAcc",
                            //Pass the selected record id
                            data: "{'accID': '" + record_id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                
                                var match = /unchecked/.test(document.getElementById('activeAcc' + record_id).src);

                                if (match){
                                    document.getElementById('activeAcc' + record_id).src = '../images/checked.png';
                                }
                                else{
                                    document.getElementById('activeAcc' + record_id).src = '../images/unchecked.png';
                                }
                            },
                            error: function(){
                                alert($("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"Status");
            });
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            $(".setActivePWC").click(function () {
                //Get the Id of the record to delete
                var record_id = $(this).attr("id");
                var puk = $("#<%=hdnPUK.ClientID %>").val();
                var match = /unchecked/.test(document.getElementById('activePWC' + record_id).src);
                var sMessage;

                if (match)
                    sMessage = $("#<%=hdnActivePWCMsg.ClientID %>").val();
                else
                    sMessage = $("#<%=hdnInactivePWCMsg.ClientID %>").val();

                myConfirm(sMessage, function () {
                    $.ajax({
                        type: "POST",
                        //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                        url: "Tags.aspx/SetActivePWC",
                        //Pass the selected record id
                        data: "{'pwcID': '" + record_id + "','puk': '" + puk + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function () {
                            var match = /unchecked/.test(document.getElementById('activePWC' + record_id).src);

                            if (match)
                                document.getElementById('activePWC' + record_id).src = '/images/checked.png';
                            else
                                document.getElementById('activePWC' + record_id).src = '/images/unchecked.png';
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            //alert("error " + textStatus);
                            //alert("incoming Text " + jqXHR.responseText);
                            alert('There was an error. Refresh your browser or re-login and try again. Contact your administrator if you require help.');
                        }
                    });
                },
                    function () { return false; }, "Active");
            });
        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
        <asp:ScriptManager id="ScriptManager1" runat="server"  /> 
        <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" /> 

        <div id="HideInactive" style=" position:relative;top:5px; text-align:right;">
            <asp:Label ID="lbl378" runat="server" Text="378" CssClass="labelText" />
            <asp:DropDownList ID="cboHideInactive" runat="server" AutoPostBack="true" >
                <asp:ListItem Value="1" Text="Active" />
                <asp:ListItem Value="0" Text="Inactive" />
            </asp:DropDownList>
        </div>               

       <div id="tabs" style=" position:relative;top:10px; height:950px;">
       
 			<ul>
                <li><a href="#tabs-accounts"><asp:Label ID="lbl381" runat="server" Text="Accounts" /></a></li>
                <li <%If not Session("emp").organization.parent.displaydivision Then%> style="display:none;"<%end if %>><a href="#tabs-division"><asp:Label ID="CTD" runat="server" Text="Division" /></a></li>
                <li <%If not Session("emp").organization.parent.displayproject Then%> style="display:none;"<%end if %>><a href="#tabs-projects"><asp:Label ID="CTP" runat="server" Text="Project" /></a></li>
                <li <%If not Session("emp").organization.parent.displaycostcenter Then%> style="display:none;"<%end if %>><a href="#tabs-cc"><asp:Label ID="CTC" runat="server" Text="Cost Center" /></a></li>
                <li <%If not Session("emp").organization.parent.displayworkorder Then%> style="display:none;"<%end if %>><a href="#tabs-wo"><asp:Label ID="CTW" runat="server" Text="Work Order" /></a></li>
                <li <%If not Session("emp").isadvalorem Then%> style="display:none;"<%end if %>><a href="#tabs-custom"><asp:Label ID="Label3" runat="server" Text="Custom" /></a></li>
			</ul>
            
            <div id="tabs-custom">
                <table width="60%">
                    <tr><td width="70%"></td><td class="labelText">English</td><td  class="labelText">French</td></tr>
                    <tr><td><asp:Label runat="server" Text="Custom Tag for Project" CssClass="labelText" /></td><td><asp:TextBox ID="txtCustomTagProject_English" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagProject_English" runat="server" /></td><td><asp:TextBox ID="txtCustomTagProject_French" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagProject_French" runat="server" /></td></tr>
                    <tr><td><asp:Label runat="server" Text="Custom Tag for Cost Center" CssClass="labelText" /></td><td><asp:TextBox ID="txtCustomTagCostCenter_English" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagCostCenter_English" runat="server" /></td><td><asp:TextBox ID="txtCustomTagCostCenter_French" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagCostCenter_French" runat="server" /></td></tr>
                    <tr><td><asp:Label runat="server" Text="Custom Tag for Work Order" CssClass="labelText" /></td><td><asp:TextBox ID="txtCustomTagWorkOrder_English" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagWorkOrder_English" runat="server" /></td><td><asp:TextBox ID="txtCustomTagWorkOrder_French" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagWorkOrder_French" runat="server" /></td></tr>
                    <tr><td><asp:Label runat="server" Text="Custom Tag for Department" CssClass="labelText" /></td><td><asp:TextBox ID="txtCustomTagDivision_English" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagDivision_English" runat="server" /></td><td><asp:TextBox ID="txtCustomTagDivision_French" runat="server"></asp:TextBox><asp:HiddenField ID="hdnCustomTagDivision_French" runat="server" /></td></tr>
                    <tr><td align="right" colspan="3"><br /><asp:Button ID="cmdSaveCustom" runat="server" Text="Save" class="button2" /></td></tr>
                </table>
            </div>

            <div id="tabs-division">               
                <div style="overflow:scroll;height:840px; width:100%;">   
                    <a href="#" class="newDivision"><img src="../../images/new.png" title="<%=hdnAdd.value %>" /></a><div style=" position:relative;top:-22px;left:28px;"><a href="#" class="newDivision"><asp:Label ID="Label2" runat="server" Text="Add" class="labelText" Visible="false"></asp:Label></a></div>
                    <asp:GridView ID="gvDivision" runat="server" 
                        AutoGenerateColumns="False"
                        DataSourceID="sqlGetDivisions" Width="96%" DataKeyNames="PWC_ID" 
                        EmptyDataText="No Divisions" 
                        CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt" 
                        SelectedRowStyle-CssClass="sel"
                        HeaderStyle-ForeColor="White"
                        PagerStyle-ForeColor="White"
                        ShowHeader="true" ShowHeaderWhenEmpty="true" >
                                
                        <Columns>
                            <asp:BoundField  DataField="PWC_NUMBER" HeaderText="CTD" ItemStyle-ForeColor="Black"  />
                            <asp:BoundField  DataField="PWC_DESCRIPTION" HeaderText="Description" ItemStyle-ForeColor="Black" ItemStyle-Width="80%" />

                           <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate><a href="#" id="<%# Eval("PWC_ID") %>" class="setActivePWC" ><img id='activePWC<%# Eval("PWC_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                            
                        <EditRowStyle BackColor="#FFFF99" />
                        <HeaderStyle ForeColor="White" />
                        <SelectedRowStyle CssClass="sel" />
                    </asp:GridView>
                </div>
            </div>


            <div id="tabs-accounts" >
                
                <asp:Label ID="lblType" runat="server" Text="Type" CssClass="labelText" />
                <asp:DropDownList ID="cboAccType" runat="server" AutoPostBack="true" >
                    <asp:ListItem Value="Advance">Cash Advance</asp:ListItem> 
                    <asp:ListItem Value="Employee">Employee Payable</asp:ListItem>                                
                    <asp:ListItem Value="TP">Other Payable</asp:ListItem> 
                    <asp:ListItem Value="Tax">Tax Payable</asp:ListItem>                                
                    <asp:ListItem Value="Expense">Expense</asp:ListItem>
                    
                    
                </asp:DropDownList>
                <a id="lnkNewAccount" href="#" class="newAccount" title="Add Account" style="position:relative;top:7px;"><img src="../images/new.png" /></a>

                <div style=" overflow: scroll;height:400px;">
                    <asp:GridView CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            SelectedRowStyle-CssClass="sel"
                            ID="gvAccounts" runat="server" 
                            AllowPaging="false" 
                            AllowSorting="false" 
                            AutoGenerateColumns="False" 
                            DataSourceID="sqlListOfAccounts" 
                            Width="100%" 
                            DataKeyNames="ACC_ID" ShowHeaderWhenEmpty="true" EmptyDataText="No records were found" >
                        
                            <HeaderStyle ForeColor="White" />
                            <Columns>                               
                                <asp:BoundField ItemStyle-Width="150px" DataField="ACC_NUMBER" HeaderText="245" ReadOnly="True"  SortExpression="ACC_NUMBER"  ItemStyle-HorizontalAlign="Center" />                            
                                <asp:BoundField ItemStyle-Width="150px" DataField="VENDOR_NUMBER2" HeaderText="245" ReadOnly="True"  SortExpression="VENDOR_NUMBER"  ItemStyle-HorizontalAlign="Center" />                            
                                <asp:BoundField DataField="ACC_NAME" HeaderText="200" ReadOnly="True"  SortExpression="ACC_NAME"  HeaderStyle-HorizontalAlign="Left" />                            
                                <asp:BoundField DataField="CREATED_DATE" HeaderText="77" ReadOnly="True"  SortExpression="CREATED_DATE"  HeaderStyle-HorizontalAlign="center" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd'/'MM'/'yyyy}" ItemStyle-Width="140px"  />                            
                                                                                               
                                <asp:TemplateField ItemStyle-Width="20px" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate><a href="#" id="<%# Eval("ACC_ID") %>" class="setActiveAcc" ><img id='activeAcc<%# Eval("ACC_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                </asp:TemplateField>
                                                                                
                            </Columns>
                    </asp:GridView>
                </div>
            </div>
            
            <asp:SqlDataSource ID="sqlListOfAccounts" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="SELECT *,CASE WHEN LEFT(VENDOR_NUMBER,7) = 'General' THEN 'General' ELSE VENDOR_NUMBER END AS VENDOR_NUMBER2, ACC_NUMBER + ' - ' + ACC_NAME AS ACCOUNT FROM tblAccount WHERE ORG_ID=@OrgID"
                 FilterExpression="ACTIVE = {0} AND ACCOUNT_TYPE='{1}'" >
        
                <SelectParameters>
                    <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />                    
                </SelectParameters>

                <FilterParameters>
                    <asp:ControlParameter Name="Active" ControlID="cboHideInactive" PropertyName="SelectedValue" />
                    <asp:ControlParameter Name="ACCOUNT_TYPE" ControlID="cboAccType" PropertyName="SelectedValue" />
                </FilterParameters>

            </asp:SqlDataSource>



            <div id="tabs-projects">               
                <div style="overflow:scroll;height:840px; width:100%;">   
                    <a href="#" class="newProject"><img src="../../images/new.png" title="<%=hdnAdd.value %>" /></a><div style=" position:relative;top:-22px;left:28px;"><a href="#" class="newProject"><asp:Label ID="l99" runat="server" Text="Add" class="labelText" Visible="false"></asp:Label></a></div>
                    <asp:GridView ID="gvProjects" runat="server" 
                        AutoGenerateColumns="False"
                        DataSourceID="sqlGetProjects" Width="96%" DataKeyNames="PWC_ID" 
                        EmptyDataText="No projects" 
                        CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt" 
                        SelectedRowStyle-CssClass="sel"
                        HeaderStyle-ForeColor="White"
                        PagerStyle-ForeColor="White"
                        ShowHeader="true" ShowHeaderWhenEmpty="true" >
                                
                        <Columns>
                            <asp:BoundField  DataField="PWC_NUMBER" HeaderText="CTP" ItemStyle-ForeColor="Black"  />
                            <asp:BoundField  DataField="PWC_DESCRIPTION" HeaderText="Description" ItemStyle-ForeColor="Black" ItemStyle-Width="80%" />

                           <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate><a href="#" id="<%# Eval("PWC_ID") %>" class="setActivePWC" ><img id='activePWC<%# Eval("PWC_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                            
                        <EditRowStyle BackColor="#FFFF99" />
                        <HeaderStyle ForeColor="White" />
                        <SelectedRowStyle CssClass="sel" />
                    </asp:GridView>
                </div>
            </div>

            <div id="tabs-cc">
                
                <div style="overflow:scroll;height:840px; width:100%;">   
                    <a href="#" class="newCC"><img src="../../images/new.png" title="<%=hdnAdd.value %>" /></a><div style=" position:relative;top:-22px;left:28px;"><a href="#" class="newCC"><asp:Label ID="lbllbl" runat="server" Text="Add" class="labelText" Visible="false"></asp:Label></a></div>
                    <asp:GridView ID="gvCC" runat="server" 
                        AutoGenerateColumns="False"
                        DataSourceID="sqlGetCC" Width="96%" DataKeyNames="PWC_ID" 
                        EmptyDataText="No cost centers" 
                        CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt" 
                        SelectedRowStyle-CssClass="sel"
                        HeaderStyle-ForeColor="White"
                        PagerStyle-ForeColor="White"
                        ShowHeader="true" ShowHeaderWhenEmpty="true" >
                                
                        <Columns>
                            <asp:BoundField  DataField="PWC_NUMBER" HeaderText="CTC" ItemStyle-ForeColor="Black"  />
                            <asp:BoundField  DataField="PWC_DESCRIPTION" HeaderText="Description" ItemStyle-ForeColor="Black" ItemStyle-Width="80%" />

                           <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate><a href="#" id="<%# Eval("PWC_ID") %>" class="setActivePWC" ><img id='activePWC<%# Eval("PWC_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                            
                        <EditRowStyle BackColor="#FFFF99" />
                        <HeaderStyle ForeColor="White" />
                        <SelectedRowStyle CssClass="sel" />
                    </asp:GridView>
                </div>
            </div>


            <div id="tabs-wo">                                
                
                
                <div style="overflow:scroll;height:840px; width:100%;">   
                    <a href="#" class="newWO"><img src="../../images/new.png" title="<%=hdnAdd.value %>" /></a><div style=" position:relative;top:-22px;left:28px;"><a href="#" class="newWO"><asp:Label ID="Label7" runat="server" Text="Add" class="labelText" Visible="false"></asp:Label></a></div>
                    <asp:GridView ID="gvWO" runat="server" 
                        AutoGenerateColumns="False"
                        DataSourceID="sqlGetWO" Width="96%" DataKeyNames="PWC_ID" 
                        EmptyDataText="No work orders" 
                        CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        AlternatingRowStyle-CssClass="alt" 
                        SelectedRowStyle-CssClass="sel"
                        HeaderStyle-ForeColor="White"
                        PagerStyle-ForeColor="White"
                        ShowHeader="true" ShowHeaderWhenEmpty="true" >
                                
                        <Columns>
                            <asp:BoundField  DataField="PWC_NUMBER" HeaderText="CTW" ItemStyle-ForeColor="Black"  />
                            <asp:BoundField  DataField="PWC_DESCRIPTION" HeaderText="Description" ItemStyle-ForeColor="Black" ItemStyle-Width="80%" />

                           <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate><a href="#" id="<%# Eval("PWC_ID") %>" class="setActivePWC" ><img id='activePWC<%# Eval("PWC_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                            
                        <EditRowStyle BackColor="#FFFF99" />
                        <HeaderStyle ForeColor="White" />
                        <SelectedRowStyle CssClass="sel" />
                    </asp:GridView>
                </div>
            </div>

     </div>

    <asp:SqlDataSource ID="sqlGetEmployees" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetEmployees" SelectCommandType="StoredProcedure">

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <%-- <FilterParameters>
            <asp:Parameter Name="ACTIVE" DefaultValue="1" />
         </FilterParameters>  --%>              
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGetDivisions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <SelectParameters>
            <asp:Parameter Name="pwcType" DefaultValue="D" />
        </SelectParameters>

         <%--<FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>  --%>              
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGetProjects" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <SelectParameters>
            <asp:Parameter Name="pwcType" DefaultValue="P" />
        </SelectParameters>

        <%-- <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>  --%>              
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGetTP" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure"
        FilterExpression="ACTIVE = {0}" >

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <SelectParameters>
            <asp:Parameter Name="pwcType" DefaultValue="T" />
        </SelectParameters>

         <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>                
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGetWO" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure"
        FilterExpression="ACTIVE = {0}" >

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <SelectParameters>
            <asp:Parameter Name="pwcType" DefaultValue="W" />
        </SelectParameters>

         <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlGetCC" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure"
        FilterExpression="ACTIVE = {0}" >

        <SelectParameters>
            <asp:SessionParameter SessionField="OrgID" Name="OrgID" Type="Int32" />
        </SelectParameters>

        <SelectParameters>
            <asp:Parameter Name="pwcType" DefaultValue="C" />
        </SelectParameters>

         <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>
    </asp:SqlDataSource>


    <asp:HiddenField ID="hdnPWCType" runat="server" Value="" />   
    <asp:HiddenField ID="hdnPWCID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPUK" runat="server" Value="" />   
    <asp:HiddenField ID="hdnActivePWCMsg" runat="server" />
    <asp:HiddenField ID="hdnInactivePWCMsg" runat="server" />
    <asp:HiddenField ID="hdnActiveAccount" runat="server" />
    <asp:HiddenField ID="hdnInactiveAccount" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnAdd" runat="server" />
    <asp:HiddenField ID="hdnProject" runat="server" />
    <asp:HiddenField ID="hdnAccount" runat="server" />
    <asp:HiddenField ID="hdnCC" runat="server" />
    <asp:HiddenField ID="hdnWO" runat="server" />
    <asp:HiddenField ID="hdnDivision" runat="server" />
    <asp:HiddenField ID="hdnTP" runat="server" />
    <asp:HiddenField ID="hdnCancel" runat="server" />
    <asp:HiddenField ID="hdnUnexpectedError" runat="server" />
    <asp:HiddenField ID="hdnIsAdvalorem" runat="server" Value=0 />


    <asp:Panel ID="pnlPWC" runat="server" CssClass="modalPopup" style="display:none" width="520px" Height="250px">
        <div style="margin:10px">
            <table width="100%" border="0">
                <tr style="height:50px;"><td colspan="10" ><table width="100%"><tr><td><asp:Label ID="lblPWC" runat="server" Text="" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                
                <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr>

                <tr style="height:50px; vertical-align:bottom;">
                    <td width="150px" class="labelText">
                        <asp:Label ID="lbl425" runat="server" Text="Number" /></td>
                        <td align="left"><asp:TextBox ID="txtPWCNumber" runat="server" Width="100px" MaxLength="10" style=" text-align:left;" /><asp:RequiredFieldValidator ID="rfvNumber" runat="server"  ValidationGroup="NewPWC" ControlToValidate="txtPWCNumber" ></asp:RequiredFieldValidator>     
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" Display="Dynamic" SetFocusOnError="True" ControlToValidate="txtPWCNumber" ErrorMessage="car. prohibés" ValidationExpression="^[a-zA-Z0-9_,\s-]+$"></asp:RegularExpressionValidator>
                        </td>
                </tr>
                <tr id="Row-TagAlreadyExists"><td></td><td colspan="4"><asp:Label runat="server" ID="lbl543" ForeColor="Red" ></asp:Label></td></tr>                
                <tr id="Row-Vendor" >
                    <td width="120px" class="labelText">
                        <asp:Label ID="lbl546" runat="server" Text="Vendor #" />
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboVendorType" runat="server" >
                            <asp:ListItem Value="General">General</asp:ListItem>
                            <asp:ListItem Value="Emp">Employee</asp:ListItem>
                        </asp:DropDownList>

                        <asp:DropDownList ID="cboVendor" runat="server" DataSourceID="sqlGetEmployees" DataValueField="EMP_NUM" DataTextField="EMP_NUM_FULL_NAME" />
                        <asp:TextBox ID="txtVendor" runat="server" Width="100px" MaxLength="10"></asp:TextBox><asp:RequiredFieldValidator ID="rfvOK" runat="server" ErrorMessage="*" ControlToValidate="txtOkToSubmit" ValidationGroup="NewPWC"></asp:RequiredFieldValidator>      
                    </td>
                </tr>
                <tr id="Row-VendorExists"><td></td><td colspan="4"><asp:Label runat="server" ID="Label1" ForeColor="Red" Text="Vendor exists"  ></asp:Label></td></tr>
                <tr id="Tr9">
                    <td class="labelText"><asp:Label ID="lbl317" runat="server" Text="Label"></asp:Label></td><td><asp:TextBox ID="txtPWCDescription" runat="server" Width="175px" MaxLength="30"></asp:TextBox><asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage=" *" ControlToValidate="txtPWCDescription" ValidationGroup="NewPWC"></asp:RequiredFieldValidator></td>
                </tr>
            </table>   

            <div style=" position:relative;top:0px">
                <table width="100%" border="0">
                    <tr><td style="height:10px;"></td></tr>
                    <tr>
                        <td width="40%"><asp:Label ID="Label11" runat="server" Text="" ForeColor="#cd1e1e"></asp:Label></td>
                        <td align="right" valign="top">
                            <asp:Button ID="cmdSavePWC" runat="server" Text="140" width="80px" Height="30px"  CausesValidation="true" ValidationGroup="NewPWC"  />
                            <input id="Button5" type="button" value="<%=hdnCancel.value %>" class="button1"/>
                        </td>
                    </tr>
                </table>
            </div>
                            
            <br /><br />
            
            <div style=" visibility:hidden;"><asp:TextBox ID="txtOkToSubmit" runat="server" Text="True"></asp:TextBox></div>
            
        </div>
    </asp:Panel>

    <act:ModalPopupExtender ID="modalNewPWC" runat="server"
        TargetControlID="cmdDummy"
        PopupControlID="pnlPWC"
        PopupDragHandleControlID="pnlPWC"
        DropShadow="false"
        BackgroundCssClass="modalBackground"
        CancelControlID="Button5"
        BehaviorID="modalNewPWC" />

    <div style="display:none;"><asp:Button ID="cmdDummy" runat="server" Text="Button" /></div>

</asp:Content>
