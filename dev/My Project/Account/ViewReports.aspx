<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ViewReports.aspx.vb" Inherits="Advataxes.ViewReports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <link href="../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" type="text/css" />
        <script src="../js/jquery-1.7.2.min.js" type="text/javascript"></script>
        <script src="../js/jquery-ui-1.8.18.custom.min.js" type="text/javascript"></script>
        <script src="../js/jquery.js" type="text/javascript"></script>

            <br />
            <br />
                <div style="height:960px;">
                <table border="0" width="70%">
                    <tr>
                        <td width="250px" class="labelText"><asp:Label ID="lbl210" runat="server" Text="Report Range:" class="labelText" /> </td>
                        <td>
                            <asp:DropDownList ID="cboReportRange" runat="server" Width="125px" AutoPostBack="false" >
                                <asp:ListItem Value="Period">By Period</asp:ListItem>                                
                                <asp:ListItem Value="Custom" Selected="True">Custom</asp:ListItem>
                            </asp:DropDownList>
                        </td>                        
                    </tr>
                    
                    <tr id="Row-CustomReport">
                        <td><asp:Label ID="lblFrom" runat="server" Text="From:" class="labelText" /></td>
                        <td  colspan="3">
                            <asp:TextBox ID="txtFrom" Text="01/01/2018" runat="server" Width="100px"></asp:TextBox>
                            <asp:Label ID="lblTo" runat="server" Text="To:" class="labelText" />&nbsp;&nbsp;<asp:TextBox ID="txtTo"  runat="server" Width="100px"></asp:TextBox>                            
                           
                        </td>
                    </tr>
                    
                    <tr id="Row-ReportByPeriod">
                        <td><asp:Label ID="lbl237" runat="server" Text="Financial Year:" class="labelText" /></td>
                        <td>
                            <asp:DropDownList ID="cboFinancialYear" runat="server" Width="125px" AutoPostBack="false" >
                            </asp:DropDownList>                            
                            <asp:Label ID="lbl244" runat="server" Text="Period:" class="labelText" />
                            <asp:DropDownList ID="cboPeriod" runat="server" Width="75px"  AutoPostBack="false" >
                            </asp:DropDownList>  
                        </td>
                    </tr>

                    <tr id="Row-ReportByEmp2">
                        <td><asp:Label ID="lbl222" runat="server" Text="Finalized Reports:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboEmpReports" runat="server" Width="200px"  AutoPostBack="false" DataSourceID="sqlFinalizedReports" DataTextField="REPORT_NAME" DataValueField="REPORT_ID" /></td>
                    </tr>

                    <tr id="Row-ReportType"><td><asp:Label ID="lbl215" runat="server" Text="Report Type:" class="labelText" /></td>
                        <td>
                            <asp:DropDownList ID="cboReportType" runat="server" Width="100%" AutoPostBack="false" >
                                <asp:ListItem Value="2">Account Summary</asp:ListItem>                                
                                <asp:ListItem Value="21">Summary Detailed</asp:ListItem>
                                <asp:ListItem Value="25">Advance Detailed</asp:ListItem>
                                <asp:ListItem Value="9">Payable to Employee</asp:ListItem>                                
                                <asp:ListItem Value="24">Detailed Third Party</asp:ListItem>
                                <asp:ListItem Value="13">Detailed ITC</asp:ListItem>
                                <asp:ListItem Value="14">Detailed ITR</asp:ListItem>
                                <asp:ListItem Value="15">Detailed RITC ON</asp:ListItem>
                                <asp:ListItem Value="16">Detailed RITC PEI</asp:ListItem>                                
                                <asp:ListItem Value="3">Detailed Posting</asp:ListItem>
                                <asp:ListItem Value="7">Expense Report</asp:ListItem>
                                <asp:ListItem Value="8">Summary by GL Account</asp:ListItem>
                                <asp:ListItem Value="4">Summary by Category</asp:ListItem>
                                <asp:ListItem Value="18">Category Summary</asp:ListItem>
                                <asp:ListItem Value="17">Detailed By Category</asp:ListItem>
                                <asp:ListItem Value="20">Jurisdiction</asp:ListItem>
                                <asp:ListItem Value="23">GST/HST/QST Paid</asp:ListItem>
                                <asp:ListItem Value="27">Duplicate</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        
                    </tr>

                    <tr id="Row-ReportByEmp">
                        <td><asp:Label ID="lbl73" runat="server" Text="Employee:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboEmp" runat="server" autopostback="false" DataSourceID="sqlEmployees" DataTextField="EMP_NUM_FULL_NAME" DataValueField="EMP_ID" Width="60%" /></td>
                    </tr>

                    <tr id="Row-Jurisdiction">
                        <td><asp:Label ID="llb43" runat="server" Text="Jurisdiction:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboJur" runat="server" AutoPostBack="false" DataSourceID="sqlJurisdictions" DataTextField="JUR_NAME" DataValueField="JUR_ID" Width="50%"  EnableViewState="false" /></td>
                    </tr>

                    <tr id="Row-SummaryByCategory">
                        <td><asp:Label ID="lbl60" runat="server" Text="Category:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboOrgCategory" runat="server" AutoPostBack="false" DataSourceID="sqlOrgCategories" DataTextField="CAT_NAME" DataValueField="ORG_CAT_ID" Width="100%"  EnableViewState="false" /></td>
                    </tr>

                    <tr id="Row-SummaryByGL">
                        <td><asp:Label ID="lbl545" name="lbl545" runat="server" Text="GL Account:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboGL" runat="server" AutoPostBack="false" DataSourceID="sqlGetExpenseAccounts" DataTextField="ACCOUNT" DataValueField="ACC_NUMBER" Width="100%"  EnableViewState="false" /></td>
                    </tr>
                    
                    <tr id="Row-SummaryByDivision">
                        <td><asp:Label ID="CT__D" runat="server" Text="Division:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboDivision" runat="server" AutoPostBack="false" DataSourceID="sqlDivisions" DataTextField="DIV_CODE" DataValueField="DIV_CODE" Width="200px" /></td>
                    </tr>
                                   
                    <tr id="Row-SummaryByProject">
                        <td><asp:Label ID="CT___P" runat="server" Text="Project:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboProject" runat="server" AutoPostBack="false" DataSourceID="sqlFinalizedProjects" DataTextField="PROJECT" DataValueField="PROJECT" Width="200px"  EnableViewState="false" /></td>
                    </tr>

                    <tr id="Row-SummaryByCostCenter">
                        <td><asp:Label ID="CT___C" runat="server" Text="Cost Center:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboCostCenter" runat="server" AutoPostBack="false" DataSourceID="sqlFinalizedCostCenters" DataTextField="COST_CENTER" DataValueField="COST_CENTER" Width="200px"  EnableViewState="false" /></td>
                    </tr>

                    <tr id="Row-SummaryByWorkOrder">
                        <td><asp:Label ID="CTW" runat="server" Text="Work Order:" class="labelText" /></td>
                        <td><asp:DropDownList ID="cboWorkOrder" runat="server" AutoPostBack="false" DataSourceID="sqlFinalizedWorkOrders" DataTextField="WORK_ORDER" DataValueField="WORK_ORDER" Width="200px"  EnableViewState="false" /></td>
                    </tr>

                    <tr style="height:60px;">
                        <td align="right"></td>
                        <td align="right" >
                            <table border=0 width="100%">
                                <tr style="display:none;">                                
                                    <td align="center" class="labelText"><asp:CheckBox ID="chkExport" runat="server" style="display:none;" /></td>
                                    <td align="right" class="labelText"><input id="Button3" type="button" value="<%= hdnExportExcelText.value %>" class="exportExcel" style="height:30px;"/></td>
                                    <td align="right"><input id="cmdViewRpt" type="button" value="<%= hdnviewreport.value %>" class="printRpt" style="height:30px;"/></td>
                                </tr>
                                <tr>
                                    <td align="right" style='display:none;'><a href="#" class="printRpt"><img src="../images/reverse.png" width="40px" title="Reverse a posting" /></a></td>
                                    <td align="right" width="75%"><a href="#" class="exportExcel" style="display:none;"><img src="../images/excel.png" width="40px" title="<%= hdnExportExcelText.value %>" /></a></td>
                                    <td align="right"><a href="#" class="printRpt"><img src="../images/viewreport.png" width="40px" title="<%= hdnviewreport.value %>" /></a></td>
                                </tr>
                            </table>
                        </td>
                    
                    </tr>
                </table>
            </div>
            
            <asp:HiddenField ID="hdnViewReport" runat="server" Value="" />
            <asp:HiddenField ID="hdnExportExcelText" runat="server" Value="" />   
            <asp:HiddenField ID="hdnOrgID" runat="server" Value="" />   
            <asp:HiddenField ID="hdnAccSeg" runat="server" Value="0" />
            <asp:HiddenField ID="hdnITR" runat="server" Value="0" />
            <asp:HiddenField ID="hdnITC" runat="server" Value="0" />
            <asp:HiddenField ID="hdnRITCON" runat="server" Value="0" />
            <asp:HiddenField ID="hdnRITCBC" runat="server" Value="0" />
            <asp:HiddenField ID="hdnRITCPEI" runat="server" Value="0" />
            <asp:HiddenField ID="hdnAccountPayable" runat="server" Value="0" />

            <asp:SqlDataSource ID="sqlFinalizedReports" runat="server" 
                ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                SelectCommand="GetFinalizedReportsByEmployee" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cboEmp" Name="EmpID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlEmployees" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetEmployees" SelectCommandType="StoredProcedure"
                    FilterExpression="ACTIVE = 1" >

                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />            
                    </SelectParameters>

                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlJurisdictions" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetJurisdictions" SelectCommandType="StoredProcedure">
        
                    <SelectParameters>
                            <asp:SessionParameter SessionField="language" Name="language" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlOrgCategories" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetOrgCategories"
                    SelectCommandType="StoredProcedure"
                    FilterExpression="ACTIVE = 1" >
        
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                            <asp:SessionParameter SessionField="language" Name="language" Type="String" />                         
                        </SelectParameters>
                         
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlGetExpenseAccounts" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                        SelectCommand="GetAccounts" SelectCommandType="StoredProcedure">

                    <SelectParameters>
                        <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />            
                        <asp:Parameter DefaultValue="Expense" Name="Type" />
                    </SelectParameters>
                </asp:SqlDataSource>

                

                <asp:SqlDataSource ID="sqlDivisions" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="GetDivisions"
                    SelectCommandType="StoredProcedure">
        
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        </SelectParameters>        
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlFinalizedProjects" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="SELECT * FROM vFinalizedProjects"
                    SelectCommandType="Text"
                    FilterExpression="ORG_ID={0}">
        
                    <FilterParameters>
                            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        </FilterParameters>
                </asp:SqlDataSource>

                <asp:SqlDataSource ID="sqlFinalizedWorkOrders" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="SELECT * FROM vFinalizedWorkOrders"
                    SelectCommandType="Text"
                    FilterExpression="ORG_ID={0}">
        
                    <FilterParameters>
                            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        </FilterParameters>
                </asp:SqlDataSource>
        
    
                <asp:SqlDataSource ID="sqlFinalizedCostCenters" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:dbadvaloremConnStr %>" 
                    SelectCommand="SELECT * FROM vFinalizedCostCenters"
                    SelectCommandType="Text"
                    FilterExpression="ORG_ID={0}">
        
                    <FilterParameters>
                            <asp:ControlParameter ControlID="hdnOrgID" Name="OrgID" PropertyName="Value" Type="Int32" />
                        </FilterParameters>
                </asp:SqlDataSource>


    <script type="text/javascript">

        $(document).ready(function () {

            $("#Row-SummaryByProject").hide();
            $("#Row-CustomReport").show();
            $("#Row-ReportByPeriod").hide();            
            $("#Row-SummaryByWorkOrder").hide();
            $("#Row-SummaryByCostCenter").hide();
            $("#Row-SummaryByCategory").hide();
            $("#Row-Jurisdiction").hide();
            $("#Row-SummaryByGL").hide();
            $("#Row-SummaryByDivision").hide();
            $("#Row-ReportByEmp").hide();
            $("#Row-ReportByEmp2").hide();
            
            

            ////////////////////////////////////////////////////////////////////////////////////////////////////////
            $("#<%=cboGL.ClientID %>").change(function () {
                var s = $("#<%=hdnAccSeg.ClientID %>").val();
                $("#Row-SummaryByGL").show();
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////
          
            $(".printRpt").mousedown(function () {
                
                    var win; var division; var GL; var proj; var cc; var wo; var jur; var emp;
               
                    GL = ''; proj = ''; division = ''; cc = ''; wo = ''; jur = ''; emp = '';

                    if ($("#<%=cboReportType.ClientID %>").val() == "5" || $("#<%=cboReportType.ClientID %>").val() == "22") division = "&div=" + $("#<%=cboDivision.ClientID %>").val();
                    if ($("#<%=cboReportType.ClientID %>").val() == "8") GL = "&GL=" + $("#<%=cboGL.ClientID %>").val();
                    if ($("#<%=cboReportType.ClientID %>").val() == "10" || $("#<%=cboReportType.ClientID %>").val() == "22") { if ($("#<%=cboProject.ClientID %>").val() == null) proj = "&proj=0"; else proj = "&proj=" + $("#<%=cboProject.ClientID %>").val(); }
                    if ($("#<%=cboReportType.ClientID %>").val() == "11") if ($("#<%=cboWorkOrder.ClientID %>").val() == null) wo = "&wo=0"; else wo = "&wo=" + $("#<%=cboWorkOrder.ClientID %>").val();
                    if ($("#<%=cboReportType.ClientID %>").val() == "12" || $("#<%=cboReportType.ClientID %>").val() == "22") { if ($("#<%=cboCostCenter.ClientID %>").val() == null) cc = "&cc=0"; else cc = "&cc=" + $("#<%=cboCostCenter.ClientID %>").val(); }
                    if ($("#<%=cboReportType.ClientID %>").val() == "20") jur = "&jur=" + $("#<%=cboJur.ClientID %>").val();
                    if ($("#<%=cboReportType.ClientID %>").val() == "3") emp = "&emp=" + $("#<%=cboEmp.ClientID %>").val();

                if ($("#<%=cboReportRange.ClientID %>").val() == 'Period')
               
                    win = window.open("ExpenseReport.aspx?type=" + $("#<%=cboReportType.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&orgCatID=" + $("#<%=cboOrgCategory.ClientID %>").val() + "&yr=" + $("#<%=cboFinancialYear.ClientID %>").val() + "&p=" + $("#<%=cboPeriod.ClientID %>").val() + division + GL + proj + cc + wo + jur + emp + "&rptName=" + $("#<%=cboReportType.ClientID %>").children("option").filter(":selected").text(), "Report", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                
                else if ($("#<%=cboReportRange.ClientID %>").val() == 'Employee') {

                    win = window.open("ExpenseReport.aspx?type=2&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&orgCatID=" + $("#<%=cboOrgCategory.ClientID %>").val() + "&empID=" + $("#<%=cboEmp.ClientID %>").val() + "&rpt=" + $("#<%=cboEmpReports.ClientID %>").val() + "&rptName=" + $("#<%=cboReportType.ClientID %>").children("option").filter(":selected").text(), "Report", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");

                }
                else {
                 
                    win = window.open("ExpenseReport.aspx?type=" + $("#<%=cboReportType.ClientID %>").val() + "&org=" + $("#<%=hdnOrgID.ClientID %>").val() + "&orgCatID=" + $("#<%=cboOrgCategory.ClientID %>").val() + "&start=" + $("#<%=txtFrom.ClientID %>").val() + "&end=" + $("#<%=txtTo.ClientID %>").val() + division + GL + proj + cc + wo + jur + emp + "&rptName=" + $("#<%=cboReportType.ClientID %>").children("option").filter(":selected").text(), "Report", "width=1000,height=600,toolbar=yes,scrollbars=yes,resizable=yes");
                }
                
                    win.focus();   
                
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=cboReportType.ClientID %>").change(function () {

                var s = $("#<%=hdnAccSeg.ClientID %>").val();

                $("#Row-SummaryByCategory").hide();
                $("#Row-Jurisdiction").hide();
                $("#Row-SummaryByGL").hide();
                $("#Row-SummaryByWorkOrder").hide();
                $("#Row-ReportByEmp").hide();

                if (s.indexOf('D') == -1) $("#Row-SummaryByDivision").hide(); else if ($("#<%=cboReportType.ClientID %>").val() == 22) $("#Row-SummaryByDivision").show(); else $("#Row-SummaryByDivision").hide();
                if (s.indexOf('P') == -1) $("#Row-SummaryByProject").hide(); else if ($("#<%=cboReportType.ClientID %>").val() == 22) $("#Row-SummaryByProject").show(); else $("#Row-SummaryByProject").hide();
                if (s.indexOf('C') == -1) $("#Row-SummaryByCostCenter").hide(); else if ($("#<%=cboReportType.ClientID %>").val() == 22) $("#Row-SummaryByCostCenter").show(); else $("#Row-SummaryByCostCenter").hide();

                //if($("#<%=cboReportType.ClientID %>").val()==10) $("#Row-SummaryByProject").show(); else $("#Row-SummaryByProject").hide();
                if ($("#<%=cboReportType.ClientID %>").val() == 11) $("#Row-SummaryByWorkOrder").show(); else $("#Row-SummaryByWorkOrder").hide();
                //if($("#<%=cboReportType.ClientID %>").val()==12) $("#Row-SummaryByCostCenter").show(); else $("#Row-SummaryByCostCenter").hide();
                if ($("#<%=cboReportType.ClientID %>").val() == 4) $("#Row-SummaryByCategory").show(); else $("#Row-SummaryByCategory").hide();
                if ($("#<%=cboReportType.ClientID %>").val() == 20) $("#Row-Jurisdiction").show(); else $("#Row-Jurisdiction").hide();
                if ($("#<%=cboReportType.ClientID %>").val() == 3) $("#Row-ReportByEmp").show(); else $("#Row-ReportByEmp").hide();
                                
                if ($("#<%=cboReportType.ClientID %>").val() == 8) {
                    $("#Row-SummaryByGL").show();
                } else
                    $("#Row-SummaryByGL").hide();
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=cboReportRange.ClientID %>").change(function () {
                debugger
                $("#Row-ReportByPeriod").hide();
                $("#Row-CustomReport").hide();
                $("#Row-ReportByEmp").hide();
                $("#Row-ReportByEmp2").hide();
                $("#Row-SummaryByDivision").hide();
                $("#Row-SummaryByCategory").hide();
                $("#Row-SummaryByGL").hide();
                $("#<%=cboReportType.ClientID %>").val(0);


                if ($('option:selected', '#<%=cboReportRange.ClientID %>').val() == "Period") {
                    $("#Row-ReportByPeriod").show();
                    $("#Row-ReportType").show();
                }
                else if ($('option:selected', '#<%=cboReportRange.ClientID %>').val() == "Employee") {
                    $("#Row-ReportByEmp").show();
                    $("#Row-ReportByEmp2").show();
                    $("#Row-ReportType").hide();
                }
                else {
                    $("#Row-CustomReport").show();
                    $("#Row-ReportType").show();
                }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

           $("#<%=txtFrom.ClientID %>").datepicker({
                dateFormat: "dd/mm/yy",
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                minDate: "01/07/2010",
                maxDate: new Date(),
                numberOfMonths: 1,
                onSelect: function (selectedDate) {
                    $("#<%= txtTo.ClientID %>").datepicker("option", "minDate", selectedDate);

                    if ($("#<%=txtTo.ClientID %>").val() == '') { $("#<%=txtTo.ClientID %>").val($("#<%=txtFrom.ClientID %>").val()); }
                }
            });
            ////////////////////////////////////////////////////////////////////////////////////////////////////////

            $("#<%=txtTo.ClientID %>").datepicker({
                dateFormat: "dd/mm/yy",
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                minDate: "01/07/2010",
                maxDate: new Date(),
                numberOfMonths: 1,
                onSelect: function (selectedDate) {
                    $("#<%= txtFrom.ClientID %>").datepicker("option", "maxDate", selectedDate);
                }
            });
        });

    </script>


</asp:Content>
