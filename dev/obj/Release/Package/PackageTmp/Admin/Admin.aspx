<%@ Page Language="vb" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Admin.aspx.vb" Inherits="Advataxes.Admin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="act" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MainContent">

<asp:ScriptManager id="ScriptManager1" runat="server"  /> 
        <%lblMsg.Text = Session("msg")%>

        <% If lblMsg.Text <> "" Then%>
 	        <div class="ui-widget">
		        <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;"> 
			        <p><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em;"></span>
			          <asp:Label ID="lblMsg" runat="server" Text="" ></asp:Label></p>
		        </div>
	        </div>
            <br />
        <% End If%>

        <% Session("msg") = Nothing%>
                
        <table width="100%">
            <tr class="labelText">
                <td width="100px" hidden valign="middle"><table><tr id="Row-Org"><td><asp:Label ID="lbl238" runat="server" Text="Organization:" /></td><td><asp:DropDownList ID="cboOrg" runat="server" Width="300px" Height="23px" DataSourceID="sqlActiveOrgs" DataTextField="ORG_NAME" DataValueField="ORG_ID" AutoPostBack="true" /></td></tr></table></td>
                <td align="right">
                    <asp:Label ID="lbl378" runat="server" Text="378" />
                    <asp:DropDownList ID="cboHideInactive" runat="server" AutoPostBack="true" >
                        <asp:ListItem Value="1" Text="Active" />
                        <asp:ListItem Value="0" Text="Inactive" />
                    </asp:DropDownList>
                </td>
            </tr>
        </table>

        <div id="tabs" style="height:950px;">
			<ul>
                <li><a href="#tabs-data"><asp:Label ID="lbl_518" runat="server" Text="Data" /></a></li>
                <li><a href="#tabs-2"><asp:Label ID="lbl79" runat="server" Text="Employees" /></a></li>
                <li><a href="#tabs-3"><asp:Label ID="lbl80" runat="server" Text="Categories" /></a></li>
                <li><a href="#tabs-1"><asp:Label ID="lbl81" runat="server" Text="Organizations" /></a></li>                
                <li style="display:none;"><a href="#tabs-accounts"><asp:Label ID="lbl381" runat="server" Text="Accounts" /></a></li>                
                <li><a href="#tabs-6"><asp:Label ID="lbl82" runat="server" Text="Global Settings" /></a></li>                
                <li><a href="#tabs-5"><asp:Label ID="lbl83" runat="server" Text="Dashboard" /></a></li>
                <li><a href="#tabs-downloads"><asp:Label ID="labelDM" runat="server" Text="Download Manager" /></a></li>
                <li <%if not session("emp").isadvalorem then %>style="display:none;"<%end if %>><a href="#tabs-7">Advalorem</a></li>
			</ul>
            
            <div id="tabs-data" >
                <br />
                <table border=0 width="60%">
                    <tr><td width="40%"><asp:Label ID="lbl516" runat="server" Text="" CssClass="labelText"/></td>
                        <td>
                            <asp:DropDownList ID="cboDataType" runat="server" Width="50%" AutoPostBack="true" >
                                <asp:ListItem Value="Trans">Transactional</asp:ListItem>
                                <asp:ListItem Value="Master">Master</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr><td><asp:Label ID="lbl518" runat="server" Text="Data" CssClass="labelText"/></td>
                        <td>
                            <asp:DropDownList ID="cboData" runat="server"  Width="100%">
                                <asp:ListItem Value="X1">Pending Reports</asp:ListItem>
                                <asp:ListItem Value="M1">List of Projects</asp:ListItem>                    
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr id="Row-AsOf">
                        <td><asp:Label ID="lbl514" runat="server" Text="As of:" class="labelText" /></td>
                        <td  colspan="3">
                            <asp:TextBox ID="txtAsOf" runat="server" Width="100px"></asp:TextBox>
                            <asp:Label ID="lbl511" runat="server" Text="" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>


                    <tr id="Row-DataRange">
                        <td width="250px" class="labelText"><asp:Label ID="labl210" runat="server" Text="Data Range:" class="labelText" /> </td>
                        <td>
                            <asp:DropDownList ID="cboDataRange" runat="server" Width="125px" AutoPostBack="false" >
                                <asp:ListItem Value="Period">By Period</asp:ListItem>                                
                                <asp:ListItem Value="Custom">Custom</asp:ListItem>
                            </asp:DropDownList>
                        </td>                        
                    </tr>
                    
                    <tr id="Row-CustomReport">
                        <td><asp:Label ID="lblFrom" runat="server" Text="From:" class="labelText" /></td>
                        <td  colspan="3">
                            <asp:TextBox ID="txtFrom" runat="server" Width="100px"></asp:TextBox>
                            <asp:Label ID="lblTo" runat="server" Text="To:" class="labelText" /><asp:TextBox ID="txtTo" runat="server" Width="100px"></asp:TextBox>                            
                        </td>
                    </tr>
                    
                    <tr id="Row-ReportByPeriod">
                        <td><asp:Label ID="lbl237" runat="server" Text="Financial Year:" class="labelText" /></td>
                        <td>
                            <asp:DropDownList ID="cboFinancialYear" runat="server" Width="125px" AutoPostBack="false" >
                            </asp:DropDownList>                            
                            <asp:Label ID="lblPeriod" runat="server" Text="Period:" class="labelText" />
                            <asp:DropDownList ID="cboPeriod" runat="server" Width="75px"  AutoPostBack="false" >
                            </asp:DropDownList>  
                        </td>
                    </tr>


                    <tr><td></td><td align="right"><a href="#" class="printRpt"><img src="../images/viewreport.png" width="40px" title="<%= hdnviewreport.value %>" /></a></td></tr>
                </table>
            </div>

            <div id="tabs-accounts" >
            </div>

            <div id="tabs-downloads"  >
               <table width="99%">
                    <tr><td>
                        <fieldset>
                              <legend class="labelText"><asp:Label ID="lbl_222" runat="server" Text="Label"></asp:Label></legend>
                              <table border="0" width="100%">
                                 <tr>
                                    <td><asp:Label ID="lblFrom2" runat="server" Text="From:" CssClass="labelText"></asp:Label></td>
                                    <td><asp:TextBox ID="txtFrom2" runat="server" Width="100px"></asp:TextBox></td>
                                    <td><asp:Label ID="lblTo2" runat="server" Text="To:" CssClass="labelText"></asp:Label></td>
                                    <td align="left"><asp:TextBox ID="txtTo2" runat="server" Width="100px"></asp:TextBox></td>                                                                                                                                                
                                    <td align="left"><asp:ImageButton ID="cmdRefreshGrid" runat="server" ImageUrl="../images/refresh.png" ToolTip="Refresh Grid" /></td>
                                    <td align="right"><asp:ImageButton ID="cmdCSV" runat="server" ImageUrl="../images/csv.png" Width="40px" ToolTip="Download comma separated values2" /></td>
                                  <!--  <td align="right"><asp:ImageButton ID="cmdTSV" runat="server" ImageUrl="../images/tsv.png" Width="40px" ToolTip="Download tab separated values" /></td> -->

                                 </tr>
                                 </table>
                        </fieldset>                                               
                    </td>

                    <td align="right">
                        <asp:Label ID="lbl451" runat="server" Text="Mark reports in grid as " CssClass="labelText"></asp:Label><asp:DropDownList ID="cboDownloadedOption" runat="server"><asp:ListItem Value="0">Not Downloaded</asp:ListItem><asp:ListItem Value="1">Downloaded</asp:ListItem></asp:DropDownList>
                        <asp:Button ID="cmdApply" runat="server" Text="456" />
                    </td></tr>

                </table>

                <div style=" overflow: scroll;height:400px;">
                    <asp:GridView CssClass="mGrid"
                            PagerStyle-CssClass="pgr"
                            SelectedRowStyle-CssClass="sel"
                            ID="gvDownloads" runat="server" 
                            AllowPaging="false" 
                            AllowSorting="false" 
                            AutoGenerateColumns="False" 
                            Style="position: static"
                            DataSourceID="sqlFinalizedReports" 
                            Width="100%" 
                            DataKeyNames="REPORT_ID" ShowHeaderWhenEmpty="true" EmptyDataText="No records were found" >
                        
                            <HeaderStyle ForeColor="White" />
                            <Columns>
                               <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" HeaderText=""  ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="viewRpt" title="View"> <img  border="0" src="../Images/viewreport.png" alt="View Expense Report" width="22px" height="22px" title="<%=hdnexpensereport.value %>" /></a>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" HeaderText="" ItemStyle-HorizontalAlign="Center" Visible="false">
                                    <ItemTemplate>
                                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="viewDetailedRpt2" title="View"> <img  border="0" src="../Images/viewreport.png" alt="Detailed - Account Names" width="22px" height="22px" title="<%=hdnyouraccountnames.value %>" /></a>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                               
                               <asp:TemplateField ItemStyle-Width="15px" ItemStyle-ForeColor="Black" HeaderText="" ItemStyle-HorizontalAlign="Center">
                                    <ItemTemplate>
                                        <a href="#" id='<%# Eval("REPORT_ID") %>' class="viewDetailedRpt" title="Expense Report Detailed"> <img  border="0" src="../Images/viewreport.png" alt="Expense Report Detailed" width="22px" height="22px" title="<%=hdnDetailed.value %>" /></a>                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:BoundField ItemStyle-Width="20px" DataField="REPORT_NUM" HeaderText="Rpt#" ReadOnly="True"  SortExpression="REPORT_NUM"  ItemStyle-HorizontalAlign="Center" />                            
                                <asp:BoundField DataField="REPORT_NAME" HeaderText="71" ReadOnly="True"  SortExpression="REPORT_NAME"  HeaderStyle-HorizontalAlign="Left"/>                            
                                <asp:BoundField DataField="FINALIZED_DATE" HeaderText="78" ReadOnly="True"  SortExpression="FINALIZED_DATE" ItemStyle-Width="100px"  DataFormatString="{0:dd'/'MM'/'yyyy}"  ItemStyle-HorizontalAlign="Center" />                            
                                <asp:BoundField DataField="DOWNLOADED_DATE" HeaderText="415" ReadOnly="True"  SortExpression="DOWNLOADED_DATE" ItemStyle-Width="110px"  DataFormatString="{0:dd'/'MM'/'yyyy}"  ItemStyle-HorizontalAlign="Center" />                            
                                
                                <asp:TemplateField  ItemStyle-Width="15px" HeaderText="414" ItemStyle-horizontalalign="Center">                                    
                                        <ItemTemplate><a href="#" id='<%# Eval("REPORT_ID") %>' class="setDownloaded" ><img id='downloaded<%# Eval("REPORT_ID") %>' border="0" width="20px" src="../Images/<%# iif(EVAL("DOWNLOADED"),"checked","unchecked") %>.png" /></a></ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                    </asp:GridView>
                </div>
            </div>

			<div id="tabs-1">
               <table width="100%" border=0>
                   <tr style="height:10px;">
                        <%If IsNothing(Session("emp").organization.parentorg) And Session("emp").isadvalorem Then%>
                            <td width="90%"><a id="cmdNewOrg" href="#" class="newOrg" title="Add Organization"><img src="../images/new.png" /></a></td>
                        <% end if %>
                        <td style="display:none;"><a href="#" id="org" class="viewVideo"><img src="../images/video.jpg" title="Video" /><div style="position:relative;top:-25px;left:24px;height:20px;"><asp:Label ID="Label5" runat="server" Text="Video" class="labelText"></asp:Label></div></a></td>
                   </tr>
               </table>
                                                
                <asp:GridView CssClass="mGrid"
                        PagerStyle-CssClass="pgr"
                        SelectedRowStyle-CssClass="sel"
                        ID="gvOrgs" runat="server" 
                        AllowPaging="True" 
                        AllowSorting="false" 
                        AutoGenerateColumns="False" 
                        Style="position: static"
                        DataSourceID="sqlOrgs" 
                        Width="100%" 
                        DataKeyNames="ORG_ID" >
                        
                        <HeaderStyle ForeColor="White" />
                        <Columns>
                            <asp:TemplateField  ItemStyle-Width="15px" >
                                <ItemTemplate><a href="#" id='<%# Eval("ORG_ID") %>' class="selectOrg" title="Select"> <img  border="0" src="../Images/select.png" alt="Select" /></a></ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField  ItemStyle-Width="15px">
                                <ItemTemplate><a href="#" id='<%# Eval("ORG_ID") %>' class="editOrg" title="Edit"> <img  border="0" src="../Images/edit.png" alt="Edit" /></a></ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="ORG_NAME" HeaderText="81" ReadOnly="True"  SortExpression="ORG_NAME" HeaderStyle-HorizontalAlign="Left" />
                            
                            <asp:TemplateField  ItemStyle-Width="15px" HeaderText="175" ItemStyle-horizontalalign="Center">
                                    <ItemTemplate><a href="#" id='<%# Eval("ORG_ID") %>' class="<%# iif(EVAL("PARENT_ORG")=0,"","setActiveOrg") %>"> <img id='activeOrg<%# Eval("ORG_ID") %>'  border="0" width="<%# iif(EVAL("PARENT_ORG")=0,"23",20)%>px;" height="<%# iif(EVAL("PARENT_ORG")=0,"23",20)%>px" src="../Images/<%# iif(EVAL("PARENT_ORG")=0,"parent", iif(EVAL("ACTIVE"),"checked","unchecked")) %>.png" alt="Set Inactive" title="<%# iif(EVAL("PARENT_ORG")=0,hdnActiveParent.value,"") %>"  /></a></ItemTemplate>
                            </asp:TemplateField>                                                        
                        </Columns>
                </asp:GridView>
            </div>

            <div id="tabs-2">
                    <table width="100%">
                        <tr>
                            <td width="90%"><asp:ImageButton ID="cmdNewEmp" runat="server" ImageUrl="../../images/new.png" ToolTip="Add Employee" /><div style=" position:relative;top:-22px;left:28px;width:50px;"><a href="#" class="newEmp"><asp:Label ID="lbl_278" runat="server" Text="Add" class="labelText" Visible="false"></asp:Label></a></div></td>
                            <td style="display:none;"><a id="emp" href="#" class="viewVideo"><img src="../images/video.jpg" title="Video" /><div style="position:relative;top:-25px;left:24px;height:20px;width:75px;"><asp:Label runat="server" Text="Video" class="labelText"></asp:Label></div></a></td>                            
                        </tr>
                    </table>
                           
                    <div style="overflow:scroll;height:450px; width:100%;">
                           <asp:GridView ID="gvEmployees" runat="server" CssClass="mGrid"
                                    DataSourceID="sqlEmployees" 
                                    AutoGenerateColumns="False" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    Width="100%" 
                                    PagerStyle-CssClass="pgr"
                                    AlternatingRowStyle-CssClass="alt" 
                                    SelectedRowStyle-CssClass="sel" 
                                    Style="position: static"
                                    DataKeyNames="ORG_ID"                          
                                    HeaderStyle-ForeColor="White" 
                                    ShowHeaderWhenEmpty="true" >

                                <Columns>
                                    <asp:TemplateField  ItemStyle-Width="1%">
                                        <ItemTemplate>
                                            <a href='#' id='<%# Eval("EMP_ID") %>' class='<%# IIf(Membership.GetUser(Eval("USERNAME").ToString()).IsLockedOut,"unlockUser","editEmp") %>'> 
                                                <%# IIf(Membership.GetUser(Eval("USERNAME").ToString()).IsLockedOut, "<img src='../images/lock.png' width='12px' height='15px' title='Account has been locked. Click to unlock.'/>", "<img  src='../Images/edit.png' title='Edit' />")%>
                                            </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="EMP_NUM" HeaderText="Emp #" SortExpression="EMP_NUM" ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="7%" />
                                    <asp:BoundField DataField="DIV_CODE" HeaderText="CTD" SortExpression="DIV_CODE" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="7%" />
                                    <asp:BoundField DataField="USERNAME" HeaderText="206" SortExpression="USERNAME" ItemStyle-Width="10%" />
                                    <asp:BoundField DataField="LAST_NAME" HeaderText="149" SortExpression="LAST_NAME" ItemStyle-Width="100px" />
                                    <asp:BoundField DataField="FIRST_NAME" HeaderText="148" SortExpression="FIRST_NAME" ItemStyle-Width="100px" />
                                    
                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="Admin" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setAdmin" ><img id='admin<%# Eval("EMP_ID") %>'  src='../Images/<%# iif(Eval("IS_ADMIN")="True","checked","unchecked")%>.png' width="20px" height="20px"/></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="71" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setViewReports" ><img id='viewReports<%# Eval("EMP_ID") %>'  src='../Images/<%# iif(Eval("IS_ACCOUNTANT")="True","checked","unchecked")%>.png' width="20px" height="20px"/></ItemTemplate>
                                    </asp:TemplateField>
                            
                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="159" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setSuper" ><img id='super<%# Eval("EMP_ID") %>' src='../Images/<%# iif(Eval("APPROVAL_LEVEL")="1","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="382" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setFinalizer" ><img id='finalizer<%# Eval("EMP_ID") %>' src='../Images/<%# iif(Eval("APPROVAL_LEVEL")="2","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="239" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setNotify" ><img id='notify<%# Eval("EMP_ID") %>' src='../Images/<%# iif(Eval("NOTIFY_FINALIZED")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="Tags" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setTagEntry" ><img id='tagEntry<%# Eval("EMP_ID") %>' src='../Images/<%# iif(Eval("TAG_ENTRY")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate><a href="#" id="<%# Eval("EMP_ID") %>" class="setActive" ><img id='active<%# Eval("EMP_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div> 
                </div>
                                
			<div id="tabs-3">
                <% If cboFirstMonth.Enabled Or hdnAllowEditOrg.Value = "True" Then%>
                    <div class="ui-widget">
		                <div class="ui-state-highlight ui-corner-all" style="margin-top: 0px; padding: 0.7em;height:20px;"> 
			                <p style=" font-size:0.9em;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em;"></span>
			                    <asp:Label ID="Label19" runat="server" Text="" >Section is unavailable until your Global Settings and Organization Details have been completed.</asp:Label>
                            </p>
		                </div>
	                </div>

                    <div style="display:none;">
                <%End If%> 

                    <div id="dialog" title="Description" style=" z-index:99;">
                    </div>                                       

                    <table width="100%" border="0" >
                        <tr style="height:25px; background-color:#b7b7b8;"><td align="center" style="width:350px; color:White; font-weight:bold; font-size:small;"><asp:Label ID="lbl197" runat="server" Text="Label"></asp:Label></td><td align="center" style=" background-color:#b7b7b8; width:475px; color:White; font-weight:bold; font-size:small;"><table width="100%"><tr><td align="center"><asp:Label ID="lbl198" runat="server" Text="Label"></asp:Label></td><td width="127px"><asp:Label ID="lbl199" runat="server" Text="Label"></asp:Label></td><td width="55px"><asp:Label ID="lbl175" runat="server" Text="Label"></asp:Label></td></tr></table></td></tr>
                    </table>
                                    
                    <table width="100%" border="0" >
                        <tr>
                            <td width="42%">
                                <div style="overflow:scroll;height:450px; width:100%;">
                                    <asp:GridView ID="gvCategories" runat="server" DataSourceID="sqlCategories" 
                                        AutoGenerateColumns="False" Width="95%" DataKeyNames="CAT_ID"
                                        CssClass="mGrid"
                                        PagerStyle-CssClass="pgr"
                                        AlternatingRowStyle-CssClass="alt" 
                                        SelectedRowStyle-CssClass="sel"
                                        AllowPaging="false"
                                        PagerStyle-ForeColor="White" 
                                        Style="position: static"
                                        ShowHeader="false" >

                                        <Columns>
                                            <asp:TemplateField ItemStyle-Width="90%" ItemStyle-Height="10%">
                                                <ItemTemplate>
                                                    <asp:Label ID="label" runat="server" Text=""><%# IIf(Eval("CAT_ID") = 5, hdnSelectableRateText.Value, IIf(Eval("CAT_ID") = 29, hdnOtherExpenseTxText.Value, IIf(Eval("CAT_ID") = 32, hdnOtherExpenseNtText.Value, Eval("CAT_NAME"))))%></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField ItemStyle-Width="15px" ItemStyle-Height="1%">
                                                <ItemTemplate>
                                                    <a href="#" id='<%# Eval("CAT_ID") %>' class="catDesc"> <img  border="0" src="../Images/question.png" width="18px" height="18px" /></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField ItemStyle-Width="15px">
                                                <ItemTemplate>
                                                    <a href="#" id='<%# Eval("CAT_ID") %>' class="selCat" title="Select Category"><img  border="0" src="../Images/download<%# iif(Eval("ALLOW_NOTE")="True","","")%>.png" alt="Select <%# iif(Eval("ALLOW_NOTE")="True","","")%>" /></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                 </div>
                            </td>

                            <td valign="top" width="58%">
                                
                                <div style="overflow:scroll;height:450px; width:100%;">    
                                  <asp:GridView ID="gvOrgCat" runat="server" 
                                        AutoGenerateColumns="False"
                                        DataSourceID="sqlOrgCategories" Width="96%" DataKeyNames="CAT_ID,ORG_ID,ORG_CAT_ID" 
                                        EmptyDataText="No categories selected" 
                                        CssClass="mGrid"
                                        PagerStyle-CssClass="pgr"
                                        AlternatingRowStyle-CssClass="alt" 
                                        SelectedRowStyle-CssClass="sel"
                                        HeaderStyle-ForeColor="White"
                                        PagerStyle-ForeColor="White"
                                        Style="position: static"
                                        ShowHeader="False" >
                                
                                        <Columns>
                                            <asp:TemplateField  ItemStyle-Width="15px" >
                                                <ItemTemplate>
                                                    <a href="#" id='<%# Eval("ORG_CAT_ID") %>' class="viewGLAccount"> <img  border="0" src="../Images/view.png" alt="Edit" /></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField  DataField="CAT_NAME" HeaderText="198" ItemStyle-ForeColor="Black" ItemStyle-Width="450px" />

                                            <asp:TemplateField HeaderText="199" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="150px"  >
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("GL_ACCOUNT") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        
                                            <asp:TemplateField  ItemStyle-Width="15px" >
                                                <ItemTemplate><a href="#" id='<%# Eval("CAT_ID") %>' class="catDesc"> <img  border="0" src="../Images/question.png" width="18px" height="18px" /></a></ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField ItemStyle-Width="3%" HeaderText="175" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate><a href="#" id="<%# Eval("ORG_CAT_ID") %>" class="setActiveOC" ><img id='activeOC<%# Eval("ORG_CAT_ID") %>' src='../Images/<%# iif(Eval("ACTIVE")="True","checked","unchecked")%>.png' width="20px" height="20px"/></a></ItemTemplate>
                                            </asp:TemplateField>
    <%-- 
                                             <asp:TemplateField  ItemStyle-Width="15px" >
                                                  <ItemTemplate>
                                                     <a href="#" id='<%# Eval("ORG_CAT_ID") %>' class="delOrgCat"> <img  border="0" src="../Images/del.png" alt="Delete" /></a>
                                                  </ItemTemplate>
                                              </asp:TemplateField>
    --%>
                                        </Columns>
                            
                                        <EditRowStyle BackColor="#FFFF99" />
                                        <HeaderStyle ForeColor="White" />
                                        <SelectedRowStyle CssClass="sel" />
                                    </asp:GridView>
                                </div> 
                            </td>
                        </tr>
                        </table> 
                    
                        <table width="450px" >
                        <tr>
                            <td align="center" class="style1" >

                            </td>
                        </tr>
                        <tr>
                            <td>
                        
                            </td>
                        </tr>
                    </table>

                <% If cboFirstMonth.Enabled Or hdnAllowEditOrg.Value = "True" Then%>
                    </div>
                <%End If%> 
            </div>
            
            <div id="tabs-5">
                <div id="radio" style="position:relative;z-index:99;width:200px;">
                    <input type="radio" id="radio2" name="radio" checked="checked"  onclick="showAuditTrail()" /><label for="radio2">Action</label>
                    <input type="radio" id="radio1" name="radio"  onclick="javascript:createDashboard()" /><label for="radio1"><%=hdnLoginInfo.Value%></label>
                </div>
                <div id="DashDateRange" style=" text-align:right; position:relative;top:-30px; z-index:98;">
                    <asp:Label ID="lbl379" runat="server" Text="From" CssClass="labelText" />&nbsp;<asp:TextBox ID="txtDashFrom" runat="server" Text="From" Width="100px" CssClass="labelText"/>
                    <asp:Label ID="lbl380" runat="server" Text="To" CssClass="labelText" />&nbsp;<asp:TextBox ID="txtDashTo" runat="server" Text="To"  Width="100px"  CssClass="labelText" />
                    <asp:ImageButton ID="cmdRefreshAuditTrail" ImageUrl="../images/refresh.png" Width="25px" runat="server" />
                </div>

                <div id="AuditTrail" style=" overflow:scroll;height:800px">
                        <asp:GridView ID="gvAuditTrail" runat="server"
                                AutoGenerateColumns="False"
                                GridLines="None"
                                AllowPaging="false"
                                CssClass="mGrid"
                                PagerStyle-CssClass="pgr"
                                AlternatingRowStyle-CssClass="alt" 
                                SelectedRowStyle-CssClass="sel"
                                AllowSorting="True" 
                                CellPadding="4" 
                                DataSourceID="sqlAuditTrail"  
                                HeaderStyle-ForeColor="White" 
                                ForeColor="White" 
                                BackColor="White" 
                                BorderColor="#DEDFDE" 
                                BorderStyle="None" 
                                BorderWidth="1px" 
                                Width="95%" 
                                DataKeyNames="ORG_ID" 
                                Style="position: static"
                                EmptyDataText="No data to display" 
                                ShowHeaderWhenEmpty="True" 
                                ViewStateMode="Enabled" Font-Size="Small" PagerStyle-Font-Size="large">

                                <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
                                <Columns>
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="EMPLOYEE" HeaderText="Emp" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="150px" />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="TABLE_ACTION" HeaderText="Action" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="MODIFIED_RECORD" HeaderText="520" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="FIELD_NAME" HeaderText="521" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="OLD_VALUE" HeaderText="522" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  ItemStyle-Width="100px"  />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="NEW_VALUE" HeaderText="523" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left"  ItemStyle-Width="100px"  />
                                    <asp:BoundField  ItemStyle-ForeColor="black" DataField="ACTION_DATE" HeaderText="Date" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="10%" />
                                </Columns>
        
                                <EditRowStyle Height="20px" />
                                <EmptyDataRowStyle Height="20px" />
                                <HeaderStyle ForeColor="White" Height="20px"></HeaderStyle>
                                <RowStyle Height="20px" />
                            </asp:GridView>
                    </div>

            </div>
            
            <div id="tabs-6">
                <table width="100%">
                    <tr><td width="90%"><asp:ImageButton ID="cmdEditSettings" runat="server" ImageUrl="../images/edit.png" /><a href="#" class="editGS"><asp:Label ID="lblEditSettings" runat="server" Text="Edit" class="labelText"></asp:Label></a></td>
                    <td style="display:none;"><a id="gs" href="#" class="viewVideo"><img src="../images/video.jpg" title="Video" /><div style="position:relative;top:-25px;left:24px;height:20px;"><asp:Label runat="server" Text="Video" class="labelText"></asp:Label></div></a></td>                    
                    </tr>
                </table>              
                
                   <table border="0" width="100%" cellspacing="0" style="color:Black;">
                        <%If Session("emp").organization.parent.calendarmatch Then%>
                            <tr id="Tr3" style="background-color:#efefef;"><td width="350px"><asp:Label id="lbl_164" runat="server" Text="First month of financial year:" class="labelText" /></td>
                                <td><asp:Label ID="lblFirstMonthData" runat="server" Text="" /></td>
                            </tr>                        

                            <tr id="Tr4"><td><asp:Label id="lbl_165" runat="server" Text="Number of periods in financial year:" class="labelText" /></td>
                                <td><asp:Label ID="lblPeriodnumData" runat="server" Text="" /></td>
                            </tr>
                        <%end if %>

                        <tr id="Tr1" style="background-color:#efefef;"><td><asp:Label ID="lbl_441" runat="server" Text="Approval Level:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblApprovalLevel" runat="server" Text="" />
                        </td></tr>

                        <tr><td class="labelText"><asp:Label ID="lbl439" runat="server" Text="Accounting Segments" /></td>                        
                            <td colspan="3">      
                                <%If Left(Session("emp").organization.parent.AccSegment, 1) = "D" Then%><asp:Label ID="CTD" runat="server" Text="Division" /><%end if %>
                                <%If Left(Session("emp").organization.parent.AccSegment, 1) = "A" Then%><asp:Label ID="lbl455" runat="server" Text="Natural" /><%end if %>                                                                                                

                                <%If Mid(Session("emp").organization.parent.AccSegment, 2, 1) = "D" Then%> - <asp:Label ID="CT_D" runat="server" Text="Division" /><%end if %>                                                                                                
                                <%If Mid(Session("emp").organization.parent.AccSegment, 2, 1) = "A" Then%> - <asp:Label ID="lbl_455" runat="server" Text="Natural" /><%end if %>
                                <%If Mid(Session("emp").organization.parent.AccSegment, 2, 1) = "P" Then%> - <asp:Label ID="CTP" runat="server" Text="Project" /><%end if %>                                                                                                
                                <%If Mid(Session("emp").organization.parent.AccSegment, 2, 1) = "C" Then%> - <asp:Label ID="CTC" runat="server" Text="cost center" /><%end if %>

                                <%If Mid(Session("emp").organization.parent.AccSegment, 3, 1) = "P" Then%> - <asp:Label ID="CT_P" runat="server" Text="Project" /><%end if %>
                                <%If Mid(Session("emp").organization.parent.AccSegment, 3, 1) = "C" Then%> - <asp:Label ID="CT_C" runat="server" Text="Cost center" /><%end if %>

                                <%If Right(Session("emp").organization.parent.AccSegment, 1) = "P" Then%> - <asp:Label ID="CT__P" runat="server" Text="Project" /><%end if %>
                                <%If Right(Session("emp").organization.parent.AccSegment, 1) = "C" Then%> - <asp:Label ID="CT__C" runat="server" Text="cost center" /><%end if %>
                            
                            </td>
                        </tr>

                        <tr style="background-color:#efefef;">
                            <td class="labelText"><asp:Label ID="lbl440" runat="server" Text="Use work order tags for expenses"></asp:Label></td>
                            <td>
                                <%If Session("emp").organization.parent.displayworkorder Then%>
                                    <asp:Label ID="lbl279" runat="server" Text="Yes"></asp:Label>
                                <%else %>
                                    <asp:Label ID="lbl280" runat="server" Text="no"></asp:Label>
                                <%end if %>
                            </td>
                        </tr>

                        <tr id="Tr5"><td><asp:Label id="lbl_166" runat="server" Text="Accounts payable account #:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblAcctPayableData" runat="server" Text="" />
                        </td></tr>
                    
                        <tr id="Tr6" style="background-color:#efefef;"><td><asp:Label id="lbl_167" runat="server" Text="ITC Account #:" class="labelText" /></td><td colspan="2">                            <asp:Label ID="lblITCAcctData" runat="server" Text="" />
                        </td></tr>

                        <tr id="Tr7"><td><asp:Label id="lbl_168" runat="server" Text="ITR Account #:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblITRAcctData" runat="server" Text="" />
                        </td></tr>

                        <tr id="Tr8" style="background-color:#efefef;"><td><asp:Label id="lbl_169" runat="server" Text="RITC-ON Account #:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblRITCONData" runat="server" Text="" />
                        </td></tr>
                        
                        <tr id="Row-RITC-BC2"><td><asp:Label id="lbl_170" runat="server" Text="RITC-BC Account #:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblRITCBCData" runat="server" Text="" />
                        </td></tr>
                                                
                        <tr id="Row-RITC-PEI2"><td><asp:Label id="lbl_171" runat="server" Text="RITC-PEI Account #:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblRITCPEIData" runat="server" Text="" />
                        </td></tr>

                        <tr id="Tr10" style="background-color:#efefef;"><td><asp:Label id="lbl_172" runat="server" Text="Retention Period:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblRetentionData" runat="server" Text="" />
                            </td>
                        </tr>
                            
                        <tr id="Tr11"><td><asp:Label id="lbl_173" runat="server" Text="Currency Offset:" class="labelText" /></td><td colspan="2">
                            <asp:Label ID="lblCurrencyOffsetData" runat="server" Text="" /></td>
                        </tr>
                    </table>
                </div>
           
            <div id="tabs-7" style="width:930px;" >
                        <div id="tabsAdvalorem" style="height:880px;border:none;">
			                <ul>
				                <li><a href="#tabOrg">Organizations</a></li>
                                <li><a href="#tabEmp">Users</a></li>
                                <li><a href="#tabTrans">Translation</a></li>
			                </ul>

                            <div id="tabOrg">
                                <div style="overflow:scroll;height:350px; width:95%;">
                                <asp:GridView ID="gvAdvaloremGetOrgs" runat="server" BackColor="White" 
                                    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                                    DataSourceID="sqlAllOrgs" ForeColor="Black" GridLines="Vertical" 
                                    Width="100%" AutoGenerateColumns="False"
                                    Style="position: static"
                                    AlternatingRowStyle-BackColor="White" 
                                    FooterStyle-BackColor="#CCCC99" >
                                        
                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                    <RowStyle BackColor="#F7F7DE" />
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                    <SortedAscendingHeaderStyle BackColor="#848384" />
                                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                    <SortedDescendingHeaderStyle BackColor="#575357" />
                                        
                                    <Columns>
                                        <asp:BoundField DataField="date_created" HeaderText="Created" DataFormatString="{0:d}" />
                                        <asp:BoundField DataField="org_name"  HeaderText="Org"  ItemStyle-Wrap="true" />
                                            
                                        <asp:TemplateField HeaderText="OrgInfo" >
                                                <ItemTemplate><%#IIf(Eval("JUR_ID") > 0, "True", "False")%></ItemTemplate>
                                        </asp:TemplateField>
   
                                        <asp:TemplateField HeaderText="Global" >
                                                <ItemTemplate><%#IIf(isdbnull(Eval("Period")), "False", "True")%></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField  ItemStyle-Width="1%">
                                            <ItemTemplate><a href="#" id='<%# Eval("ORG_ID") %>' class="delOrg"> <img  border="0" src="../Images/del.png" alt="Delete"  /></a></ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                </div>
                            </div>
                            
                            <div id="tabEmp">
                                <div style="overflow:scroll;height:350px; width:95%;">
                                <asp:GridView ID="gvAdvaloremListOfUsers" runat="server" BackColor="White" 
                                    BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                                    DataSourceID="sqlGetUsers" ForeColor="Black" GridLines="Vertical" 
                                    Width="100%" AutoGenerateColumns="False"
                                    Style="position: static"
                                    AlternatingRowStyle-BackColor="White" 
                                    FooterStyle-BackColor="#CCCC99" >

                                    <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                    <RowStyle BackColor="#F7F7DE" />
                                    <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#FBFBF2" />
                                    <SortedAscendingHeaderStyle BackColor="#848384" />
                                    <SortedDescendingCellStyle BackColor="#EAEAD3" />
                                    <SortedDescendingHeaderStyle BackColor="#575357" />

                                    <Columns>
                                        <asp:BoundField DataField="created_date" HeaderText="Created" DataFormatString="{0:d}" />
                                        <asp:BoundField DataField="activated" HeaderText="Activated" />

                                        <asp:TemplateField HeaderText="OrgInfo" Visible="false" >
                                                <ItemTemplate><%#IIf(Eval("JUR_ID") > 0, "True", "False")%></ItemTemplate>
                                        </asp:TemplateField>
   
                                        <asp:TemplateField HeaderText="Global" Visible="false" >
                                                <ItemTemplate><%#IIf(isdbnull(Eval("Period")), "False", "True")%></ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="username" HeaderText="Username" ItemStyle-Wrap="true" />
                                        <asp:BoundField DataField="org_name"  HeaderText="Org"  ItemStyle-Wrap="true" />
                                        <asp:BoundField DataField="last_name"  HeaderText="LastName"  ItemStyle-Wrap="true" />
                                        <asp:BoundField DataField="first_name"  HeaderText="FirstName"  ItemStyle-Wrap="true" />
                                        <asp:BoundField DataField="title"  HeaderText="Title"  ItemStyle-Wrap="true"/>
                                        <asp:BoundField DataField="email"  HeaderText="Email"  />
                                        <asp:BoundField DataField="phone"  HeaderText="Phone"  />
                                                                                
                                        <asp:TemplateField  ItemStyle-Width="1%">
                                                <ItemTemplate><a href="#" id='<%# Eval("EMP_ID") %>' class="delEmp"> <img  border="0" src="../Images/del.png" alt="Delete" /></a></ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>

                        <div id="tabTrans">
                        
                        </div> 
                    </div>
                </div>
        </div>
    
    <!-- ============= HIDDEN FIELDS ============================================================================== -->
    <asp:HiddenField ID="hdnOrgID" runat="server" />
    <asp:HiddenField ID="hdnOrgID2" runat="server" Value="0" />
    <asp:HiddenField ID="hdnParentOrg" runat="server" Value="0" />
    <asp:HiddenField ID="hdnOrgCatID"  runat="server" Value="0" />
    <asp:HiddenField ID="hdnSelectedTab" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnFinancialYR" runat="server"  /> 
    <asp:HiddenField ID="hdnStart" runat="server"  /> 
    <asp:HiddenField ID="hdnEnd" runat="server"  /> 
    <asp:HiddenField ID="hdnSelCat" runat="server"  />
    <asp:HiddenField ID="hdnPeriodStart" runat="server" />
    <asp:HiddenField ID="hdnParentID" runat="server" />
    <asp:HiddenField ID="hdnUserID" runat="server" /> 
    <asp:HiddenField ID="hdnExecuteSave" runat="server" Value="False" /> 
    <asp:HiddenField ID="hdnSelectedOrg" runat="server" Value="" /> 
    <asp:HiddenField ID="hdnAllowEditOrg" runat="server" Value="" />
    <asp:HiddenField ID="hdnViewReport" runat="server" Value="" />
    <asp:HiddenField ID="hdnViewReports" runat="server" Value="" />
    <asp:HiddenField ID="hdnLanguage" runat="server" Value="English" />
    <asp:HiddenField ID="hdnInactiveCatMsg" runat="server" Value="" />
    <asp:HiddenField ID="hdnActiveCatMsg" runat="server" Value="" />
    <asp:HiddenField ID="hdnActivePWCMsg" runat="server" Value="Set status to active?" />
    <asp:HiddenField ID="hdnInactivePWCMsg" runat="server" Value="Set status to inactive?" />
    <asp:HiddenField ID="hdnCatStatusMsgTitle"  runat="server" Value="" />
    <asp:HiddenField ID="hdnCancelText"  runat="server" Value="" />   
    <asp:HiddenField ID="hdnOrgCodeLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnJurLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnGSTRegLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnQSTRegLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnLargeGSTLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnLargeQSTLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnRatioLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnRITCKMLabelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnShowProjectText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnShowWorkOrderText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnShowCostCenterText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnSelectableRateText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnOtherExpenseTxText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnOtherExpenseNtText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnExportExcelText" runat="server" Value="" />   
    <asp:HiddenField ID="hdnPUK" runat="server" Value="" />   
    <asp:HiddenField ID="hdnAccSeg" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLastDelegateDisabled" runat="server" Value="0" />
    <asp:HiddenField ID="hdnUnexpectedError" runat="server" Value="0" />
    <asp:HiddenField ID="hdnUnlocked" runat="server" Value="0" />
    <asp:HiddenField ID="hdnAprvrFnlzrReq" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnApproverReq" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnFinalizerReq" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetAdmin" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveAdmin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnSetEmpActive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetEmpInactive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetAccActive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetAccInactive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetOrgActive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetOrgInactive" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetFinalizer" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveFinalizer" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetApprover" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveApprover" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetTagEntry" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveTagEntry" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetDownloaded" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveDownloaded" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnSetNotify" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnRemoveNotify" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnYes" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnNo" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnGSTRatio" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnQSTRatio" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnPEI" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnLimitAmt" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnFixedAmt" runat="server" Value="0" /> 
    <asp:HiddenField ID="hdnEmpNumAlreadyAssigned" runat="server" Value="0" />
    <asp:HiddenField ID="hdnActiveParent" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginInfo" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDownloaded" runat="server" Value="0" />
    <asp:HiddenField ID="hdnGST" runat="server" Value="0" />
    <asp:HiddenField ID="hdnQST" runat="server" Value="0" />
    <asp:HiddenField ID="hdnYourAccountNames" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExpenseReport" runat="server" Value="0" />
    <asp:HiddenField ID="hdnDetailed" runat="server" Value="0" />
    <asp:HiddenField ID="hdnSetViewReports" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRemoveViewReports" runat="server" Value="0" />

<!------------------------PANELS-------------------------------------------------------------------------------------------------------------->
    <asp:Panel ID="pnlCreateEmp" runat="server" CssClass="modalPopup" style="display:none" width="575px" Height="550px">
        <div style="margin:5px">
            <div>
                <table width="95%" border=0>
                    <tr style="height:50px;"><td colspan="10"><table width="100%"><tr><td  style="color:#cd1e1e;font-size:1.5em;"><asp:Label ID="lbl_73" runat="server" Text="Employee"></asp:Label> - <%=cboOrg.SelectedItem.Text%></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                    <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
                    <tr style="height:10px;"><td></td></tr>
                    <tr><td colspan="10"><a id="3" href="#" class="popUpWin"><asp:Label ID="lbl204" runat="server" Text="Who is considered an employee"></asp:Label></a></td></tr>
                </table>
            </div>
            <div id="Div-EmpMsg"><asp:Label ID="lblEmpMsg" runat="server" BackColor="#cd1e1e" ForeColor="white" Font-Bold="true" Width="100%" /></div> 
            <table width="95%" border=0>
                <!--<tr><td rowspan="10" valign="top" width="30%"><img src="../images/emp.png" /></td></tr>-->
                <tr>
                    <td colspan="2"><asp:ValidationSummary ID="ValidationSummary1" runat="server"  HeaderText="&nbsp;<b>*</b> Required fields cannot be blank" ShowSummary="true" ValidationGroup="NewEmp" DisplayMode="SingleParagraph" BackColor="red" ForeColor="white" /></td>
                </tr>

                <tr style="height:10px;"><td></td></tr>
                <tr><td class="labelText" width="40%"><asp:Label ID="lbl149" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtLName"  runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" text="*" ErrorMessage=""  Font-Size="X-Large" ControlToValidate="txtLName" ValidationGroup="NewEmp" Display="dynamic" /></td></tr>
                <tr><td width="100px" class="labelText"><asp:Label ID="lbl148" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtFName" runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="" Text="*" Font-Size="X-Large" ControlToValidate="txtFName" ValidationGroup="NewEmp" Display="dynamic"></asp:RequiredFieldValidator></td></tr>
                <!--<tr><td>Title:</td><td><asp:TextBox ID="txtTitle" runat="server" Width="300px"></asp:TextBox></td></tr> -->
                <tr><td width="100px" class="labelText"><asp:Label ID="lbl205" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtEmpNum" runat="server" Width="100px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="" text="*" Font-Size="X-Large"  ValidationGroup="NewEmp" ControlToValidate="txtEmpNum" Display="dynamic" />&nbsp;&nbsp;<%= IIf(Session("emp").organization.parent.displaydivision, "", "<div style='display:none;'>")%><asp:Label ID="lbl_208" runat="server" Text="Division Code:" CssClass="labelText" />&nbsp;<asp:DropDownList ID="cboDiv" DataSourceID="sqlGetActiveDivisions" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_NUMBER" runat="server" />
                    <%= IIf(Session("emp").organization.parent.displaydivision, "", "</div>")%>                
                    <%If Session("emp").organization.parent.displaydivision Then%><asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="" text="*" Font-Size="X-Large"  ValidationGroup="NewEmp" ControlToValidate="cboDiv" Display="dynamic" /><%End If%>
                </td></tr>
                <tr id="Row-EmpNumAlreadyExists"><td colspan="4"><asp:Label runat="server" ID="lblInvalidEmpNum" ForeColor="Red" Font-Bold="true"  ></asp:Label></td></tr>
                <tr id="Row-DefaultProject" <%= iif(Session("emp").organization.parent.displayproject,"","style='display:none;'") %> ><td width="100px" class="labelText"><asp:Label ID="lblDefaultProject" runat="server" Text="Default Project" /></td><td><asp:DropDownList ID="cboDefaultProject" runat="server" Width="300px" DataSourceID="sqlGetActiveProjects" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_ID" /><br /><asp:CheckBox ID="chkLockDefaultProject" runat="server" /><asp:Label ID="lblLockDefault" runat="server" Text="Lock Default Project" CssClass="labelText"></asp:Label></td></tr>
                <tr><td width="100px" class="labelText"><asp:Label ID="lbl159" runat="server" Text="Label" /></td><td><asp:DropDownList ID="cboSupervisor" runat="server"  Width="200px" /></td></tr>
                <tr <%if session("emp").organization.parent.approvallevel=1 then %> style="display:none;" <%end if %>><td width="100px" class="labelText"><asp:Label ID="lbl_382" runat="server" Text="Finalizer" /></td><td><asp:DropDownList ID="cboFinalizer" runat="server"  Width="200px" /></td></tr>
                <tr><td width="100px" class="labelText"><asp:Label ID="lbl152" runat="server" Text="Label" /></td><td><asp:DropDownList ID="cboDelegate" runat="server" DataSourceID="sqlActiveEmployees" DataTextField="FULL_NAME" DataValueField="EMP_ID" Width="200px" /></td></tr>

                <tr><td class="labelText"><asp:Label ID="lbl294" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtEmail" runat="server" Width="300px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage=""  text="*"   Font-Size="X-Large"  ControlToValidate="txtEmail" ValidationGroup="NewEmp" Display="dynamic"></asp:RequiredFieldValidator></td></tr>
                <tr id="Row-InvalidEmail"><td></td><td colspan="3"><asp:Label runat="server" ID="lblInvalidEmail" ForeColor="Red" Font-Bold="true" Text="Invalid Email Address"  ></asp:Label></td></tr>
                <!--<tr><td>Phone:</td><td><asp:TextBox ID="txtPhone" runat="server"></asp:TextBox></td></tr>-->
                <tr><td class="labelText"><asp:Label ID="lbl206" runat="server" Text="Label" /></td><td><asp:TextBox ID="txtUserName" runat="server" class="checkUsername" MaxLength="15"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage=""  text="*"   Font-Size="X-Large"  ControlToValidate="txtUserName" ValidationGroup="NewEmp"  Display="dynamic"></asp:RequiredFieldValidator></td></tr>
                <tr id="Row-UserAlreadyExists"><td></td><td colspan="3"><asp:Label runat="server" ID="lblInvalidUserName" ForeColor="Red" Font-Bold="true"  ></asp:Label></td></tr>
                <tr><td colspan="3" class="labelText"><br /><asp:CheckBox ID="chkIsAdmin" runat="server" />Admin<!--&nbsp;&nbsp;Is accountant:<asp:CheckBox ID="chkIsAcc" runat="server" />-->&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkIsSuper" runat="server" /><asp:Label ID="lbl_159" runat="server" Text="Label" /><%If Session("emp").organization.parent.approvallevel = 2 Then%>&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkFinalizer" runat="server" /><asp:Label ID="lbl382" runat="server" Text="Finalizer" /><%end if %>&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkViewReports" runat="server" /><asp:Label ID="lbl494" runat="server" Text="View Reports" />&nbsp;&nbsp;&nbsp;<br /><asp:CheckBox ID="chkTagEntry" runat="server" /><asp:Label ID="lbl444" runat="server" Text="Allow employee to create tags" />&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="chkNotify" runat="server" /><asp:Label ID="lbl319" runat="server" Text="Label" />&nbsp;<a id="207" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a></td></tr>                
                <tr><td colspan="3" class="labelText"><table><tr><td valign="top"></td></tr></table></td></tr>                            
            </table>
            
            <div style="position:absolute;top:475px;left:340px;">
                <table>
                    <tr valign="bottom" style="height:65px;">
                        <td colspan="2" align="right" >
                            <asp:Button ID="cmdSaveEmployee" runat="server" Text="Save" CausesValidation="true" ValidationGroup="NewEmp" Height="30px" class="button1" UseSubmitBehavior="true" />
                            &nbsp;&nbsp;
                            <asp:Button ID="cmdCancelNewEmp" runat="server" Text="Cancel" Height="30px" UseSubmitBehavior="true" width="80px" />
                        </td></tr>    
                    <tr id="Row-EmpID"><td><asp:TextBox ID="txtEmpID" runat="server" Text="0" ></asp:TextBox></td></tr>
                </table>
            </div>            
       </div> 
   </asp:Panel> 


    <asp:Panel ID="pnlNoFlash" runat="server" CssClass="modalPopup" style="display:none" width="350px" Height="280px">
        <div id="NoFlash" class="labelText" style="font-size:1.3em;text-align:center;"><br /><br /><br /><img src="../images/flash.png" /><br /><br />Flash is required to view the videos<br /><br /><br /><asp:Button ID="cmdCancelNoFlash" runat="server" Text="Close" Width="100px" Height="30px" /></div>       
    </asp:Panel>
   

    <asp:Panel ID="pnlVideo" runat="server" CssClass="modalPopup" style="display:none" width="650px" Height="440px">
        <br />
        <div style=" text-align:center;">
            
            <div id="video">
                <object id="0" type="application/x-shockwave-flash" data="player_flv_maxi.swf" width="640" height="379">               
                    <param name="movie" value="player_flv_maxi.swf" />
                    <param name="wmode" value="opaque" />
                    <param name="allowFullScreen" value="true" />
                    <param name="allowScriptAccess" value="sameDomain" />
                    <param name="quality" value="high" />
                    <param name="menu" value="true" />
                    <param name="autoplay" value="false" />
                    <param name="autoload" value="false" />
                    <param name="FlashVars" value="flv=GlobalSettings.flv&width=640&height=379&autoplay=1&autoload=0&buffer=5&buffermessage=&playercolor=464646&loadingcolor=999898&buttoncolor=ffffff&buttonovercolor=dddcdc&slidercolor=ffffff&sliderovercolor=dddcdc&showvolume=1&showfullscreen=1&playeralpha=100&title=Global Settings&margin=0&buffershowbg=0" />
               </object>
           </div>
           
           <asp:Button ID="cmdCancelVideo" runat="server" Text="Close" Width="100px" Height="30px" />
       </div>
       
    </asp:Panel> 

    <asp:Panel ID="pnlEmpVideo" runat="server" CssClass="modalPopup" style="display:none" width="650px" Height="440px">
        <br />
        <div style=" text-align:center;">            
            <object id="1" type="application/x-shockwave-flash" data="player_flv_maxi.swf" width="640" height="379">               
                <param name="movie" value="player_flv_maxi.swf" />
                <param name="wmode" value="opaque" />
                <param name="allowFullScreen" value="true" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="quality" value="high" />
                <param name="menu" value="true" />
                <param name="autoplay" value="true" />
                <param name="autoload" value="false" />
                <param name="FlashVars" value="flv=employeesTab.flv&width=640&height=379&autoplay=1&autoload=0&buffer=5&buffermessage=&playercolor=464646&loadingcolor=999898&buttoncolor=ffffff&buttonovercolor=dddcdc&slidercolor=ffffff&sliderovercolor=dddcdc&showvolume=1&showfullscreen=1&playeralpha=100&title=Employees Tab&margin=0&buffershowbg=0" />
           </object>

           <br />
           <asp:Button ID="cmdEmpVideo" runat="server" Text="Close" Width="100px" Height="30px" />
       
       </div>
    </asp:Panel>

    <asp:Panel ID="pnlOrgVideo" runat="server" CssClass="modalPopup" style="display:none" width="650px" Height="440px">
        <br />
        <div style=" text-align:center;">
            <object id="vidOrg" type="application/x-shockwave-flash" data="player_flv_maxi.swf" width="640" height="379">               
                <param name="movie" value="player_flv_maxi.swf" />
                <param name="wmode" value="opaque" />
                <param name="allowFullScreen" value="true" />
                <param name="allowScriptAccess" value="sameDomain" />
                <param name="quality" value="high" />
                <param name="menu" value="true" />
                <param name="autoplay" value="false" />
                <param name="autoload" value="false" />
                <param name="FlashVars" value="flv=orgTab.flv&width=640&height=379&autoplay=1&autoload=0&buffer=5&buffermessage=&playercolor=464646&loadingcolor=999898&buttoncolor=ffffff&buttonovercolor=dddcdc&slidercolor=ffffff&sliderovercolor=dddcdc&showvolume=1&showfullscreen=1&playeralpha=100&title=Organization Tab&margin=0&buffershowbg=0" />
           </object>

           <br />
           <asp:Button ID="cmdCancelVidOrg" runat="server" Text="Close" Width="100px" Height="30px" />
       
       </div>
    </asp:Panel> 

    <asp:Panel ID="pnlEditGlobalSettings" runat="server" CssClass="modalPopup" style="display:none" width="550px" Height="520px">
            <table border="0" width="550px" style="color:Black;border-collapse:collapse;">
            <tr style="height:50px;">
                <td colspan="10"><table width="100%"><tr><td  style="color:#cd1e1e;font-size:1.5em;"><asp:Label ID="Label18" runat="server" Text="Global Settings"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td>
            </tr>
            <tr style=" background-color:#cd1e1e;height:2px;"><td colspan="10"></td></tr>
            <tr><td colspan="2"><asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="* You must accept the terms before saving" Text="" ValidationGroup="GS" ControlToValidate="hdnConfirmGS" BackColor="#cd1e1e" ForeColor="White" Width="100%"></asp:RequiredFieldValidator></td></tr>
            <tr id="Tr12"><td width="350px"><asp:Label ID="Label3" runat="server" Text="Financial periods match the calendar" class="labelText" /></td><td>
                    <asp:DropDownList ID="cboCalendarMatch" runat="server" Width="80px" >
                        <asp:ListItem value="1">Yes</asp:ListItem>
                        <asp:ListItem Value="0">No</asp:ListItem>
                    </asp:DropDownList>
                    <a id="A1" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>
            </tr>
            
            <tr id="Row-FirstMonth"><td><asp:Label ID="lbl164" runat="server" Text="First month of financial year" class="labelText" /></td><td>
                    <asp:DropDownList ID="cboFirstMonth" runat="server" Width="120px" />
                    <a id="14" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>
            </tr>

            <tr id="Row-PeriodNum"><td><asp:Label ID="lbl165" runat="server" Text="Number of periods in financial year:" class="labelText" /></td><td>
                    <asp:DropDownList ID="cboPeriodNum" runat="server" 
                        CausesValidation="false"  Width="75px" >
                        <asp:ListItem>12</asp:ListItem>    
                        <asp:ListItem>6</asp:ListItem>    
                        <asp:ListItem>4</asp:ListItem>    
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>1</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>

            <tr><td class="labelText"><asp:Label ID="lbl441" runat="server" Text="Approval Levels" /></td><td colspan="2">
                <asp:DropDownList ID="cboApprovalLevel" Width= runat="server">
                    <asp:ListItem Value="1">1 (Finalize Only)</asp:ListItem>
                    <asp:ListItem Value="2">2 (Approve & Finalize)</asp:ListItem>
                </asp:DropDownList>
                <a id="A2" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr>
                <td colspan="2" class="labelText">Account Segments: 
                    <asp:DropDownList ID="cboSegment1" runat="server">                                                
                        <asp:ListItem Value="A">Natural</asp:ListItem>                        
                        <asp:ListItem Value="D">Division</asp:ListItem>                                                
                    </asp:DropDownList>
                    
                    <asp:DropDownList ID="cboSegment2" runat="server">
                        <asp:ListItem Value="N">None</asp:ListItem>                        
                        <asp:ListItem Value="A">Natural</asp:ListItem>
                        <asp:ListItem Value="D">Division</asp:ListItem>                        
                        <asp:ListItem Value="P">Project</asp:ListItem>                        
                        <asp:ListItem Value="C">Cost Center</asp:ListItem>                        
                    </asp:DropDownList>
                    
                    <asp:DropDownList ID="cboSegment3" runat="server">
                        <asp:ListItem Value="N">None</asp:ListItem>                        
                        <asp:ListItem Value="P">Project</asp:ListItem>                        
                        <asp:ListItem Value="C">Cost Center</asp:ListItem>                        
                    </asp:DropDownList>

                    <asp:DropDownList ID="cboSegment4" runat="server">
                        <asp:ListItem Value="N">None</asp:ListItem>                        
                        <asp:ListItem Value="P">Project</asp:ListItem>                        
                        <asp:ListItem Value="C">Cost Center</asp:ListItem>                        
                    </asp:DropDownList>

                    <a id="362" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>             
            </tr>
            
            <tr>
                <td class="labelText">Use Work Order Tag for Expenses</td>
                <td>
                    <asp:DropDownList ID="cboWO" runat="server">
                        <asp:ListItem Value="0">No</asp:ListItem>
                        <asp:ListItem Value="1">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <a id="363" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>
            </tr>
                        
            <tr id="Row-AcctPayable"><td><asp:Label ID="lbl166" runat="server" Text="Accounts payable #:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtAcctPayable" runat="server" Width="40%" class="numberinput-nodecimal" style=" text-align:left;"></asp:TextBox>
                <a id="16" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" Text="*" Font-Size="X-Large" ErrorMessage="'Account Payable #' &nbsp;&nbsp;" ControlToValidate="txtAcctPayable" ValidationGroup="GS" />
            </td></tr>
                    
            <tr id="Row-ITCAcct"><td><asp:Label ID="lbl167" runat="server" Text="ITC Account #:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtITCAcct" runat="server" class="numberinput-nodecimal" Width="40%" style=" text-align:left;"></asp:TextBox>
                <a id="17" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr id="Row-ITRAcct"><td><asp:Label ID="lbl168" runat="server" Text="ITR Account #:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtITRAcct" runat="server" class="numberinput-nodecimal" Width="40%" style=" text-align:left;"></asp:TextBox>
                <a id="18" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr id="Row-RITC-ON"><td><asp:Label ID="lbl169" runat="server" Text="RITC-ON Account #:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtRITCON" runat="server" class="numberinput-nodecimal" Width="40%" style=" text-align:left;"></asp:TextBox>
                <a id="19" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr id="Row-RITC-BC"><td><asp:Label ID="lbl170" runat="server" Text="RITC-BC Account#:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtRITCBC" runat="server" class="numberinput-nodecimal" Width="40%" style=" text-align:left;"></asp:TextBox>
                <a id="20" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr id="Row-RITC-PEI"><td><asp:Label ID="lbl171" runat="server" Text="RITC-PEI Account#:" class="labelText" /></td><td colspan="2">
                <asp:TextBox ID="txtRITCPEI" runat="server" class="numberinput-nodecimal" Width="40%" style=" text-align:left;"></asp:TextBox>
                <a id="35" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
            </td></tr>

            <tr id="Row-Retention"><td><asp:Label ID="lbl172" runat="server" Text="Retention Period:" class="labelText" /></td><td colspan="2">
                <asp:DropDownList ID="cboRetention" runat="server" Width="80px">
                    <asp:ListItem Selected="True" Value="1" >1 year</asp:ListItem>
                    <asp:ListItem Value="2" >2 years</asp:ListItem>
                    <asp:ListItem Value="3" >3 years</asp:ListItem>
                    <asp:ListItem Value="4" >4 years</asp:ListItem>
                    <asp:ListItem Value="5" >5 years</asp:ListItem>
                    <asp:ListItem Value="6" >6 years</asp:ListItem>
                </asp:DropDownList>
                <a id="21" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>
            </tr>
                            
            <tr id="Row-InterestRate"><td><asp:Label ID="lbl173" runat="server" Text="Currency Offset:" class="labelText" /></td><td colspan="2">
                <asp:DropDownList ID="cboInterestRate" runat="server" Width="80px">
                    <asp:ListItem Selected="True" Value="0" >0%</asp:ListItem>
                    <asp:ListItem Value="0.01">1%</asp:ListItem>
                    <asp:ListItem Value="0.02">2%</asp:ListItem>
                    <asp:ListItem Value="0.03">3%</asp:ListItem>
                    <asp:ListItem Value="0.04">4%</asp:ListItem>
                    <asp:ListItem Value="0.05">5%</asp:ListItem>
                </asp:DropDownList>
                <a id="22" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td>
            </tr>

            <tr><td colspan="2">

            </td></tr>

            <tr style="height:10px;"><td></td></tr>
            <tr height="80px">             	                    
                <td>
                    <div id="WarningGS" class="ui-widget">
		                <div class="ui-state-highlight ui-corner-all" style="margin-top: -10px; padding: 0.7em;height:50px;"> 
			                 <p style="font-size:0.9em;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em;"></span><asp:Label ID="lblWarningGS" runat="server" Text="" ></asp:Label></p>
		                     <div style="position:relative;top:15px;left:260px;"><asp:CheckBox ID="chkConfirmGS" runat="server" /><asp:Label ID="lbl272" runat="server" Text="I Accept" ForeColor="red" ></asp:Label><asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage=" *" Font-Size="Large" Text="" ValidationGroup="GS" ControlToValidate="hdnConfirmGS"></asp:RequiredFieldValidator></div>
                        </div>
	                </div>
                </td>
                
                <td align="right">
                    <table>
                        <tr>
                            <td><asp:Button ID="cmdSaveSettings" runat="server" Text="Save" Height="30px" class="button1" CausesValidation="true" ValidationGroup="GS" /></td>
                            <td><asp:Button ID="cmdCancelSaveSettings" runat="server" Text="Cancel" Height="30px" class="button1"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
        </table>
                            
        <div style="display:none;">
            <asp:TextBox ID="hdnConfirmGS" runat="server" Visible="true" ValidationGroup="GS"></asp:TextBox>
        </div> 

   </asp:Panel>

    <asp:Panel ID="pnlEditCompany" runat="server" CssClass="modalPopup" style="display:none" width="670px" Height="570px">
            <div style="margin:10px">
            
            <table width="100%" >
                <tr style="height:50px;"><td colspan="10" ><table width="100%"><tr><td><asp:Label ID="lbl290" runat="server" Text="Organization" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr>
                <tr><td><asp:ValidationSummary ID="ValidationSummary2" HeaderText="The following fields are required: " ShowSummary="false" ShowMessageBox="false" DisplayMode="SingleParagraph" ValidationGroup="NewOrg" runat="server" /></td></tr>    
                <tr style="height:60px;"><td valign="bottom" width="45%" class="labelText"><asp:Label ID="lbl317" runat="server" Text="Label"></asp:Label></td><td valign="bottom">
                <asp:TextBox ID="txtOrgName" runat="server" Width="80%"></asp:TextBox>&nbsp;<a id="4" href="#" class="popUpWin"><img src="../images/question.png" width="17px" height="17px"  /></a><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="'Name' &nbsp;&nbsp;" Text="*"  Font-Size="X-Large"  ControlToValidate="txtOrgName" ValidationGroup="NewOrg"></asp:RequiredFieldValidator></td></tr>
                    
                <tr><td class="labelText"><asp:Label ID="Type" runat="server" Text="Type" /></td><td>
                    <asp:DropDownList ID="cboType" runat="server" DataSourceID="sqlOrgTypes" DataTextField="ORG_TYPE_NAME" DataValueField="ORG_TYPE_ID" AppendDataBoundItems="true"  >
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                    <a id="5" href="#" class="popUpWin"><img src="../images/question.png" width="17px" height="17px"  /></a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="'Type' &nbsp;&nbsp;" Text="*"  Font-Size="X-Large"  ControlToValidate="cboType" ValidationGroup="NewOrg"></asp:RequiredFieldValidator>
                </td></tr>

                <tr><td width="48%" class="labelText"><asp:Label ID="lbl177" runat="server" Text="Label" /></td><td valign="bottom">
                    <asp:TextBox ID="txtOrgCode" runat="server" Width="100px"></asp:TextBox>&nbsp;<a id="6" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a></td>
                </tr>

                <tr><td class="labelText"><asp:Label ID="lbl43" runat="server" Text="Label" /></td><td colspan="2">
                    <asp:DropDownList ID="cboJurisdiction" runat="server" DataSourceID="sqlJurisdictions" DataTextField="JUR_NAME" DataValueField="JUR_ID" AppendDataBoundItems ="true" >
                        <asp:ListItem> </asp:ListItem>
                    </asp:DropDownList>
                    <a id="7" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="'Jurisdiction' &nbsp;&nbsp;" Text=" *"  Font-Size="X-Large"  ControlToValidate="cboJurisdiction" ValidationGroup="NewOrg" ></asp:RequiredFieldValidator>
                </td></tr>
                
                <tr><td class="labelText"><asp:Label ID="lbl178" runat="server" Text="Label" /></td><td>
                    <asp:DropDownList ID="cboGSTReg" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <a id="8"  href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl188" runat="server"  Text="GST #:"  class="labelText" /><asp:TextBox ID="txtGST" runat="server" Width="75px" class="numberinput-nodecimal" MaxLength="10"/>
                </td></tr>

                <tr id="Row-GSTDate"><td class="labelText">GST registrant later than Jan. 1, 2012?:</td><td>
                    <asp:DropDownList ID="cboGSTDate" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                
                    <asp:TextBox runat="server" ID="txtGSTDate"></asp:TextBox>                    
                </td></tr>

                <tr><td class="labelText"><asp:Label ID="lbl179" runat="server" Text="Label" /></td><td>
                    <asp:DropDownList ID="cboQSTReg" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <a id="9" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lbl189" runat="server" Text="QST #:"  class="labelText" /><asp:TextBox ID="txtQST" runat="server" Width="75px"  MaxLength="10"></asp:TextBox>
                </td></tr>

                <tr id="Row-QSTDate"><td class="labelText">QST registrant later than Jan. 1, 2012?:</td><td>
                    <asp:DropDownList ID="cboQSTDate" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                    
                    <asp:TextBox runat="server" ID="txtQSTDate"></asp:TextBox>                    
                </td></tr>

                <tr id="Row-LargeGST"><td class="labelText"><asp:Label ID="lbl190" runat="server" Text="Label" /></td><td>
                    <asp:DropDownList ID="cboLargeGST" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <a id="10" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td></tr>

                <tr id="Row-LargeQST"><td class="labelText"><asp:Label ID="lbl191" runat="server" Text="Label" /></td><td>
                    <asp:DropDownList ID="cboLargeQST" runat="server">
                        <asp:ListItem Value="1">No</asp:ListItem>
                        <asp:ListItem Value="2">Yes</asp:ListItem>
                    </asp:DropDownList>
                    <a id="11" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                </td></tr>

                <tr id="Row-CRA"><td class="labelText"><asp:Label ID="lbl192" runat="server" Text="Label" /></td><td>
                    <table>
                        <tr id="Row-CRA-GST">
                            <td>
                                <asp:Label ID="lbl193" runat="server" Text="GST C.A. Ratio (%):"  class="labelText" />
                                <asp:DropDownList ID="cboGSTRate" runat="server" Width="50px" />
                                <a id="12"  href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                            </td>
                        </tr>

                        <tr id="Row-CRA-QST">
                            <td>
                                <asp:Label ID="lbl194" runat="server" Text="QST C.A. Ratio (%):"  class="labelText" />                        
                                <asp:DropDownList ID="cboQSTRate" runat="server" Width="50px">
                                </asp:DropDownList>
                                <a id="13" href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                            </td>                
                         </tr>
                    </table>                        
                </td></tr>

                <tr id="Row-KM">
                    <td class="labelText"><asp:Label ID="lbl318" runat="server" Text="Label" /></td><td class="labelText">                       
                        ON  <asp:DropDownList ID="cboKmON" runat="server" Width="50px">
                            </asp:DropDownList>
                            <asp:Label ID="Label6" runat="server" Text=""><%If Session("emp").defaultlanguage = "English" Then Response.Write("PEI") Else Response.Write("IPE")%></asp:Label>
                        
                            <asp:DropDownList ID="cboKmPEI" runat="server" Width="50px">
                            </asp:DropDownList>
                            <a id="276"  href="#"  class="popUpWin" ><img src="../images/question.png" width="17px" height="17px"  /></a>
                    </td>
                </tr>
             
             </table>                
                <div style="position:absolute;top:450px;width:95%;">
                    <table width="100%" border="0">
                        <tr style="height:100px;">
                            <td width="70%" valign="top">
 	                            <div id="Warning" class="ui-widget">
		                            <div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0.7em;height:75px;"> 
			                            <p style=" font-size:0.9em;"><span class="ui-icon ui-icon-info" style="float: left; margin-right: 0.3em;"></span>
			                                <asp:Label ID="lblWarning" runat="server" Text="" Width="350px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="position:relative;left:310px;top:40px;width:100px;"><asp:CheckBox ID="chkConfirmOrg" runat="server" /><asp:Label ID="lbl_272" runat="server" Text="I Accept" ForeColor="red" ></asp:Label><asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="'I Accept'" Text="  *"  Font-Size="Large"  ValidationGroup="NewOrg" ControlToValidate="hdnConfirmOrg"></asp:RequiredFieldValidator></div>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                            <p>
                                            </p>
                                        </p>
		                            </div>
	                            </div>
                            </td>

                            <td colspan="2" align="right" valign="bottom">
                                <asp:Button ID="cmdSaveCompany" runat="server" Text="Save" CausesValidation="true" ValidationGroup="NewOrg" Height="30px" class="button1" Enabled="true" />
                                <asp:Button ID="cmdCancelSaveCompany" runat="server" Text="Cancel" class="cancelSaveCompany" Height="30px" UseSubmitBehavior="false" Width="80px" />
                         </td></tr>
                    </table>

                                        
                    <div style="display:none;">
                        <asp:TextBox ID="txtOrgID2" runat="server" Text="0"></asp:TextBox>                    
                        <asp:TextBox ID="hdnConfirmOrg" runat="server" Visible="true" ValidationGroup="NewOrg"></asp:TextBox>    
                    </div> 
                </div>
            </div> 
       </asp:Panel> 
    
    <asp:Panel ID="pnlOrgCat" runat="server" CssClass="modalPopup" style="display:none" width="575px" Height="310px">
        <div style="margin:10px">
            
            <table width="100%" border="0">
                <tr style="height:50px;"><td colspan="10" ><table width="100%"><tr><td><asp:Label ID="lblCatName" runat="server" Text="Label" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>                
                <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr> 
                <tr style="height:15px;"><td></td></tr>                              
                <tr><td width="180px" class="labelText"><asp:Label ID="lbl_199" runat="server"></asp:Label><br /></td><td align="left">
                        <asp:Label ID="lblAccount" runat="server" Text="" ForeColor="#cd1e1e" Font-Bold="true" />
                        <asp:DropDownList ID="cboAccount" runat="server" DataSourceID="sqlGetExpenseAccounts" DataTextField="ACCOUNT" DataValueField="ACC_NUMBER" Width="350px" />
                </td></tr>
                <tr id="Row-Note"><td class="labelText">Note</td><td><asp:TextBox ID="txtNote" runat="server" Width="350px"></asp:TextBox></td></tr>
                <tr id="Row-Allowance"><td class="labelText"><asp:Label ID="lbl288" runat="server" Text="Fixed Amount"></asp:Label></td><td><asp:TextBox ID="txtAllowance" runat="server" Width="75px" Text="0"  class="numberinput" style=" text-align:left;"></asp:TextBox> <asp:Label ID="Label2" runat="server" Text=""></asp:Label></td></tr>
                <tr id="Row-CC" <%=iif(session("emp").organization.displaycostcenter,"","style='display:none;'") %>><td class="labelText"><asp:Label ID="lblDefaultCC" runat="server" Text="Default Cost Center"></asp:Label></td><td><asp:DropDownList ID="cboDefaultCC" runat="server" Width="350px" DataSourceID="sqlGetActiveCC" DataTextField="PWC_NUMBER_DESC" DataValueField="PWC_ID"  /></td></tr>
                <tr style="height:15px;"><td></td></tr>                
            </table>           
             
            <div style="position:relative;top:-10px;left:-10px;width:575px;">
                <table width="98%">
                    <tr>
                        <td width="65%">
                            <table width="100%">
                                <tr id="Row-RequiresProject"><td width="120px" class="labelText" colspan="2"><asp:CheckBox ID="chkProject" runat="server" /><asp:Label ID="lblProjectRequired" runat="server" Text="Requiert un # de projet pour cette dépense"></asp:Label></td></tr>
                                <tr id="Row-RequiresCC"><td width="120px" class="labelText" colspan="2"><asp:CheckBox ID="chkCostCenter" runat="server" /><asp:Label ID="lblCCRequired" runat="server" Text="Requiert un centre de coûts pour cette dépense"></asp:Label></td></tr>
                                <tr id="Row-FactorMethod"><td width="120px" class="labelText" colspan="2"><asp:CheckBox ID="chkFactorMethod" runat="server" /><asp:Label ID="lbl555" runat="server" Text="Use factors method in the factors method report" ></asp:Label></td></tr>
                                <tr id="Row-RequiresProject2"><td width="120px" class="labelText" colspan="2"><asp:Label ID="lblProjectRequired2" runat="server" Text="Expense requires a project for this category"></asp:Label></td></tr>
                                <tr id="Row-RequiresCC2"><td width="120px" class="labelText" colspan="2"><asp:Label ID="lblCCRequired2" runat="server" Text="Expense requires a cost center for this category"></asp:Label></td></tr>
                                <tr id="Row-FactorMethod2"><td width="120px" class="labelText" colspan="2"><asp:Label ID="lbl_555" runat="server" Text="Uses the factors method in the factors method report"></asp:Label></td></tr>
                            </table>
                        </td>
                        <td align="right">
                            <asp:Label ID="lblGLError" runat="server" Text="" ForeColor="#cd1e1e"></asp:Label>           
                            <asp:Button ID="cmdSaveOC" class="cmdSaveOC" runat="server" Text="Save" width="80px" Height="30px"  CausesValidation="true" ValidationGroup="NewOrgCat"  />
                            <input id="cmdCancelOC" type="button" value="<%=hdnCancelText.value %>" class="button1"/>            
                        </td>
                    </tr>
                </table>                
            
            </div>            
            <br /><br />
                        
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlProcessing" runat="server" CssClass="modalPopup" Width="300px">
        <div class="labelText" style="margin:10px">
            <table width="100%"><tr><td><img src="../images/busy.gif" /></td><td align="center" class="labelText">Processing, please wait ... </td></tr></table>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnlCreateAccount" runat="server" CssClass="modalPopup" style="display:none" width="550px" Height="200px">
        <div style="margin:10px">
            <table width="100%">
                <tr style="height:50px;"><td colspan="10" ><table width="100%"><tr><td><asp:Label ID="Label8000" runat="server" Text="Account" style="color:#cd1e1e;font-size:1.5em;"></asp:Label></td><td align="right"><img src="../images/av.png" width="50px" height="40px"/></td></tr></table></td></tr>
                <tr><td colspan="10" style=" background-image:url(../images/redline.png); background-repeat:repeat-x;"></td></tr> 
                <tr style="height:15px;"><td></td></tr>                              
                <tr><td width="25%"><asp:Label ID="Label800" runat="server" Text="Account Number" CssClass="labelText"></asp:Label></td><td><asp:TextBox ID="txtAccountNumber" runat="server"></asp:TextBox></td></tr>
                <tr><td><asp:Label ID="Label900" runat="server" Text="Account Name" CssClass="labelText"></asp:Label></td><td><asp:TextBox ID="txtAccountName" runat="server" Width="95%"></asp:TextBox></td></tr>                
                <tr>
                    <td colspan="2" align="right">
                        <br />
                        <asp:Button ID="cmdSaveAccount" runat="server" Text="Save" CssClass="button1" />
                        <asp:Button ID="cmdCancelAccount" runat="server" Text="Cancel"  CssClass="button1"/>
                    </td>
                </tr>
            </table>
        </div>
    </asp:Panel>
    
    <asp:Panel ID="pnlBubble" runat="server" CssClass="modalPopup" style="display:none">
        <div style="margin:10px">
            <asp:TextBox ID="txtBubble" runat="server" BorderStyle="None" BackColor="Transparent"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Yes" width="80px"  CausesValidation="false"  />
            <asp:Button ID="Button2" runat="server" Text="No"  width="80px" CausesValidation="false"  />
        </div>
    </asp:Panel>


<!------------------------EXTENDERS-------------------------------------------------------------------------------------------------------------->
        <act:ModalPopupExtender ID="modalVideo" runat="server"
            TargetControlID="cmdDummy"                 
            PopupControlID="pnlVideo"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalVideo" />

        <act:ModalPopupExtender ID="modalNoFlash" runat="server"
            TargetControlID="cmdDummy"                 
            PopupControlID="pnlNoFlash"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalNoFlash" />
                 
        <act:ModalPopupExtender ID="modalOrgVideo" runat="server"
            TargetControlID="cmddummy"                 
            PopupControlID="pnlOrgVideo"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalOrgVideo" />

        <act:ModalPopupExtender ID="modalEmpVideo" runat="server"
            TargetControlID="cmddummy"                 
            PopupControlID="pnlEmpVideo"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalEmpVideo" />

        <act:ModalPopupExtender ID="modalProcessing" runat="server"
            TargetControlID="cmddummy"
            PopupControlID="pnlProcessing"
            PopupDragHandleControlID="pnlProcessing"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalProcessing" />

        <act:ModalPopupExtender ID="modalEditGlobalSettings" runat="server"
            TargetControlID="cmdEditSettings"
            PopupControlID="pnlEditGlobalSettings"
            PopupDragHandleControlID="pnlEditGlobalSettings"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalEditGlobalSettings" />

        <act:ModalPopupExtender ID="modalNewEmp" runat="server"
            TargetControlID="cmdNewEmp"
            PopupControlID="pnlCreateEmp"
            PopupDragHandleControlID="pnlCreateEmp"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalNewEmp" />

        <act:ModalPopupExtender ID="modalCreateAccount" runat="server"
            TargetControlID="cmdDummy"
            PopupControlID="pnlCreateAccount"
            PopupDragHandleControlID="pnlCreateAccount"
            DropShadow="false"
            BackgroundCssClass="modalBackground"
            BehaviorID="modalCreateAccount" />
                
        <act:ModalPopupExtender ID="modalEditCompany" runat="server"
            TargetControlID="cmdDummy"
            PopupControlID="pnlEditCompany"
            PopupDragHandleControlID="pnlEditCompany"
            DropShadow="false"
            BackgroundCssClass="modalBackground" 
            BehaviorID="modalEditCompany" />

        <act:ModalPopupExtender ID="modalAddOrgCat" runat="server"
            TargetControlID="cmdDummy"
            PopupControlID="pnlOrgCat"
            PopupDragHandleControlID="pnlOrgCat"
            DropShadow="false"
            BehaviorID="modalAddOrgCat"
            BackgroundCssClass="modalBackground" />
                     
        <act:ModalPopupExtender ID="bubblePopup" runat="server"
            TargetControlID="cmdDummy"
            PopupControlID="pnlBubble"
            PopupDragHandleControlID="pnlBubble"
            DropShadow="false"
            BehaviorID ="modalBubble" />


<!-- =============START DATA SOURCES============================================================================== -->
        <asp:SqlDataSource ID="sqlGetActiveCC" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="pwcType" DefaultValue="C" />
                    </SelectParameters>

                    <SelectParameters>
                        <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
                    </SelectParameters>
                </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlAuditTrail" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>"
                    SelectCommand="GetAuditTrail" SelectCommandType="StoredProcedure">
                    
                    <SelectParameters>
                        <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="txtDashFrom" Name="FromDate" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="txtDashTo" Name="ToDate" PropertyName="Text" Type="DateTime" />
                    </SelectParameters>
                    
                </asp:SqlDataSource>
            
        <asp:SqlDataSource ID="sqlGetActiveProjects" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>

                <SelectParameters>
                    <asp:Parameter Name="pwcType" DefaultValue="P" />
                </SelectParameters>

                <SelectParameters>
                    <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
                </SelectParameters>
            </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlGetActiveDivisions" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
            SelectCommand="GetPWCByOrg" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
            </SelectParameters>

            <SelectParameters>
                <asp:Parameter Name="pwcType" DefaultValue="D" />
            </SelectParameters>

            <SelectParameters>
                <asp:Parameter Name="IncludeNonActive" DefaultValue="0" Type="Byte" />
            </SelectParameters>
        </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="sqlFinalizedReports" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
            SelectCommand="GetFinalizedReports" SelectCommandType="StoredProcedure" FilterExpression="FINALIZED_DATE>='{0}' AND FINALIZED_DATE <='{1}'">

        <SelectParameters>
            <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="selectedvalue" Type="Int32" />
        </SelectParameters>

         <FilterParameters>
            <asp:ControlParameter Name="FINALIZED_DATE" ControlID="txtFrom2" PropertyName="Text" />
         </FilterParameters>

         <FilterParameters>
            <asp:ControlParameter Name="FINALIZED_DATE" ControlID="txtTo2" PropertyName="Text" />
         </FilterParameters>
                
    </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="sqlGetUsers" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetEmployees" SelectCommandType="StoredProcedure">
        
        <SelectParameters>
            <asp:Parameter Name="AdminSection" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlAllOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetOrgs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="AdminSection" DefaultValue="1" />
        </SelectParameters>
        </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="sqlActiveEmployees" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetActiveEmployees" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
            
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlEmployees" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetEmployees" SelectCommandType="StoredProcedure"
        FilterExpression="ACTIVE = {0}" >

        <SelectParameters>
            <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />            
        </SelectParameters>

         <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>

    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetOrgs" SelectCommandType="StoredProcedure"
        FilterExpression="ACTIVE = {0}" >

        <SelectParameters>
            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="value" Type="Int32" />
        </SelectParameters>
         
         <FilterParameters>
            <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
         </FilterParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlActiveOrgs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetActiveOrgs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="value" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlOrgCategories" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
            SelectCommand="GetOrgCategories" SelectCommandType="StoredProcedure"
            FilterExpression="ACTIVE = {0}" >
        
             <SelectParameters>
                 <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
                 <asp:SessionParameter SessionField="language" Name="language" Type="String" />                         
                 <asp:Parameter Name="OrderBy" DefaultValue="GL_ACCOUNT" />
             </SelectParameters>

             <FilterParameters>
                <asp:ControlParameter Name="ACTIVE" ControlID="cboHideInactive" PropertyName="SelectedValue" />
             </FilterParameters>
    </asp:SqlDataSource>


        <asp:SqlDataSource ID="sqlGetExpenseAccounts" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetAccounts" SelectCommandType="StoredProcedure">
        
         <SelectParameters>
             <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
             <asp:Parameter Name="Type"  DefaultValue="Expense" Type="String" />             
         </SelectParameters>
    </asp:SqlDataSource>

        <asp:SqlDataSource ID="sqlCategories" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetUnselectedCategories" SelectCommandType="StoredProcedure">
         <SelectParameters>
             <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
         </SelectParameters>

         <SelectParameters>
             <asp:SessionParameter SessionField="language" Name="language" Type="String" />
         </SelectParameters>
    </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="sqlOrgTypes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetOrgTypes" SelectCommandType="StoredProcedure">

        <SelectParameters>
             <asp:SessionParameter SessionField="language" Name="language" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    
        <asp:SqlDataSource ID="sqlJurisdictions" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
        
        <SelectParameters>
             <asp:SessionParameter SessionField="language" Name="language" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
        
        <asp:SqlDataSource ID="sqlSupervisors" runat="server" 
        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
        SelectCommand="GetSupervisors" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboOrg" Name="OrgID" PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
     


    <table><tr id="dummytable"><td><asp:Button ID="cmdDummy" runat="server" Text="Button"  /></td></tr></table>


































































<script type="text/javascript">


        $("#<%=txtUsername.ClientID %>").keypress(function(event){
            var ew = event.which;
            
            if (ew==8 || ew ==0)
                return true;
            if(48 <= ew && ew <= 57)
                return true;
            if(65 <= ew && ew <= 90)
                return true;
            if(97 <= ew && ew <= 122)
                return true;
            
            return false;
        });   
        ////////////////////////////////////////////////////////////////////////////////////////////////////////

        function checkEmail(){
            //document.myform.email1
            var status = false;
            var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
            var email=$("#<%=txtEmail.ClientID %>").val();

            if (email.search(emailRegEx) == -1) {
                $("#Row-InvalidEmail").show();
                return false;
                //$("#<%=cmdSaveEmployee.ClientID %>").prop('disabled','disabled');
            }else{
                $("#Row-InvalidEmail").hide();
                $("#<%=cmdSaveEmployee.ClientID %>").removeAttr('disabled');
                //document.forms["form1"].submit();
            }
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////
            
        function getQuerystring(key, default_)
            {
            if (default_==null) default_=""; 
            key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
            var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
            var qs = regex.exec(window.location.href);
            if(qs == null)
                return default_;
            else
                return qs[1];
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////////////
        
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

        ////////////////////////////////////////////////////////////////////////////////////////////////////////
        function showAuditTrail(){
            $("#AuditTrail").show();
            $("#DashDateRange").show();
            if (document.getElementById("Dashboard")) {
                var vChild = document.getElementById("Dashboard");
                document.getElementById("tabs-5").removeChild(vChild);
            }
        }

        ////////////////////////////////////////////////////////////////////////////////////////////////////////
                                    
        function createDashboard () {
            // var org_id = $("#<%=cboOrg.ClientID %>").val();
            var org_id = $("#<%=hdnOrgID.ClientID %>").val();
            var puk = $("#<%=hdnPUK.ClientID %>").val();
            $("#DashDateRange").hide();
            $("#AuditTrail").hide();
            console.log('org_id');
            var modalProcessing = $find('modalProcessing');
            if (modalProcessing) { modalProcessing.show(); }
            console.log( org_id  );    
            $.ajax({
                type: "POST",
                url: "Admin.aspx/GetDashboard",
                //Pass the selected record id
                data: "{'orgID': '" + org_id + "','puk': '" + puk + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (dashBoard) {
                    if (document.getElementById("Dashboard")) {
                        var vChild = document.getElementById("Dashboard");
                        document.getElementById("tabs-5").removeChild(vChild);
                    }
                        
                    $(dashBoard.d).appendTo('#tabs-5');
                    $("#Dashboard").fadeIn(500);
                        
                    if (modalProcessing) { modalProcessing.hide(); }
                },
                error: function(){
                    alert('Err:1001' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                    console.log( org_id  );   
                }
            });
                        
            return true; 
            };
         
         ////////////////////////////////////////////////////////////////////////////////////////////////////////
         
         function myConfirm(dialogText, okFunc, cancelFunc, dialogTitle) {
                var buttons = {};
                var ok='OK';
                var c = $("#<%=hdnCancelText.ClientID %>").val();

                buttons[ok]=function () { if (typeof (okFunc) == 'function') { setTimeout(okFunc, 50); } $(this).dialog('destroy'); }
                buttons[c]= function () { if (typeof (cancelFunc) == 'function') { setTimeout(cancelFunc, 50); } $(this).dialog('close'); }

                $('<div style="padding: 10px; max-width: 500px; word-wrap: break-word;"><span class="labelText" style="font-size:0.9em;">' + dialogText + '</span></div>').dialog({
                    position:['middle','center'],
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
                event.preventDefault();
         }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////
         function popup(url) {                  
                var iMyWidth;
                var iMyHeight;
                //half the screen width minus half the new window width (plus 5 pixel borders).
                iMyWidth = (window.screen.width / 2) - (500 + 10);
                //half the screen height minus half the new window height (plus title and status bars).
                iMyHeight = (window.screen.height / 2) - (300 + 50);
                //Open the window.

                var popupWindow = window.open(url, 'popUpWindow',  "status=no,height=600,width=1000,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=yes,location=no,directories=no");
                popupWindow.focus(); 
         }
         ////////////////////////////////////////////////////////////////////////////////////////////////////////
         
        $(document).ready(function() {
            if($("#<%=txtFrom2.ClientID %>").val()=='' || $("#<%=txtTo2.ClientID %>").val()=='' ){
                $("#<%=cmdCSV.ClientID %>").prop('disabled','disabled');
                $("#<%=cmdTSV.ClientID %>").prop('disabled','disabled');
            }else{
                $("#<%=cmdCSV.ClientID %>").removeAttr('disabled');
                $("#<%=cmdTSV.ClientID %>").removeAttr('disabled');
            }
                        
            $("#Row-CustomReport").hide();
            $("#Row-ReportByPeriod").hide();
            $("#Row-DataRange").hide();
            $("#Row-FactorMethod2").hide();
            $("#<%=lbl511.ClientID %>").hide();
            
            if($("#<%=cboDataType.ClientID %>").val()=='Trans'){
                $("#Row-AsOf").show();                   
            }else{
                $("#Row-AsOf").hide();                   
            }        
                   
         
            if ($("#<%=hdnSelectedTab.ClientID %>").val()>0 && $("#<%=hdnSelectedTab.ClientID %>").val()<7 ){
                $("#<%=cboHideInactive.ClientID %>").show();                                    
                $("#<%=lbl378.ClientID %>").show();
            }else{
                $("#<%=cboHideInactive.ClientID %>").hide();                                    
                $("#<%=lbl378.ClientID %>").hide();                                    
            }
          
            $("#<%=cboSegment2.ClientID %> option[value='A']").attr('disabled','disabled');          
            $("#<%=cboSegment3.ClientID %>").attr('disabled','disabled');
            $("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');

            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            $(".viewVideo").mousedown(function () {
                video_id = $(this).attr("id");
                var mpe;

                if (navigator.mimeTypes ["application/x-shockwave-flash"] == undefined){
                    var mpe = $find('modalNoFlash');
                    if (mpe) {mpe.show();}
                }else{
                    switch (video_id)
                    {
                        case "org": mpe = $find('modalOrgVideo');
                                    break;
                        case "emp": mpe = $find('modalEmpVideo');
                                    break;
                        case "gs":  mpe = $find('modalVideo');
                                    break;
                    }
                    if (mpe) {mpe.show();}
                }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#Row-KM").hide();                  
            $("#Row-SummaryByProject").hide();
            $("#Row-SummaryByWorkOrder").hide();
            $("#Row-SummaryByCostCenter").hide();
            $("#Row-RITC-BC").hide();
            $("#Row-RITC-BC2").hide();
            $("#Row-InvalidEmail").hide();
            $("#Div-EmpMsg").hide();

            $(function() { $( "#radio" ).buttonset(); });

            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            $("#<%=chkConfirmOrg.ClientID %>").click(function () {
                $("#<%=hdnConfirmOrg.ClientID %>").val('');

                if ($("#<%=cboType.ClientID %>").val() > 1) {
                    var satisfied = $('#<%=chkConfirmOrg.ClientID %>:checked').val();

                    if (satisfied != undefined){
                        $("#<%=hdnConfirmOrg.ClientID %>").val('True');
                    }
                 }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=chkConfirmGS.ClientID %>").click(function () {
                $("#<%=hdnConfirmGS.ClientID %>").val('');

                    var satisfied = $('#<%=chkConfirmGS.ClientID %>:checked').val();

                    if (satisfied != undefined){
                        $("#<%=hdnConfirmGS.ClientID %>").val('True');
                    }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=txtEmail.ClientID %>").blur( function(){
                //document.myform.email1
                var status = false;
                var emailRegEx = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i;
                var email=$("#<%=txtEmail.ClientID %>").val();

                if (email.search(emailRegEx) == -1) {
                    $("tr:#Row-InvalidEmail").show();
                    $("#<%=cmdSaveEmployee.ClientID %>").attr('disabled','disabled');
                }else{
                    $("tr:#Row-InvalidEmail").hide();
                    $("#<%=cmdSaveEmployee.ClientID %>").removeAttr('disabled');
                    //if($("#<%=txtUserName.ClientID %>").prop('disabled')=='false') $("#<%=txtUserName.ClientID %>").keyup();
                }
                
            });            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            $("#<%=cboType.ClientID %>").change(function (){
                if ($(this).val() == 1) {
                        alert('Advataxes does not currently support non-profit organizations. Please check back again in the near future for this feature.');
                        $("#<%=cmdSaveCompany.ClientID %>").prop('disabled', 'disabled');

                    } else {
                         $("#<%=hdnConfirmOrg.ClientID %>").val('');

                        if ($("#<%=cboType.ClientID %>").val() > 1) {
                            var satisfied = $('#<%=chkConfirmOrg.ClientID %>:checked').val();

                            if (satisfied != undefined){
                                $("#<%=hdnConfirmOrg.ClientID %>").val('True');
                            }
                         }     

                        $('#<%=cmdSaveCompany.ClientID %>').removeAttr('disabled');
                    }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=cboSegment1.ClientID %>").change(function (){
                switch ($("#<%=cboSegment1.ClientID %>").val())
                    {
                        case "N":$("#<%=cboSegment2.ClientID %>").prop('selectedIndex', 0);
                                 $("#<%=cboSegment3.ClientID %>").prop('selectedIndex', 0);
                                 $("#<%=cboSegment4.ClientID %>").prop('selectedIndex', 0);
                                 $("#<%=cboSegment2.ClientID %>").attr('disabled','disabled');                                 
                                 $("#<%=cboSegment3.ClientID %>").attr('disabled','disabled');                                 
                                 $("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');                                 
                                 break;
                        case "D": $("#<%=cboSegment2.ClientID %>").prop('selectedIndex', 1);
                                  $("#<%=cboSegment3.ClientID %>").prop('selectedIndex', 0);
                                  $("#<%=cboSegment2.ClientID %> option[value='N']").attr('disabled','disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='D']").attr('disabled','disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='A']").removeAttr('disabled');
                                  $("#<%=cboSegment2.ClientID %>").removeAttr('disabled');                       
                                  $("#<%=cboSegment3.ClientID %>").removeAttr('disabled');                       
                                  $("#<%=cboSegment2.ClientID %> option[value='P']").attr('disabled','disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='C']").attr('disabled','disabled');                                            
                                  break;
                        case "A": $("#<%=cboSegment2.ClientID %>").prop('selectedIndex', 0);
                                  $("#<%=cboSegment2.ClientID %> option[value='A']").attr('disabled','disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='N']").removeAttr('disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='D']").removeAttr('disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='P']").removeAttr('disabled');
                                  $("#<%=cboSegment2.ClientID %> option[value='C']").removeAttr('disabled');
                                  $("#<%=cboSegment2.ClientID %>").removeAttr('disabled');
                                  break;
                    }

            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=cboSegment2.ClientID %>").change(function (){                
               $("#<%=cboSegment3.ClientID %>").removeAttr('disabled');
               $("#<%=cboSegment3.ClientID %> option[value='P']").removeAttr('disabled');
               $("#<%=cboSegment3.ClientID %> option[value='C']").removeAttr('disabled');                                                 
               $("#<%=cboSegment3.ClientID %>").prop('selectedIndex', 0);
               $("#<%=cboSegment4.ClientID %>").prop('selectedIndex', 0);                    
               
               switch ($("#<%=cboSegment2.ClientID %>").val())
               {
                    case "N":$("#<%=cboSegment3.ClientID %>").attr('disabled','disabled');                                 
                             $("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');                                 
                             break;
                    case "P":$("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');                                 
                             $("#<%=cboSegment3.ClientID %> option[value='C']").removeAttr('disabled');
                             $("#<%=cboSegment3.ClientID %> option[value='P']").attr('disabled','disabled');
                             break;
                    case "C":$("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');
                             $("#<%=cboSegment3.ClientID %> option[value='P']").removeAttr('disabled');
                             $("#<%=cboSegment3.ClientID %> option[value='C']").attr('disabled','disabled');
                             $("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');
                    
               }
            });                       
            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            $("#<%=cboSegment3.ClientID %>").change(function (){                
                $("#<%=cboSegment4.ClientID %>").prop('selectedIndex', 0);                    

                switch ($("#<%=cboSegment3.ClientID %>").val())
                    {
                        case "N": $("#<%=cboSegment4.ClientID %>").attr('disabled','disabled');                                 
                                  break;
                        case "P": $("#<%=cboSegment4.ClientID %> option[value='P']").attr('disabled','disabled');
                                  $("#<%=cboSegment4.ClientID %> option[value='C']").removeAttr('disabled');                
                                  if ($("#<%=cboSegment2.ClientID %>").val()!='C') $("#<%=cboSegment4.ClientID %>").removeAttr('disabled');
                                  break;
                        case "C": $("#<%=cboSegment4.ClientID %> option[value='C']").attr('disabled','disabled');
                                  $("#<%=cboSegment4.ClientID %> option[value='P']").removeAttr('disabled');                
                                  if ($("#<%=cboSegment2.ClientID %>").val()!='P') $("#<%=cboSegment4.ClientID %>").removeAttr('disabled');
                                  break;
                    }
            });                       
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=cboCalendarMatch.ClientID %>").change(function (){                
                if ($("#<%=cboCalendarMatch.ClientID %>").val()=="1"){
                    $("#Row-FirstMonth").show();
                    $("#Row-PeriodNum").show();
                }else{
                    $("#Row-FirstMonth").hide();
                    $("#Row-PeriodNum").hide();
                }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#AuditTrail").show();

            $("#Cell-SaveCompany").hide();            
            $("#Row-Jurisdiction").hide();                        
            $("#Row-LargeGST").hide();
            $("#Row-LargeQST").hide();
            //$("#Row-ReportByPeriod").hide();
            $("#dummytable").hide();
            $("#Row-GSTDate").hide();
            $("#Row-QSTDate").hide();
            $("#<%=txtGSTDate.ClientID %>").hide();
            $("#<%=txtQSTDate.ClientID %>").hide();
            $("#<%=txtGST.ClientID %>").hide();
            $("#<%=txtQST.ClientID %>").hide();            
            $("#Row-UserAlreadyExists").hide();
                                    
            $("#<%=txtGSTDate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "02/01/2012" });
            $("#<%=txtQSTDate.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "02/01/2012" });

            $("#<%=txtDashFrom.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", maxDate: new Date() });
            $("#<%=txtDashTo.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", maxDate: new Date() });
            

            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            // Dialog			
		    $('#dialog').dialog({
			    autoOpen: false,
			    height: 400,
			    width: 600,
			    modal: true,
                show: "fade",
                hide: "fade",
			    buttons: {
				    "Ok": function() { 
                        del=1;
					    $(this).dialog("close"); 
				    }
			    }
		    });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Dialog Link
            $('#dialog_link').click(function () {
                $('#dialog').dialog('open');
                return false;
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            //hover states on the static widgets
            $('#dialog_link, ul#icons li').hover(
			    function () { $(this).addClass('ui-state-hover'); },
			    function () { $(this).removeClass('ui-state-hover'); }
		    );
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Tabs
            $("#tabs").tabs({
                show: function() {
                            var selectedTab = $('#tabs').tabs('option', 'selected');
                            $("#<%= hdnSelectedTab.ClientID %>").val(selectedTab);
                        },
                selected: <%= If(String.IsNullOrEmpty(hdnSelectedTab.Value), "1", hdnSelectedTab.Value) %>,
                select: function(event, ui){ 
                        if (ui.index==4  || ui.index==6)
                            $("#Row-Org").hide();                        
                        else
                            $("#Row-Org").show();
                        
                        if (ui.index>0 && ui.index < 5 ){
                            $("#<%=cboHideInactive.ClientID %>").show();                            
                            $("#<%=lbl378.ClientID %>").show();
                        } else{
                            $("#<%=cboHideInactive.ClientID %>").hide();                        
                            $("#<%=lbl378.ClientID %>").hide();                        
                        }


                        //$("#<%=cboHideInactive.ClientID %>").val(1);
                    }
             });
             ////////////////////////////////////////////////////////////////////////////////////////////////////////

             $("#tabsAdValorem").tabs();
             $("#Row-EmpID").hide();

             ////////////////////////////////////////////////////////////////////////////////////////////////////////
                $(".delEmp").click(function () {
                    if($("#<%=hdnUserID.ClientID %>").val()!=1281)
                        alert('Unauthorized to delete');                  
                    else{

                        var record_id = $(this).attr("id");
                        
                        var row = $(this).parent("td").parent('tr');

                        if (confirm("Do you want to delete this employee?")) {
                            $.ajax({
                                type: "POST",
                                //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                url: "Admin.aspx/DeleteEmp",
                                //Pass the selected record id
                                data: "{'empID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function () {
                                    // Change the back color of the Row before deleting
                                    row.css("background-color", "red");
                                    // Do some animation effect
                                    row.fadeOut(1000, function () {
                                        row.remove();
                                    });
                                },
                                error: function(){
                                    alert('Err:1004' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                                }
                            });
                        }
                    }
                    return false;
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".delOrg").click(function () {
                    if($("#<%=hdnUserID.ClientID %>").val()!=1281)
                        alert('Unauthorized to delete');
                    
                    else{
                        var record_id = $(this).attr("id");
                        
                        var row = $(this).parent("td").parent('tr');

                        if (confirm("Do you want to delete this orginization?")) {
                            $.ajax({
                                type: "POST",
                                //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                                url: "Admin.aspx/DeleteOrg",
                                //Pass the selected record id
                                data: "{'orgID': '" + record_id + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function () {
                                    // Change the back color of the Row before deleting
                                    row.css("background-color", "red");
                                    // Do some animation effect
                                    row.fadeOut(1000, function () {
                                        row.remove();
                                    });
                                    $("#<%=cboOrg.ClientID %> option[value='" + record_id +  "']").remove();
                                    //$("#select_id option[value='foo']").remove();
                                },
                                error: function(jqXHR, textStatus, errorThrown){
                                    //alert("error " + textStatus);
                                    alert("incoming Text " + jqXHR.responseText);                                
                                    alert($("#<%=hdnUnexpectedError.ClientID %>").val());

                                }
                            });
                        }                        
                    }
                    return false;
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".selectOrg").click(function () {
                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                                      
                    //Get the GridView Row reference                    
                    var row = $(this).parent("td").parent('tr');

                    if(!row.hasClass("sel")){
                        $("tr").removeClass("sel");
                        row.addClass("sel");

                        $.ajax({
                            type: "POST",                            
                            url: "Admin.aspx/GetOrganization",
                            //Pass the selected record id
                            data: "{'orgID': '" + record_id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (organization) {
                                var s;
                                var ss;

                                if (document.getElementById("OrgInfo")) {
                                    var vChild = document.getElementById("OrgInfo");
                                    document.getElementById("tabs-1").removeChild(vChild);
                                }
                                                                    
                                s = '<div id="OrgInfo" style="position:relative;top:20px; width:100%;color:black;"><table width="100%"><tr style="font-weight:bold;"><td colspan="2" style="font-size:1.3em;font-weight:normal;color:#cd1e1e;">Details - ' + organization.d["OrganizationName"] + '</td></tr><tr style="background-color:#cd1e1e;height:1px;"><td colspan="10"></td></tr>';
                                s = s + '<tr><td width="300" class="labelText">Type:</td><td>' + organization.d["OrganizationType"] + '</td></tr>';
                                s = s + '<tr style="background-color:#efefef;"><td width="300" class="labelText">' + $("#<%=hdnOrgCodeLabelText.ClientID %>").val()  + ':</td><td>' + organization.d["OrganizationCode"] + '</td></tr>';
                                s = s + '<tr><td class="labelText">' + $("#<%=hdnJurLabelText.ClientID %>").val()  + ':</td><td>' + organization.d["JurisdictionName"] + '</td></tr>';
                                s = s + '<tr><td class="labelText">' + $("#<%=hdnGSTRegLabelText.ClientID %>").val()  + ':</td><td>';
                                if(organization.d["GSTRegistrant"]=="2") s=s+$("#<%=hdnYes.ClientID %>").val(); else s=s+ $("#<%=hdnNo.ClientID %>").val();
                                if (organization.d["GSTRegistrant"] == '2') s = s + '&nbsp;&nbsp;&nbsp;&nbsp;(' + $("#<%=hdnGST.ClientID %>").val() + '#: ' + organization.d["GSTNumber"] + ")";
                                s = s + '</td></tr>';
                                s = s + '<tr style="background-color:#efefef;"><td class="labelText">' + $("#<%=hdnQSTRegLabelText.ClientID %>").val()  + ':</td><td>';
                                if(organization.d["QSTRegistrant"]=="2") s=s+$("#<%=hdnYes.ClientID %>").val(); else s=s+ $("#<%=hdnNo.ClientID %>").val();
                                if (organization.d["QSTRegistrant"] == '2') s = s + '&nbsp;&nbsp;&nbsp;&nbsp;(' + $("#<%=hdnQST.ClientID %>").val() + '#: ' + organization.d["QSTNumber"] + ")";
                                s = s + '</td></tr>';
                                    
                                ss='';
                                if (organization.d["GSTRegistrant"] == '2') {
                                    s = s + '<tr ' +  ss +  '><td class="labelText">' + $("#<%=hdnLargeGSTLabelText.ClientID %>").val()  + ':</td><td>';
                                    if(organization.d["GSTSize"]=="2") s=s+$("#<%=hdnYes.ClientID %>").val(); else s=s+ $("#<%=hdnNo.ClientID %>").val();
                                    s = s + '</td></tr>';
                                    if(ss=='style="background-color:#efefef;"') ss=''; else ss='style="background-color:#efefef;"';
                                }
                                    
                                if (organization.d["QSTRegistrant"] == '2') {
                                    s = s + '<tr ' + ss + '><td class="labelText">' + $("#<%=hdnLargeQSTLabelText.ClientID %>").val()  + ':</td><td>';
                                    if(organization.d["QSTSize"]=="2") s=s+$("#<%=hdnYes.ClientID %>").val(); else s=s+ $("#<%=hdnNo.ClientID %>").val();
                                    s = s + '</td></tr>';
                                    if(ss=='style="background-color:#efefef;"') ss=''; else ss='style="background-color:#efefef;"';
                                }
                                        
                                if (organization.d["GSTRegistrant"] == '2' || organization.d["QSTRegistrant"] == '2'){
                                    s = s + '<tr ' + ss + '><td class="labelText">' + $("#<%=hdnRatioLabelText.ClientID %>").val()  + ':</td>'
                                    if(ss=='style="background-color:#efefef;"') ss=''; else ss='style="background-color:#efefef;"';

                                        if (organization.d["GSTRegistrant"] == '2') {
                                            var numCRA_GST = organization.d["CRA_GST"] * 1;
                                            s = s + '<td>' + $("#<%=hdnGSTRatio.ClientID %>").val() + ': ' + numCRA_GST.toFixed(0) + "%</td>" ;
                                        }
                                
                                        if (organization.d["QSTRegistrant"] == '2') {
                                            var numCRA_QST = organization.d["CRA_QST"] * 1;
                                            if (organization.d["GSTRegistrant"] == '2') { s=s+"<tr " + ss +  "><td></td>" };
                                            s = s + '<td>' + $("#<%=hdnQSTRatio.ClientID %>").val() + ': ' + numCRA_QST.toFixed(0) + "%</td>" ;
                                            if (organization.d["GSTRegistrant"] == '2') { s=s+"</tr>" };
                                            if(ss=='style="background-color:#efefef;"') ss=''; else ss='style="background-color:#efefef;"';
                                        }

                                    s += '</td></tr>';
                                }

                                if (organization.d["GSTSize"] == '2')
                                    s += '<tr ' + ss + '><td class="labelText">' + $("#<%=hdnRITCKMLabelText.ClientID %>").val()  + ': </td><td>ON: ' + organization.d["KM_ON"] + '% ' + $("#<%=hdnPEI.ClientID %>").val() + ':  ' + organization.d["KM_PEI"] + '% </td></tr>'

                                s += "<tr style='background-color:#cd1e1e;height:1px;'><td colspan='10'></td></tr>"
                                s += "</table></div>";
                                $(s).appendTo('#tabs-1');
                                $("#OrgInfo").hide();
                                $("#OrgInfo").fadeIn(1500);
                            },
                            error: function(){
                                alert('Err:1005' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                        
                        return true; 
                    }         
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////                               
                
                $("#<%=cboData.ClientID %>").change(function () {
                    if($("#<%=cboData.ClientID %>").val()=='X1' || $("#<%=cboData.ClientID %>").val()=='X2' || $("#<%=cboData.ClientID %>").val()=='X3')
                        $("#Row-AsOf").show();   
                    else
                        $("#Row-AsOf").hide();   

                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=chkIsSuper.ClientID %>").click(function () {
                        var record_id = $("#<%=txtEmpID.ClientID %>").val();
                        var lang=$("#<%=hdnLanguage.ClientID %>").val();

                        if (record_id>0){
                            $.ajax({
                                type: "POST",
                                url: "Admin.aspx/SetSuper",
                                data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    if(result.d=='Successful'){
                                        $("#<%=chkFinalizer.ClientID %>").prop('checked',false);                    
                                    }
                                    else{
                                        $("#<%=lblEmpMsg.ClientID %>").text(result.d);
                                        $("#Div-EmpMsg").show();
                                        if($("#<%=chkFinalizer.ClientID %>").prop('checked')==true)
                                            $("#<%=chkIsSuper.ClientID %>").prop('checked',false);
                                        else
                                            $("#<%=chkIsSuper.ClientID %>").prop('checked',true); 
                                    }
                                },
                                error: function(){
                                    alert('Err:1006' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                                }
                            });
                        }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=chkFinalizer.ClientID %>").click(function () {
                        var record_id = $("#<%=txtEmpID.ClientID %>").val();
                        var lang=$("#<%=hdnLanguage.ClientID %>").val();
                        
                        if (record_id>0){
                            $.ajax({
                                type: "POST",
                                url: "Admin.aspx/SetFinalizer",
                                data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (result) {
                                    if(result.d=='Success'){
                                        $("#<%=chkIsSuper.ClientID %>").prop('checked',false);
                                    }
                                    else{
                                        $("#<%=lblEmpMsg.ClientID %>").text(result.d);
                                        $("#Div-EmpMsg").show();
                                        if($("#<%=chkIsSuper.ClientID %>").prop('checked')==true)
                                            $("#<%=chkFinalizer.ClientID %>").prop('checked',false);
                                        else
                                            $("#<%=chkFinalizer.ClientID %>").prop('checked',true);
                                    }

                                },
                                error: function(){
                                    alert('Err:1007' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                                }
                            });
                        }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setNotify").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('notify' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetNotify.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveNotify.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetNotify",
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                var match = /unchecked/.test(document.getElementById('notify' + record_id).src);

                                if (match)
                                    document.getElementById('notify' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('notify' + record_id).src = '../images/unchecked.png';
                            },
                            error: function(x,e){
                                alert(x.responseText);
                              }
                        });
                    },
                    function (){return false;},"Email");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setDownloaded").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('downloaded' + record_id).src);
                    var s;

                    if (match)
                        s =$("#<%=hdnSetDownloaded.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveDownloaded.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetDownloaded",
                            data: "{'rptID': '" + record_id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                var match = /unchecked/.test(document.getElementById('downloaded' + record_id).src);

                                if (match)
                                    document.getElementById('downloaded' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('downloaded' + record_id).src = '../images/unchecked.png';
                            },
                            error: function(x,e){
                                alert(x.responseText);
                              }
                        });
                    },
                    function (){return false;},$("#<%=hdnDownloaded.ClientID %>").val());
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setTagEntry").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('tagEntry' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetTagEntry.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveTagEntry.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetTagEntry",
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                                var match = /unchecked/.test(document.getElementById('tagEntry' + record_id).src);

                                if (match)
                                    document.getElementById('tagEntry' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('tagEntry' + record_id).src = '../images/unchecked.png';
                            },
                            error: function(x,e){
                                alert(x.responseText);
                              }
                        });
                    },
                    function (){return false;},"Tag Entry");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setSuper").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('super' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetApprover.ClientID %>").val();
                    else
                        s =$("#<%=hdnRemoveApprover.ClientID %>").val();

                    myConfirm(s,function(){

                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Admin.aspx/SetSuper",
                            //Pass the selected record id
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (returnVal) {
                                
                                if(returnVal.d=='Successful'){
                                    var match = /unchecked/.test(document.getElementById('super' + record_id).src);

                                    if (match){
                                        document.getElementById('super' + record_id).src = '../images/checked.png';
                                        document.getElementById('finalizer' + record_id).src = '../images/unchecked.png';
                                        $("#<%=cboSupervisor.ClientID %>").append($('<option></option>').val(record_id).html(returnVal.d[0]));
                                        $("#<%=cboFinalizer.ClientID %> option[value='" + record_id +  "']").remove();
                                    }
                                    else{
                                        document.getElementById('super' + record_id).src = '../images/unchecked.png';
                                        $("#<%=cboSupervisor.ClientID %> option[value='" + record_id +  "']").remove();
                                    }
                            
                                    window.location="admin.aspx?tab=1"
                                }
                                else{
                                
                                    myMsg(returnVal.d,function () { return true; },"Message");    
                                }
                            },
                            error: function(){
                                alert('Err:1008' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                            }
                        });
                    },
                    function () { return false; }, "Approver");
                    
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setFinalizer").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('finalizer' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetFinalizer.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveFinalizer.ClientID %>").val();

                    myConfirm(s,function(){

                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Admin.aspx/SetFinalizer",
                            //Pass the selected record id
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (returnVal) {
                                if(returnVal.d=='Successful'){
                                    var match = /unchecked/.test(document.getElementById('finalizer' + record_id).src);

                                    if (match){
                                        document.getElementById('finalizer' + record_id).src = '../images/checked.png';
                                        document.getElementById('super' + record_id).src = '../images/unchecked.png';
                                        $("#<%=cboFinalizer.ClientID %>").append($('<option></option>').val(record_id).html(returnVal.d[0]));
                                        $("#<%=cboSupervisor.ClientID %> option[value='" + record_id +  "']").remove();
                                    }
                                    else{
                                        document.getElementById('finalizer' + record_id).src = '../images/unchecked.png';
                                        $("#<%=cboFinalizer.ClientID %> option[value='" + record_id +  "']").remove();
                                    }
                                
                                    window.location="admin.aspx?tab=1"
                                }
                                else
                                    myMsg(returnVal.d,function () { return true; },"Message");    

                            },
                            error: function(){
                                alert('Err:1009' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                            }
                        });
                    },
                    function () { return false; }, "Finalizer");
                    
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setActiveOrg").click(function () {

                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                    var userID = $("#<%=hdnUserID.ClientID %>").val();
                                        
                    var match = /unchecked/.test(document.getElementById('activeOrg' + record_id).src);
                    var s

                    if (match)
                        s = $("#<%=hdnSetOrgActive.ClientID %>").val();
                    else
                        s = $("#<%=hdnSetOrgInactive.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Admin.aspx/SetActiveOrg",
                            //Pass the selected record id
                            data: "{'orgID': '" + record_id + "','userID': '" + userID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (organizationName) {
                                
                                var match = /unchecked/.test(document.getElementById('activeOrg' + record_id).src);

                                if (match){
                                    document.getElementById('activeOrg' + record_id).src = '../images/checked.png';
                                    $("#<%=cboOrg.ClientID %>").append($('<option></option>').val(record_id).html(organizationName.d));
                                }
                                else{
                                    document.getElementById('activeOrg' + record_id).src = '../images/unchecked.png';
                                    $("#<%=cboOrg.ClientID %> option[value='" + record_id +  "']").remove();
                                }
                            },
                            error: function(){
                                alert('Err:1010' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"Organization Status");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setActiveAcc").click(function () {
                    var record_id = $(this).attr("id");
                    var userID = $("#<%=hdnUserID.ClientID %>").val();
                                        
                    var match = /unchecked/.test(document.getElementById('activeAcc' + record_id).src);
                    var s

                    if (match)
                        s = $("#<%=hdnSetAccActive.ClientID %>").val();
                    else
                        s = $("#<%=hdnSetAccInactive.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetActiveAccount",
                            data: "{'accID': '" + record_id + "','userID': '" + userID + "'}",
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
                                alert('Err:1011' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"Status");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                $(".setActiveOC").click(function () {
                    
                    var record_id = $(this).attr("id");
                    var userID = $("#<%=hdnUserID.ClientID %>").val();
                                        
                    var match = /unchecked/.test(document.getElementById('activeOC' + record_id).src);
                    var s

                    if (match)
                        s = $("#<%=hdnActiveCatMsg.ClientID %>").val();
                    else
                        s = $("#<%=hdnInactiveCatMsg.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetActiveOrgCategory",
                            data: "{'orgCatID': '" + record_id + "','userID': '" + userID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {

                                var match = /unchecked/.test(document.getElementById('activeOC' + record_id).src);

                                if (match)
                                    document.getElementById('activeOC' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('activeOC' + record_id).src = '../images/unchecked.png';
                            },
                            error: function(){
                                alert('Err:1012' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                            }

                        });

                    },
                    function(){return false;},$("#<%=hdnCatStatusMsgTitle.ClientID %>").val());
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setActive").click(function () {

                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                    var userID = $("#<%=hdnUserID.ClientID %>").val();
                    
                    
                    var match = /unchecked/.test(document.getElementById('active' + record_id).src);
                    var s

                    if (match)
                        s = $("#<%=hdnSetEmpActive.ClientID %>").val();
                    else
                        s =$("#<%=hdnSetEmpInactive.ClientID %>").val();

                    myConfirm(s,function(){
                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Admin.aspx/SetActive",
                            //Pass the selected record id
                            data: "{'empID': '" + record_id + "','userID': '" + userID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (returnVal) {
                                if(returnVal.d==''){
                                    var match = /unchecked/.test(document.getElementById('active' + record_id).src);

                                    if (match)
                                        document.getElementById('active' + record_id).src = '../images/checked.png';
                                    else
                                        document.getElementById('active' + record_id).src = '../images/unchecked.png';
                                
                                    window.location.href="Admin.aspx?tab=1";
                                
                                }else
                                    myMsg(returnVal.d,function(){return true;},"Message");

                            },
                            error: function(){
                                alert('Err:1013' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"Employee Status");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setAdmin").click(function () {

                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('admin' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetAdmin.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveAdmin.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            //GridViewDelete.aspx is the page name and DeleteUser is the server side method to delete records in GridViewDelete.aspx.cs
                            url: "Admin.aspx/SetAdmin",
                            //Pass the selected record id
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                            
                                var match = /unchecked/.test(document.getElementById('admin' + record_id).src);

                                if (match)
                                    document.getElementById('admin' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('admin' + record_id).src = '../images/unchecked.png';
                            },
                            error: function(){
                                alert('Err:1014' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"Admin");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".setViewReports").click(function () {
                    var record_id = $(this).attr("id");
                    var match = /unchecked/.test(document.getElementById('viewReports' + record_id).src);
                    var s;
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    if (match)
                        s = $("#<%=hdnSetViewReports.ClientID %>").val();
                    else
                        s = $("#<%=hdnRemoveViewReports.ClientID %>").val();

                    myConfirm(s, function(){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/SetViewReports",
                            data: "{'empID': '" + record_id + "','lang': '" + lang + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function () {
                            
                                var match = /unchecked/.test(document.getElementById('viewReports' + record_id).src);

                                if (match)
                                    document.getElementById('viewReports' + record_id).src = '../images/checked.png';
                                else
                                    document.getElementById('viewReports' + record_id).src = '../images/unchecked.png';                                    
                            },
                            error: function(){
                                alert('Err:1015' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    },
                    function(){return false;},"");
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".viewGLAccount").click(function () {
                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                    var puk=$("#<%=hdnPUK.ClientID %>").val();
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    $("#<%=hdnOrgCatID.ClientID %>").val(record_id);
                    
                    
                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/GetOrgCategory",
                        data: "{'orgCatID': '" + record_id + "','lang': '" + lang + "','puk': '" + puk + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (OrgCategory) {

                            $("#<%=cboAccount.ClientID %>").hide();
                            $("#<%=lblAccount.ClientID %>").show();
                            $("#<%=txtNote.ClientID %>").prop('disabled','disabled');
                            $("#<%=txtAllowance.ClientID %>").prop('disabled','disabled');                                
                            $("#<%=cmdSaveOC.ClientID %>").hide();
                            $("#cmdCancelOC").css('left','100px');
                            
                            var numAllowanceAmount = OrgCategory.d["AllowanceAmount"] * 1;
                            
                            $("#<%=lblAccount.ClientID %>").text(OrgCategory.d["AccountName"]);
                            $("#<%=txtNote.ClientID %>").val(OrgCategory.d["Note"]);
                            $("#<%=lblCatName.ClientID %>").text(OrgCategory.d["CategoryName"]);
                            $("#<%=txtAllowance.ClientID %>").val(numAllowanceAmount.toFixed(2));
                            $("#<%=cboDefaultCC.ClientID %>").val(OrgCategory.d["DefaultCostCenterID"]);
                            $("#<%=cboDefaultCC.ClientID %>").prop('disabled','disabled');
                                                                                                                                                 
                            if (OrgCategory.d["IsAllowance"] == 1)
                                $("#<%=lbl288.ClientID %>").text($("#<%=hdnFixedAmt.ClientID %>").val());                                
                            else                             
                                $("#<%=lbl288.ClientID %>").text($("#<%=hdnLimitAmt.ClientID %>").val());

                           $("#Row-Note").show();
                           
                           $("#Row-RequiresProject").hide();
                           $("#Row-RequiresCC").hide();
                           $("#Row-FactorMethod").hide();

                           if(OrgCategory.d["RequiredSegment"] && OrgCategory.d["RequiredSegment"].indexOf('P')==-1) $("#Row-RequiresProject2").hide(); else $("#Row-RequiresProject2").show();
                           if(OrgCategory.d["RequiredSegment"] && OrgCategory.d["RequiredSegment"].indexOf('C')==-1) $("#Row-RequiresCC2").hide(); else $("#Row-RequiresCC2").show();
                           if(OrgCategory.d["FactorMethod"] && OrgCategory.d["FactorMethod"] ===1) $("#Row-FactorMethod2").show(); else $("#Row-FactorMethod2").hide();
                           
                            var modalAddOrgCat = $find('modalAddOrgCat');
                            if (modalAddOrgCat) { modalAddOrgCat.show(); }
                        },
                        error: function(){
                            alert('Err:1016' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".selCat").click(function () {
                    $("#<%=hdnOrgCatID.ClientID %>").val(0);
                    var record_id = $(this).attr("id");
                    
                    $("#<%=hdnSelCat.ClientID %>").val(record_id);
                    
                    $("#<%=txtNote.ClientID %>").val('');
                    $("#<%=cboAccount.ClientID %>").show();
                    $("#<%=lblAccount.ClientID %>").hide();
                    $("#<%=txtNote.ClientID %>").removeAttr('disabled');
                    $("#<%=txtAllowance.ClientID %>").removeAttr('disabled');
                    $("#<%=cboDefaultCC.ClientID %>").removeAttr('disabled');
                    $("#<%=txtAllowance.ClientID %>").val('0.00');                    
                    $("#<%=cmdSaveOC.ClientID %>").show();
                    $("#Row-RequiresProject2").hide(); 
                    $("#Row-RequiresCC2").hide(); 
                    $("#Row-FactorMethod2").hide(); 

                    var lang=$("#<%=hdnLanguage.ClientID %>").val();

                    
                    var row = $(this).parent("td").parent('tr');

                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/GetCategory",
                        data: "{'catID': '" + record_id + "','lang': '" + lang + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (category) {
                                $("#Row-Note").show();
                        
                                if (category.d["IsAllowance"] == 1)
                                    $("#<%=lbl288.ClientID %>").text($("#<%=hdnFixedAmt.ClientID %>").val());
                                else
                                    $("#<%=lbl288.ClientID %>").text($("#<%=hdnLimitAmt.ClientID %>").val());
                                                    
                                $("#<%=lblCatName.ClientID %>").text(category.d["CategoryName"]);
                        
                                if($("#<%=hdnAccSeg.ClientID %>").val().indexOf('P')==-1) $("#Row-RequiresProject").hide(); else $("#Row-RequiresProject").show();
                                if($("#<%=hdnAccSeg.ClientID %>").val().indexOf('C')==-1) $("#Row-RequiresCC").hide(); else $("#Row-RequiresCC").show();
                                if(category.d["AllowFactorMethod"]==1) $("#Row-FactorMethod").show(); else $("#Row-FactorMethod").hide();
                        
                                var modalAddOrgCat = $find('modalAddOrgCat');
                                if (modalAddOrgCat) { modalAddOrgCat.show(); }

                        },
                        error: function(){
                            alert('Err:1017' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".catDesc").mousedown(function () {
                    var record_id = $(this).attr("id");
                    var lang=$("#<%=hdnLanguage.ClientID %>").val();
                    
                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/GetCategory",
                        data: "{'catID': '" + record_id + "','lang': '" + lang + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (category) {
                    		if (document.getElementById("Desc")) {
		                        var vChild = document.getElementById("Desc");
                		        document.getElementById("dialog").removeChild(vChild);
		                    }

       	                    $("<div id='Desc'><table><tr><td width='475px'><p style='color:#cd1e1e;font-weight:bold;font-size:1.2em;'>" + category.d["CategoryName"] + "</td><td align='right'><img src='../images/av.png' width='60px' height='50px' /></td></tr><tr style='height=0.1em;background-color:#cd1e1e;'><td colspan='10'></td></tr><tr style='height:10px;'><td colspan='10'></td></tr><tr><td colspan='2'>" + category.d["CategoryDescription"] + "</td></tr></table></div>").appendTo("#dialog");
                      	    $( "#dialog" ).dialog( "open" );	
                        },
                        error: function(){
                            alert('Err:1018' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".editEmp").click(function () {
                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                    var puk=$("#<%=hdnPUK.ClientID %>").val();
                
                    $("#<%=lblInvalidUsername.ClientID %>").text("");
                    $("#Row-UserAlreadyExists").hide();
                    $("#Div-EmpMsg").hide();

                    $("#<%=cmdSaveEmployee.ClientID %>").removeAttr('disabled');
                    $("#<%=cboDelegate.ClientID %> option[value='" + record_id + "']").attr('disabled','disabled');

                    $("#<%=cboDelegate.ClientID %> option[value='" + $("#<%=hdnLastDelegateDisabled.ClientID %>").val() + "']").removeAttr('disabled');                                        
                    $("#<%=hdnLastDelegateDisabled.ClientID %>").val(record_id);

                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/GetEmployee",
                        data: "{'empID': '" + record_id + "','puk': '" + puk + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (employee) {
                            
                            $("#<%=txtUserName.ClientID %>").prop('disabled','disabled');
                            $("#<%=txtLName.ClientID %>").prop('disabled','disabled');                           
                            $("#<%=txtFName.ClientID %>").prop('disabled','disabled');                            

                            $("#<%=txtLName.ClientID %>").val(employee.d["LastName"]);
                            $("#<%=txtFName.ClientID %>").val(employee.d["FirstName"]);
                            $("#<%=txtEmail.ClientID %>").val(employee.d["Email"]);
                            $("#<%=txtUserName.ClientID %>").val(employee.d["UserName"]);
                            $("#<%=txtEmpID.ClientID %>").val(employee.d["EmployeeID"]);
                            $("#<%=hdnOrgID.ClientID %>").val(employee.d["OrganizationID"]);
                            $("#<%=cboSupervisor.ClientID %>").val(employee.d["Supervisor"]);
                            $("#<%=cboDefaultProject.ClientID %>").val(employee.d["DefaultProjectID"]);
                            $("#<%=cboFinalizer.ClientID %>").val(employee.d["Finalizer"]);
                            $("#<%=cboDelegate.ClientID %>").val(employee.d["DelegatedTo"]);
                            
                            if(employee.d["Finalizer"]=='0' && employee.d["OrganizationApprovalLevels"]=='2'){
                                $("#<%=lblEmpMsg.ClientID %>").text($("#<%=hdnAprvrFnlzrReq.ClientID %>").val());                                
                                $("#Div-EmpMsg").show();
                            }else if(employee.d["Supervisor"]=='0'){
                                $("#<%=lblEmpMsg.ClientID %>").text($("#<%=hdnApproverReq.ClientID %>").val());
                                $("#Div-EmpMsg").show();
                            }

                            if(employee.d["EmployeeNumber"]!='null'){
                                $("#<%=txtEmpNum.ClientID %>").val(employee.d["EmployeeNumber"]);
                                $("#<%=txtEmpNum.ClientID %>").prop('disabled','disabled');
                            }else
                                $("#<%=txtEmpNum.ClientID %>").removeAttr('disabled');

                            if(employee.d["Division"]!='null'){
                                $("#<%=cboDiv.ClientID %>").val(employee.d["Division"]);
                                $("#<%=cboDiv.ClientID %>").prop('disabled','disabled');
                            }else
                                $("#<%=cboDiv.ClientID %>").removeAttr('disabled');

                            if (employee.d["IsAdmin"] == 0) $("#<%=chkIsAdmin.ClientID %>").prop("checked", false); else $("#<%=chkIsAdmin.ClientID %>").prop("checked", true);
                            if (employee.d["IsAccountant"] == 0) $("#<%=chkViewReports.ClientID %>").prop("checked", false); else $("#<%=chkViewReports.ClientID %>").prop("checked", true);
                            if (employee.d["EmployeeApprovalLevel"] == 1) $("#<%=chkIsSuper.ClientID %>").prop("checked", true); else $("#<%=chkIsSuper.ClientID %>").prop("checked", false);
                            if (employee.d["Notify"] == 0) $("#<%=chkNotify.ClientID %>").prop("checked", false); else $("#<%=chkNotify.ClientID %>").prop("checked", true);
                            if (employee.d["AllowTagEntry"] == 0) $("#<%=chkTagEntry.ClientID %>").prop("checked", false); else $("#<%=chkTagEntry.ClientID %>").prop("checked", true);
                            if (employee.d["EmployeeApprovalLevel"] == 2) $("#<%=chkFinalizer.ClientID %>").prop("checked", true); else $("#<%=chkFinalizer.ClientID %>").prop("checked", false);                            
                            if (employee.d["LockDefaultProject"] == 1) $("#<%=chkLockDefaultProject.ClientID %>").prop("checked", true); else $("#<%=chkLockDefaultProject.ClientID %>").prop("checked", false);                            
                            
                            var modalNewEmployee = $find('modalNewEmp');
                            if (modalNewEmployee) { modalNewEmployee.show(); }
                        },
                        error: function(){
                            alert('Err:1019' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".editOrg").click(function () {
                    var record_id = $(this).attr("id");
                    
                    $("#<%=hdnExecuteSave.ClientID %>").val('True');
                    document.getElementById("<%=RequiredFieldValidator5.ClientID%>").style.visibility = "hidden"; document.getElementById("<%=RequiredFieldValidator6.ClientID%>").style.visibility = "hidden"; document.getElementById("<%=RequiredFieldValidator7.ClientID%>").style.visibility = "hidden";

                    $("#<%=txtOrgName.ClientID %>").prop('disabled','disabled');
                    $("#<%=cboType.ClientID %>").prop('disabled','disabled');
                    $("#<%=txtOrgID2.ClientID %>").val(record_id);

                    var modalEditCompany = $find('modalEditCompany');
                    if (modalEditCompany) { modalEditCompany.show(); }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".newAccount").click(function () {
                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                                                          
                    var mpe = $find('modalCreateAccount');
                    if (mpe) { mpe.show(); }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".newOrg").click(function () {
                    //Get the Id of the record to delete
                    var record_id = $(this).attr("id");
                                       
                    $("#Warning").show();

                    $("#<%=hdnExecuteSave.ClientID %>").val('True');
                    $("#Row-CRA").hide();
                    $("#<%=cboQSTRate.ClientID %>").hide();
                    $("#<%=lbl194.ClientID %>").hide();
                    $("#<%=cboGSTRate.ClientID %>").hide();
                    $("#<%=lbl193.ClientID %>").hide();
                    $("#<%=txtOrgName.ClientID %>").val('');
                    $("#<%=cboType.ClientID %>").val('');
                    //$("txtAddress1").val('');
                    //$("txtAddress2").val('');
                    $("#<%=cboJurisdiction.ClientID %>").val('');
                    $("#<%=cboGSTReg.ClientID %>").prop('selectedIndex', 0);
                    $("#<%=txtGST.ClientID %>").val('');
                    $("#<%=txtGST.ClientID %>").hide();
                    $("#<%=lbl188.ClientID %>").hide();
                    $("#<%=cboQSTReg.ClientID %>").prop('selectedIndex', 0);
                    $("#<%=txtQST.ClientID %>").val('');
                    $("#<%=txtQST.ClientID %>").hide();
                    $("#<%=lbl189.ClientID %>").hide();
                    $("#Row-QSTDate").hide();
                    $("#Row-GSTDate").hide();
                    $("#<%=txtQSTDate.ClientID %>").val('01/01/2012');
                    $("#<%=txtGSTDate.ClientID %>").val('01/01/2012');
                    //$("#Row-Retention").hide();
                    //$("#Row-AcctPayable").hide();
                    $("#<%=cboGSTReg.ClientID %>").prop('selectedindex',0);
                    $("#<%=cboQSTReg.ClientID %>").prop('selectedindex',0);
                    
                    $("#<%=cboLargeGST.ClientID %>").prop('selectedIndex', 0);
                    $("#<%=cboLargeQST.ClientID %>").prop('selectedIndex', 0);
                    
                    $("#<%=cboGSTReg.ClientID %>").removeAttr("disabled");
                    $("#<%=cboQSTReg.ClientID %>").removeAttr("disabled");
                    $("#<%=cboType.ClientID %>").removeAttr("disabled");
                    $("#<%=cboLargeGST.ClientID %>").removeAttr("disabled");
                    $("#<%=cboLargeQST.ClientID %>").removeAttr("disabled");
                    $("#<%=cboGSTRate.ClientID %>").removeAttr("disabled");
                    $("#<%=cboQSTRate.ClientID %>").removeAttr("disabled");
                    $("#<%=txtOrgName.ClientID %>").removeAttr("disabled");
                    $("#<%=cboJurisdiction.ClientID %>").removeAttr("disabled");
                    
                    $("#<%=cboGSTRate.ClientID %>").prop('selectedIndex',0);
                    $("#<%=cboQSTRate.ClientID %>").prop('selectedIndex',0);
                    //$("#<%=cboRetention.ClientID %>").prop('selectedIndex', 0);
                    $("#<%=txtOrgID2.ClientID %>").val('0');
                    //$("#<%=txtAcctPayable.ClientID %>").val('');
                     
                    var mpe = $find('modalEditCompany');
                    if (mpe) { mpe.show(); }

                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                
                $(".cancelSaveCompany").mousedown(function () {
                    var mpe = $find('modalEditCompany');
                    if (mpe) { mpe.hide(); }
                    document.getElementById("<%=RequiredFieldValidator5.ClientID%>").style.visibility = "hidden";
                    document.getElementById("<%=RequiredFieldValidator6.ClientID%>").style.visibility = "hidden";
                    document.getElementById("<%=RequiredFieldValidator7.ClientID%>").style.visibility = "hidden";
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboFinalizer.ClientID %>").change(function () {
                    $("#<%=cboSupervisor.ClientID %>").change();
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboSupervisor.ClientID %>").change(function () {
                    if($("#<%=cboSupervisor.ClientID %>").val()=='0' && $("#<%=cboFinalizer.ClientID %>").val()=='0'){
                        $("#<%=lblEmpMsg.ClientID %>").text($("#<%=hdnAprvrFnlzrReq.ClientID %>").val());  
                        $("#Div-EmpMsg").show();
                    
                    }else if($("#<%=cboSupervisor.ClientID %>").val()=='0') {
                        $("#<%=lblEmpMsg.ClientID %>").text($("#<%=hdnApproverReq.ClientID %>").val());
                        $("#Div-EmpMsg").show();
                    
                    }else if($("#<%=cboFinalizer.ClientID %>").is(':visible') && $("#<%=cboFinalizer.ClientID %>").val()=='0'){
                        $("#<%=lblEmpMsg.ClientID %>").text($("#<%=hdnFinalizerReq.ClientID %>").val());
                        $("#Div-EmpMsg").show();
                    }else
                        $("#Div-EmpMsg").hide();
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboLargeGST.ClientID %>").change(function () {
                    if ($("#<%=cboLargeGST.ClientID %>").val()=='2')
                        $("#Row-KM").show();
                    else{
                        $("#Row-KM").hide();
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboGSTReg.ClientID %>").change(function () {                
                    if ($("#<%=cboQSTReg.ClientID %>").val()=='1' && $("#<%=cboGSTReg.ClientID %>").val()=='1')
                        $("#Row-CRA").hide();
                    else{
                        $("#Row-CRA").show();
                        if ($("#<%=cboQSTReg.ClientID %>").val()=='2') $("#Row-CRA-QST").show(); else $("#Row-CRA-QST").hide();
                        if ($("#<%=cboGSTReg.ClientID %>").val()=='2') $("#Row-CRA-GST").show(); else $("#Row-CRA-GST").hide();
                    }

                    if ($("#<%=cboGSTReg.ClientID %>").val()=='1'){
                        $("#Row-GSTDate").hide();
                        $("#Row-LargeGST").hide();
                        $("#<%=txtGST.ClientID %>").hide();
                        $("#<%=txtGST.ClientID %>").val('');
                        $("#<%=lbl188.ClientID %>").hide();
                        $("#<%=cboGSTRate.ClientID %>").hide();
                        $("#<%=lbl193.ClientID %>").hide();                        
                    }
                    else{
                        //$("#Row-GSTDate").show();
                        $("#Row-LargeGST").show();
                        $("#<%=txtGST.ClientID %>").show();
                        $("#<%=lbl188.ClientID %>").show();
                        $("#<%=cboGSTRate.ClientID %>").show();
                        $("#<%=lbl193.ClientID %>").show();
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboGSTDate.ClientID %>").change(function () {
                    if ($("#<%=cboGSTDate.ClientID %>").val()=='1')
                        $("#<%=txtGSTDate.ClientID %>").hide();
                    else{
                        $("#<%=txtGSTDate.ClientID %>").val('02/01/2012');
                        $("#<%=txtGSTDate.ClientID %>").show();
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboQSTReg.ClientID %>").change(function () {
                    if ($("#<%=cboQSTReg.ClientID %>").val()=='1' && $("#<%=cboGSTReg.ClientID %>").val()=='1')
                        $("#Row-CRA").hide();
                    else{
                        $("#Row-CRA").show();
                        if ($("#<%=cboQSTReg.ClientID %>").val()=='2') $("#Row-CRA-QST").show(); else  $("#Row-CRA-QST").hide();
                        if ($("#<%=cboGSTReg.ClientID %>").val()=='2') $("#Row-CRA-GST").show(); else $("#Row-CRA-GST").hide();
                    }
                    
                    if ($("#<%=cboQSTReg.ClientID %>").val()=='1'){
                        $("#Row-QSTDate").hide();
                        $("#Row-LargeQST").hide();
                        $("#<%=txtQST.ClientID %>").hide();
                        $("#<%=txtQST.ClientID %>").val('');
                        $("#<%=lbl189.ClientID %>").hide();
                        $("#<%=cboQSTRate.ClientID %>").hide();
                        $("#<%=lbl194.ClientID %>").hide();
                    }
                    else{
                        $("#<%=txtQST.ClientID %>").show();
                        $("#<%=lbl189.ClientID %>").show();
                        //$("#Row-QSTDate").show();
                        $("#Row-LargeQST").show();
                        $("#<%=cboQSTRate.ClientID %>").show();
                        $("#<%=lbl194.ClientID %>").show();                     
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboQSTDate.ClientID %>").change(function () {
                    if ($("#<%=cboQSTDate.ClientID %>").val()=='1')
                        $("#<%=txtQSTDate.ClientID %>").hide();
                    else{
                        $("#<%=txtQSTDate.ClientID %>").val('02/01/2012');
                        $("#<%=txtQSTDate.ClientID %>").show();
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".viewRpt").click(function () { popup("../account/ExpenseReport.aspx?id=" + $(this).attr("id")  + "&se=true"); });
                $(".viewDetailedRpt").click(function () { popup("../account/ExpenseReport.aspx?type=21&id=" + $(this).attr("id") +  "&se=true"); });
                $(".viewDetailedRpt2").click(function () { popup("../account/ExpenseReport.aspx?type=21&id=" + $(this).attr("id") + "&accNames=true" + "&se=true"); });

                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                $(".printRpt").mousedown(function () {
                    $("#<%=lbl511.ClientID %>").hide();
                    
                    if ($("#<%=cboDataType.ClientID %>").val()=='Trans'){
                        if ($("#<%=txtAsOf.ClientID %>").val()=='')
                            $("#<%=lbl511.ClientID %>").show();
                        else
                            win=window.open("../Account/ExpenseReport.aspx?type=" + $("#<%=cboData.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&start=" + $("#<%=txtAsOf.ClientID %>").val() + "&rptName=" + $("#<%=cboData.ClientID %>").children("option").filter(":selected").text()   , "Data", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                        
                    }else if ($("#<%=cboData.ClientID %>").val()=='M1')
                        win=window.open("../Account/ExpenseReport.aspx?type=" + $("#<%=cboData.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&rptName=" + $("#<%=cboData.ClientID %>").children("option").filter(":selected").text()   , "Data", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                    
                    else if ($("#<%=txtFrom.ClientID %>").val()!='')
                        win=window.open("../Account/ExpenseReport.aspx?type=" + $("#<%=cboData.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&start=" +  $("#<%=txtFrom.ClientID %>").val() +  "&end=" + $("#<%=txtTo.ClientID %>").val() + "&rptName=" + $("#<%=cboData.ClientID %>").children("option").filter(":selected").text() , "Data", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                    else
                         win=window.open("../Account/ExpenseReport.aspx?type=" + $("#<%=cboData.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&rptName=" + $("#<%=cboData.ClientID %>").children("option").filter(":selected").text() , "Data", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                     
                     win.focus();
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".unlockUser").mousedown(function () {
                    var id = $(this).attr("id");
                
                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/UnlockUser",
                        data: "{'empID': '" + id + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function () {
                            alert($("#<%=hdnUnlocked.ClientID %>").val());
                            window.location.href="Admin.aspx?tab=1"
                        },
                        error: function(){
                            alert('Err:1020' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=cboDataRange.ClientID %>").change(function () {                
                    $("#Row-ReportByPeriod").hide();
                    $("#Row-CustomReport").hide();
                    
                    if ($('option:selected', '#<%=cboDataRange.ClientID %>').val()=="Period"){
                        $("#Row-ReportByPeriod").show();
                        $("#Row-ReportType").show();
                    }                    
                    else
                        $("#Row-CustomReport").show();                                         
                });

                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                //$("#<%=txtTo.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" });
                //$("#<%=txtFrom.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" });
                $("#<%=txtAsOf.ClientID %>").datepicker({ dateFormat: "dd/mm/yy", minDate: "01/01/2013", maxDate: new Date() });
                $("#<%=txtTo2.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" });
                $("#<%=txtFrom2.ClientID %>").datepicker({ dateFormat: "dd/mm/yy" });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtTo2.ClientID %>").change(function () {                
                    if($("#<%=txtTo2.ClientID %>").val()!="" && $("#<%=txtFrom2.ClientID %>").val()!=""){
                        $("#<%=cmdCSV.ClientID %>").removeAttr('disabled');
                        $("#<%=cmdTSV.ClientID %>").removeAttr('disabled');
                    }else{
                        $("#<%=cmdCSV.ClientID %>").prop('disabled','disabled');
                        $("#<%=cmdTSV.ClientID %>").prop('disabled','disabled');
                    }

                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtFrom2.ClientID %>").change(function () {                
                    if($("#<%=txtTo2.ClientID %>").val()!="" && $("#<%=txtFrom2.ClientID %>").val()!=""){
                        $("#<%=cmdCSV.ClientID %>").removeAttr('disabled');
                        $("#<%=cmdTSV.ClientID %>").removeAttr('disabled');
                    }else{
                        $("#<%=cmdCSV.ClientID %>").prop('disabled','disabled');
                        $("#<%=cmdTSV.ClientID %>").prop('disabled','disabled');
                    }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtFrom.ClientID %>").datepicker({
			        dateFormat: "dd/mm/yy",
                    defaultDate: "+1w",
			        changeMonth: true,
                    changeYear:true,
                    minDate:"01/07/2010",
			        maxDate: new Date(),
                    numberOfMonths: 1,                                        
			        onSelect: function( selectedDate ) {				        
                        $("#<%= txtTo.ClientID %>").datepicker( "option", "minDate", selectedDate );
                        
                        if($("#<%=txtTo.ClientID %>").val()==''){ $("#<%=txtTo.ClientID %>").val($("#<%=txtFrom.ClientID %>").val());}
                    }
		        });
		        ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtTo.ClientID %>").datepicker({
			         dateFormat: "dd/mm/yy",
                    defaultDate: "+1w",
			        changeMonth: true,
                    changeYear:true,
                    minDate:"01/07/2010",
                    maxDate: new Date(),
			        numberOfMonths: 1,
			        onSelect: function( selectedDate ) {
				        $("#<%= txtFrom.ClientID %>").datepicker( "option", "maxDate", selectedDate );                        
			        }
		        });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtUsername.ClientID %>").keyup(function () {
                    var username=$("#<%=txtUsername.ClientID %>").val();
                    
                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/CheckUsername",
                        data: "{'username': '" + username + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (UserID) {
                            if (UserID.d != 0) {
                                $("#Row-UserAlreadyExists").show();
                                $("#<%=cmdSaveEmployee.ClientID %>").prop('disabled', 'disabled');
                            }
                            else{
                                $("#Row-UserAlreadyExists").hide();
                                $("#<%=cmdSaveEmployee.ClientID %>").removeAttr('disabled');
                                //$("#<%=txtEmail.ClientID %>").blur();
                            }
                        },
                        error: function(){
                            alert('Err:1021' + $("#<%=hdnUnexpectedError.ClientID %>").val());

                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtEmpNum.ClientID %>").keyup(function () {
                    var empNum = $("#<%=txtEmpNum.ClientID %>").val();
                    var orgID = $("#<%=cboOrg.ClientID %>").val();
                    debugger
                    if(empNum!=''){
                        $.ajax({
                            type: "POST",
                            url: "Admin.aspx/CheckEmpNum",
                            data: "{'empNum': '" + empNum + "','orgID': '" + orgID + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            cache: false,
                            success: function (employeeNumber) {
                                if (employeeNumber.d != 0) {
                                    $("#<%=lblInvalidEmpNum.ClientID %>").text($("#<%=hdnEmpNumAlreadyAssigned.ClientID %>").val());
                                    $("#Row-EmpNumAlreadyExists").show();
                                    $("#<%=cmdSaveEmployee.ClientID %>").prop('disabled', 'disabled');
                                }
                                else{
                                    $("#<%=lblInvalidEmpNum.ClientID %>").text("");
                                    $("#Row-EmpNumAlreadyExists").hide();
                                    $("#<%=cmdSaveEmployee.ClientID %>").removeAttr('disabled');
                                }
                            },
                            error: function(){
                                alert('Err:1022' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                            }
                        });
                    }
                });                
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".getDesc").click(function () {
                    var record_id=$(this).attr("id");
                    
                    $.ajax({
                        type: "POST",
                        url: "Admin.aspx/GetDescription",
                        data: "{'id': '" + record_id + "','lang': 'E'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        async: true,
                        cache: false,
                        success: function (description) {
                    		if (document.getElementById("Desc")) {
		                        var vChild = document.getElementById("Desc");
                		        document.getElementById("dialog").removeChild(vChild);
		                    }
	                        $("<div id='Desc'><table><tr><td width='475px'><p style='color:#cd1e1e;font-weight:bold;font-size:1.2em;'>" + description.d["Title"] + "</td><td align='right'><img src='../images/av.png' width='60px' height='50px' /></td></tr><tr style='height=0.1em;background-color:#cd1e1e;'><td colspan='10'></td></tr><tr style='height:10px;'><td colspan='10'></td></tr><tr><td colspan='2'>" + description.d["Description"] + "</td></tr></table></div>").appendTo("#dialog");
                      	    $( "#dialog" ).dialog( "open" );	
                        },
                        error: function(){
                            alert('Err:1023' + $("#<%=hdnUnexpectedError.ClientID %>").val());
                        }
                    });
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#<%=txtUsername.ClientID %>").click(function () {
                    $("#<%=txtUsername.ClientID %>").keyup();
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".editGS").click(function () {
                    var modalEditGlobalSettings = $find('modalEditGlobalSettings');
                    if (modalEditGlobalSettings) { modalEditGlobalSettings.show(); }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $(".newEmp").click(function () {  
                    $("#Div-EmpMsg").hide();                  
                    var modalNewEmployee = $find('modalNewEmp');
                    if (modalNewEmployee) { modalNewEmployee.show(); }
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////
                                
                $(".popUpWin").click(function () {
                    var iMyWidth;
                    var iMyHeight;
                    //half the screen width minus half the new window width (plus 5 pixel borders).
                    iMyWidth = (window.screen.width/2) - (350 + 10);
                    //half the screen height minus half the new window height (plus title and status bars).
                    iMyHeight = (window.screen.height/2) - (150 + 50);
                    //Open the window.
                    var win2 = window.open("../info.aspx?id=" + $(this).attr("id"),"Info","status=no,height=300,width=700,resizable=yes,left=" + iMyWidth + ",top=" + iMyHeight + ",screenX=" + iMyWidth + ",screenY=" + iMyHeight + ",toolbar=no,menubar=no,scrollbars=no,location=no,directories=no");
                    win2.focus();
                });
                ////////////////////////////////////////////////////////////////////////////////////////////////////////

                $("#cmdCancelOC").click(function () {
                    var modalAddOrgCat = $find('modalAddOrgCat');
                    if (modalAddOrgCat) { modalAddOrgCat.hide(); }
                });

    });

</script>

    
</asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .style1
        {
            width: 99px;
        }
    </style>
</asp:Content>
