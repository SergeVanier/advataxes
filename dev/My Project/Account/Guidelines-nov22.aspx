<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Guidelines.aspx.vb" Inherits="WebApplication1.Guidelines" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link type="text/css" href="../../css/sunny/jquery-ui-1.8.23.custom.css" rel="stylesheet" /> 
    <script type="text/javascript" src="../../js/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui-1.8.18.custom.min.js"> </script>
    <script type="text/javascript" src="../../js/jquery.js"> </script>


  
    <script>

        $(document).ready(function () {
            $(function () {
                $("#tabs").tabs();
            });



            if ($("#<%=hdnAdmin.ClientID %>").val() == "False") $("#adminListItem").css("display", "none")
            if ($("#<%=hdnApprover.ClientID %>").val() == "False") $("#approverListItem").css("display", "none")
        });
    
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <br />
      <div id="tabs" style="height:950px;">
			<ul>
				<li id="empListItem"><a href="#tab-employee">Employee</a></li>
                <li id="approverListItem"><a href="#tab-approver">Approver</a></li>
                <li id="adminListItem"><a href="#tab-admin">Admin</a></li>
			</ul>

			<div id="tab-employee">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:860px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Employee Guidelines</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
											
                        <tr><td style="color:#cd1e1e; font-weight:bold;">1. Managing an Expense Report</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Creating a report</td></tr>
                                    <tr><td>To start registering your expenses, go to the tab “My Expenses”, click on <img src="../images/new.png" width="20px" height="20px" /> next to “Reports”, and give a name to your report. We suggest you pick a name that is descriptive of the expenses you will register.  For instance, it could be “Ottawa trade show” when you have incurred expenses in relation to a trade show that was held in Ottawa. You will then be ready to add your expenses incurred at the Ottawa trade show by clicking <img src="../images/new.png" width="20px" height="20px" /> next to “Expenses”.
                                            A user can only create one report at a time. You have to submit your report for approval in order to be able to create a new one.   The only situation where a user is going to have more than one report in “My Expenses”  is when  older report(s)  are sent back to the user  for review.  
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">Editing report name</td></tr>
                                    <tr><td>You can edit the name of a report by clicking on <img src="../images/edit.png" width="20px" height="20px" />.  Once a report has been submitted, no more name changes are allowed.  </td></tr>
                                    <tr><td style="color:#cd1e1e;">Delete a report</td></tr>
                                    <tr><td>You can delete a report previously created by clicking on <img src="../images/del.png" width="20px" height="20px" />. You can’t delete a report that is under “pending approval”, “approved” or “finalized” mode.  </td></tr>
                                    
                                </table>
                            </div>
                        
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">2. Managing an expense</td></tr>
                                    
                                    <tr><td>
                                        <div style="position:relative;left:20px;">
                                            <table>
                                            
                                                <tr><td style="color:#cd1e1e;">Adding and expense</td></tr>
                                                <tr><td>Once your report is created, you can add expenses to it by clicking on <img src="../images/new.png" width="20px" height="20px" /> at the right of “Expenses” bearing the name of your report.</td></tr>
                                                        
                                                <tr><td>
                                                    <div style="position:relative;left:20px;">
                                                        <table>
                                                            <tr><td style="color:#cd1e1e;">Expense type</td></tr>
                                                            <tr><td>Select the type of expense you have incurred, e.g. Meals and Entertainment,  km allowance, telecom, by clicking on the “expense type” box.   </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Expense date</td></tr>
                                                            <tr><td>Select the date when the expense was incurred.  For instance, a lodging bill for a stay on July 19, 2012, should bear the date of the stay, i.e. July 19 2012. Generally, the transaction date will be the invoice date.  If the expense you are entering is one without invoice, for instance a kilometer allowance, then select the date that the allowance refers to. A kilometer allowance relating to driving to Ottawa on July 19, 2012, should bear the date of July 19 2012. The software does not allow expenses incurred prior to July 1, 2010. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Jurisdiction</td></tr>
                                                            <tr><td>Select the jurisdiction, i.e. a province or a territory, where you have incurred your expense, such as Ontario, British-Columbia or Quebec. If your expense has been incurred outside the provinces and the territories of Canada, select “Outside Canada”.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Amount</td></tr>
                                                            <tr><td>Insert the amount as it appears on your invoice or as per your allowance. The cents have to be separated from the dollars by a period.  For invoice amounts, you can either include an amount before tax or an amount tax included and select one of the  functionalities described hereafter.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Tax included</td></tr>
                                                            <tr><td>This is the default selection that will calculate, as the case may be, GST/HS/QST from an amount that includes taxes. However, you should note that the amount to insert should exclude optional tips. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Tax extra</td></tr>        
                                                            <tr><td>Choose this setting when the value inserted in the amount field is one before GST/HST/QST.  This setting can be used for hotel bills with a room charge and a meal charge. User should create an expense for the room charge by selecting “lodging” as an expense type, and create a second expense by selecting an appropriate “Meal and Entertainment” expense type. The tax treatment will match the logic of their respective category. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Tips</td></tr>
                                                            <tr><td>Enter in this box only optional gratuities. These are not subject to GST/HST or QST. You should not include tips that are compulsory as they are governed by a different tax rule; they are part of the consideration. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Currency</td></tr>
                                                            <tr><td>The software provides foreign currency conversion into Canadian dollars. A list of more than 150 foreign currencies is available. Generally, the currency conversion process uses conversion value of the chosen transaction date. By default, the currency field is set to “CAD”, i.e. “Canadian dollar”. </td></tr>
															<tr><td style="color:#cd1e1e;">Do not reimburse</td></tr>
															<tr><td>Check this option if the expense you're entering will be paid by the company on your behalf. This functionality covers cases where the employer reimburses expenses on behalf of the employee. It covers notably situations where an employee has a credit card and where the payment is made by the employer. The card member (i.e. employee) is solely liable for the payment of all charges. The card member could also be  jointly and severally liable with the organization for the payment of all charges made on the organization credit card issued to the card member.</tr></td>
                                                            <tr><td style="color:#cd1e1e;">Supplier’s name</td></tr>
                                                            <tr><td>When applicable, employees have the option to enter the supplier’s name.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Comment</td></tr>
                                                            <tr><td>Employees have the option to enter some comments relating to each expense (i.e. Lunch with ABC Drilling).</td></tr>
                                                            <tr><td style="color:#cd1e1e;">GST/HST/QST paid</td></tr>
                                                            <tr><td>Compare the calculated GST/HST/QST paid with the GST/HST/QST indicated on your invoice, should your expense be supported by an invoice. Discrepancies can be due to an error in the transactional date or expense type selection; rectify the selection and compare again. Irregular situations, such as purchases from a small supplier, or the HST point-of-sale rebate on meals of less than $4.00 in Ontario, should be rectified. Click on <img src="../images/lock.png" width="15px" height="20px" /> and rectify the GST/HST/QST paid on your invoice. Similarly, should the invoice supporting the transaction is missing with no way to recover it, edit the GST/HST/QST field and set these values to zero as lack of documentary requirement. You should know that taxi fares, coin operated phone and coin operated parking are relieved from the documentation requirement for GST/HST/QST purposes.</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Receipt</td></tr>
                                                            <tr><td>You can upload your invoice beside each registered expense. We support format that are in PDF, JPEG, PNG, TIFF, GIF, BMP and HTML. To do so, click on "Browse".</td></tr>
                                                            <tr><td style="color:#cd1e1e;">Air travel</td></tr>
                                                            <tr><td>This category also includes passenger train that are provided otherwise than an urban commuting service. It also includes long distance buses. For this category, the process differs from other categories. Users have to select the applicable tax rate on their invoice from a drop down list. </td></tr>
                                                            <tr><td style="color:#cd1e1e;">Employee’s personal use</td></tr>
                                                            <tr><td>If you select this expense type which relates to expenses that are incurred for the personal use (as oppose to expenses that are used for the purpose of your organization), no GST/HST/QST is calculated, despite the fact that these expenses may bear GST/HST/QST. No necessary GST/HST/QST correction is required at the employee level screen. </td></tr>
                                                        </table>                                                    
                                                    </div>
                                                </td></tr>

                                                <tr><td style="color:#cd1e1e;">Editing an expense</td></tr> 
                                                <tr><td>You can edit an expense by clicking on the <img src="../images/edit.png" width="20px" height="20px" />. You will thus be able to change information such as the expense date, the expense amount, the tips amount, the jurisdiction, and so on. The only information you will not be able to modify is the expense type. </td></tr>
                                                <tr><td style="color:#cd1e1e;">Expanding the expense for comments</td></tr>
                                                <tr><td>You can expand the expenses you have added by clicking on <img src="../images/plus.png" width="15px" height="15px" /> at the left of each expense. This will display the comments you have entered when adding an expense.</td></tr>
                                                <tr><td style="color:#cd1e1e;">Deleting an expense</td></tr>
                                                <tr><td>You can delete an expense by clicking on <img src="../images/del.png" width="20px" height="20px" />   at the right of each expense.</td></tr>

                                            </table>                                        
                                        </div>
                                    
                                    </td></tr>
                                    
                            
                        <tr><td style="color:#cd1e1e; font-weight:bold;">3. Submit a report</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td  style="color:#cd1e1e;" >Submit an expense report</td></tr>
                                    <tr><td>You can submit your report for approval by clicking on <img src="../images/submit.png" width="20px" height="20px" />. Once you have submitted an expense report, you will be able to access it by selecting, in the “Status” box, the “pending approval” option, but you will not be able to edit it. The only way the employee is able to edit a submitted report is when the approver disapproves it. It is then returned to the employee for review.</td></tr>
                                </table>
								<tr><td>
								<tr><td>Should you have any questions, <a href="contactus.aspx" style="color:#cd1e1e">contact us</a> and one of our representatives will get back to you.</td></tr>
                            
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>
            
            <div id="tab-approver">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:880px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Approver Guidelines</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
                        <tr valign="middle" style="height:60px;"><td>As an approver, your task is to review expense reports that have been submitted to you by a selected list of employees.  These employees have been assigned to you by the administrator of this software within your organization.</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Submitted reports</td></tr>
                        
                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">Review</td></tr>
                                    <tr><td>To review an expense report, go to the tab “submitted reports” and click on <img src="../images/viewreport.png" width="20px" height="20px" /> under the "Reports" header. You will see, for each expense report, a listing of all expense types, total expenses as well as total ITC, ITR and RITC, as the case may be.</td></tr>
                                    <tr><td>To view receipts that have been attached to each expense, click on <img src="../images/attachment2.png" width="20px" height="20px" />.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Modify</td></tr>
                                    <tr><td>There are 2 methods for bringing changes to an expense report that has been submitted by an employee.
                                            The first one is to send the expense report back to the employee by clicking on <img src="../images/reject.png" width="15px" height="15px" />. The status of the expense report will be set to "Open" and will re-appear in the employee's "My Expenses” tab. 
                                            The second one is to click on <img src="../images/edit.png" width="20px" height="20px" /> and apply the correction yourself. 
                                    </td></tr>
                                    <tr><td style="color:#cd1e1e;">View</td></tr>
                                    <tr><td>To view submitted reports, simply use the filter functionalities “Employee” and “Status”. Viewing selections available are:<br />
                                                Employee: View expense reports for all employees or for a specific employee.<br />
                                                Status: View expense reports based on their status, pending approval, approved or finalized.
                                    </td></tr>

                                    <tr><td style="color:#cd1e1e;">Approve</td></tr>
                                    <tr><td>Once the review of a submitted expense report is completed, you can proceed with the approval process. Clicking on <img src="../images/finalize.png" width="15px" height="15px" /> will approve the report.                                         
                                    </td></tr>

                                    <tr><td style="color:#cd1e1e;">Posted Reports</td></tr>
                                    <tr><td>Only finalized reports will be posted for accounting purposes. Finalized reports will be posted in the period in which the day the report has been finalized. Reports that have been finalized can no longer be modified or deleted.    </td></tr>

                                    <tr valign="bottom" style="height:50px;"><td>Should you have any questions, <a href="contactus.aspx" style="color:#cd1e1e">contact us </a> and one of our representatives will get back to you.</td></tr>
                                    
                                </table>
                            </div>
                        </td></tr>
                    </table>
                </div>
            </div>

            <div id="tab-admin">
                <div style="position:relative;top:20px;left:20px; overflow:auto; height:870px; width:98%;">
                    <table width="96%">
                        <tr style="height:40px;"><td valign="top" style="color:#cd1e1e; font-size:1.5em;">Administrator Guidelines</td></tr>
                        <tr style="height:0.1px; background-color:#cd1e1e;"><td></td></tr>
                        <tr><td style="height:10px;"></td></tr>
                        <tr valign="middle" style="height:60px;"><td>These guidelines are set to address the set up functionalities as well as the management functionalities of Advataxes that you can access through the Admin tab.</td></tr>
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Initial considerations</td></tr>
                        <tr><td>In your pre login screen you had to select as to whether your organisation is:
                                    <br />•	A financial institution for GST and QST purposes,
                                    <br />•	Other type of organisation other than a non-profit organization
                        </td></tr>
                        
                        <tr><td>The software currently does not support organisation with a non-profit status as such, and if it is the case, then you should not proceed any further. Also the current software should not be used if your organization has some kind of elections regarding the GST/QST quick method where registrants remit a lower amount of tax collected rather than tracking taxes on their purchases to offset tax collected.  
                        </td></tr>
                        
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Global Settings</td></tr>
                        
                        <tr><td>Go to the “Global settings” tab in the “Admin” section to fill out the following fields. To edit, click on <img src="../images/edit.png" width="20px" height="20px"/>.</td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>
                                    <tr><td style="color:#cd1e1e;">First month of financial year</td></tr>
                                    <tr><td>Select the first month of the financial year of your organization. If your month-end do not match the calendar month, please contact us (upper right) so we can initiate a manual setting.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Number of periods  per financial year</td></tr>
                                    <tr><td>Select the number of periods per financial year. &quot;12&quot; stands for 12 periods per financial year, and so forth. </td></tr>
                                    <tr><td style="color:#cd1e1e;">Accounts payable number</td></tr>
                                    <tr><td>Insert the  general ledger accounts payable number for  employees' expenses reimbursement.</td></tr>
                                    <tr><td style="color:#cd1e1e;">ITC account number</td></tr>
                                    <tr><td>For GST registrants - Insert the general ledger account number where input tax credits (ITC) are posted under the GST regime. <b>Some references:</b> For further information, see <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/8-1/8-1-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Memoranda 8.1 General Eligibility Rules</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;>ITR account number</td></tr>
                                    <tr><td>For QST registrants - Insert the general ledger account number where input tax refunds (ITR) are posted under the QST regime.</td></tr>
                                    <tr><td style="color:#cd1e1e;">RITC-ON account number</td></tr>        
                                    <tr><td>For large businesses under the GST regime - Insert the general ledger account number where the recapture of input tax credits (RITCs) in Ontario are posted. If RITCs are posted within the ITC account number, then insert the ITC account number again. <b>Some references:</b> For further information, see <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/b-104/b-104-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Technical Information Bulletin B-104 Harmonized Sales Tax Temporary Recapture of Input Tax Credits in Ontario and in BC.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">RITC-BC account number</td></tr>
                                    <tr><td>For large businesses under the GST regime - Insert the general ledger account number where the recapture of input tax credits (RITCs) in British Columbia are posted. If RITCs are posted within the ITC account number, then insert the ITC account number again. <b>Some references:</b> For further information, see <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/b-104/b-104-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Technical Information Bulletin B-104 Harmonized Sales Tax Temporary Recapture of Input Tax Credits in Ontario and in BC.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">RITC-PEI account number</td></tr>
                                    <tr><td>For large businesses under the GST regime - Insert the general ledger account number where the recapture of input tax credits (RITCs) in British Columbia are posted. If RITCs are posted within the ITC account number, then insert the ITC account number again. <b>Some references:</b> For further information, see <a href="#" onclick="javascript:window.open('http://www.gov.pe.ca/photos/original/hst_recap_itc.pdf');" style="color:#cd1e1e;"><u>Guide RTG: 186 Temporary Recapture of certain Provincial Input Tax Credits.</u></a></td></tr>
									<tr><td style="color:#cd1e1e;">Retention period</td></tr>
                                    <tr><td>Choose the number of years (between 1 and 6) you wish your financial data will be kept by Ad Valorem Inc., subject to  Advataxes valid subcription. <b>Some references:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/tg/rc4409/rc4409-11e.pdf');" style="color:#cd1e1e;"><u>RC4409 Keeping records</u></a>.</td></tr>
									<tr><td style="color:#cd1e1e;">Foreign currency offset</td></tr>
                                    <tr><td>Choose the percentage (between 0% and 5%) you would like the foreign currency conversion to be increased above the interbank official rate. As an example, typical credit card is + 2%. The software converts foreign currencies into Canadian currencies generally on the transaction date.</td></tr>
                                
                                </table>                                                    
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Organizations</td></tr>
                        
                        <tr><td>Go to the “Organization” tab, click on <img src="../images/edit.png" width="20px" height="20px" /> to edit your organization profile. </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Name</td></tr>
                                    <tr><td>Insert the name of the organization from which the users that will be submitting expense reports are employees of.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Type</td></tr>
                                    <tr><td>Select &quot;<b>non-profit organization</b>&quot; if your organization is covered by the definition of &quot; non-profit organization&quot; under section 123 of the <i>Excise Tax Act</i> and, as the case may be, under section 1 of the <i>Quebec Sales Tax Act</i>. Select &quot;<b>financial institution</b>&quot; if your organization is a &quot;financial institution&quot; as defined under section 123 of the <i>Excise Tax Act</i> and, as the case may be, section 1 of the <i>Quebec Sales Tax Act</i>. Select &quot;<b>other organization</b>&quot; if your organization does not fall in the previous two categories.</td></tr>
									<tr><td style="color:#cd1e1e;">Organization code</td></tr>
                                    <tr><td>Insert the code of the organization, if any, for accounting purposes.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Jurisdiction</td></tr>        
                                    <tr><td>Insert the jurisdiction in which the organization's employees submitting expense reports are more likely to incur expenses. This jurisdiction will be set as the  default jurisidiction for the &quot;My expenses&quot; tab.</td></tr>
                                    <tr><td style="color:#cd1e1e;">GST Registrant</td></tr>
                                    <tr><td>Select &quot;yes&quot; if the organization is a GST registrant as defined under section 123 of the <i>Excise Tax Act</i>. Generally, a GST registrant is a person who is registered or who is required to be registered. Should at any time the registration status of your organization change, inform us so we will change the registration status.</td></tr>
                                    <tr><td style="color:#cd1e1e;">QST Registrant</td></tr>
                                    <tr><td>Select &quot;yes&quot; if the organization is a QST registrant as defined under section 1 of the <i>Quebec Sales Tax act</i>. Generally, a QST registrant is a person who is registered or who is required to be registered. Should at any time the registration status of your organization change, inform us and we will change the registration status.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Large business for GST/HST purposes</td></tr>
                                    <tr><td>Select whether the organization is  a large business for GST purposes or a small and medium business for GST purposes (i.e. not a  large business). Generally, a large business for GST purposes is a business for a particular fiscal period where the value of the total taxable sales and those of its associate persons exceeds $10 million.  Should at any time this status change, inform us and we will modify this setting. <b>Some references:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/b-104/b-104-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Technical Information Bulletin B-104 Harmonized Sales Tax Temporary Recapture of Input Tax Credits in Ontario and in BC.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">Large Business for QST Purposes</td></tr>
                                    <tr><td>Select whether the organization is  a large business for QST purposes or a small and medium business for QST purposes (i.e. not a  large business). Generally, a person is a large business for QST purposes throughout a particular fiscal period if the threshold amount determined for the fiscal period, including associate persons, exceeds $10 million. Should at any time this status change, inform us and we will modify this setting. <b>Some references:</b> <a href="#" onclick="javascript:window.open('http://www2.publicationsduquebec.gouv.qc.ca/dynamicSearch/telecharge.php?type=16&file=T0_1A206_1T9BULB.pdf');" style="color:#cd1e1e;"><u>Interpretation Revenu Quebec TVQ 206-1-9 Qualification as a small or medium sized business or as a large business</u></a>.</td></tr>
                                    <tr><td style="color:#cd1e1e;">GST ratio of commercial activities</td></tr>
                                    <tr><td>Select the ratio of commercial activities that is applicable to the organization's employees expenses for GST purposes. The selected rate can range from 100% to 0%. Should you need to change this ratio, please contact us and we will modify this setting according to your request. <b> Some references:</b> <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/8-3/README.html');" style="color:#cd1e1e;"><u>GST/HST Memorandum 8-3 Calculating Input Tax Credit</u></a> <i><b>For financial institutions only</i></b>: <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/b-106/b-106-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Technical Information Bulletin B-106 entitled &quot;Input Tax Credit Allocation Methods for Financial Institutions for Purposes of Section 141.02&quot;.</u></a></td></tr>
                                    <tr><td style="color:#cd1e1e;">QST ratio of commercial activities</td></tr>
                                    <tr><td>Select the ratio of commercial activities that is applicable to the organization's employees expenses for QST purposes. The selected rate can range from 100% to 0%. Should you need to change this ratio, please contact us and we will modify this setting according to your request.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Adding organizations</td></tr> 
									<tr><td>Should you have more than one organization with the same global settings, such as the same financial year end, you just have to click on “plus” and set your configuration.</td></tr>
                                
                                </table>                                                    
                            </div>
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Categories</td></tr>
                        
                        <tr><td>The selection is a list of preconfigured expense types where you can select, by clicking on <img src="../images/download.png" width="20px" height="20px" />, the categories that are relevant for your organization. You can select the same category several times if you need to cover  different GL accounts. 
                                Only the categories that you have selected will be made available to your employees to choose from.
                                Once selected, these category types will be included in your list of “selected categories”.
                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Selecting <img src="../images/download.png" width="20px" height="20px" /></td></tr>
                                    <tr><td>Select from the list “available categories” the type of expenses submitted by your employees. If for example your choice is “KM Allowance”, click on <img src="../images/download.png" width="20px" height="20px" /> to select it. You can insert the GL account number of your organization in the field for better accounting integration. 
                                             Essentially, the categories serve 2 purposes: The first purpose is to address specific tax rules. For instance, KM allowance, M&E for long haul truck driver and expenses for personal use are governed by specific provisions (see <img src="../images/question.png" width="15px" height="15px" /> beside each one for further details).  For large businesses, categories like &quot;gas for car&quot; and &quot;cell (monthly charges)&quot; fall also in this specific tax rule logic. The second purpose is to address common employees expense types such as &quot;lodging&quot;, &quot;parking&quot; and &quot;office supply&quot;. So if the policy of your organization is to reimburse solely KM allowances to your  employees and not allowing any other kind of car expenses, make sure to select &quot;KM allowances&quot; from the list, and not to select &quot;Car rental (long term)&quot;, &quot;Gas for car&quot;, &quot;Car and truck repairs&quot;.  
                                            To understand the software logic of each category, click on <img src="../images/question.png" width="15px" height="15px" />, which contains relevant logic information and GST-HST-QST information. The select category will follow the logic described in the <img src="../images/question.png" width="15px" height="15px" />. 
											If you need to match a given tax logic of a category with several accounts, you will have to select the same category several times and proceed to its integration with the organization accounting nomenclature. 										                                 
                                             As an example, assuming you have several employees buying samples and it is important for accounting purposes to keep track of the various sample types purchased, you can select “Expenses with tax(es)” several times and customize these accounts by adding names and GL account numbers:<br />
                                            <br />• Expenses with tax(es) Samples – T shirts 	600240<br />
                                            • Expenses with tax(es) Samples – Jeans		600250<br />
                                            • Expenses with tax(es) Samples – hat		600260<br /><br />
											Or as an example, your organizations’ accounting process  may post &quot;Meals and entertainment&quot; into several different GL accounts (i.e. &quot;production&quot;, &quot;Training&quot;, &quot;Special projects&quot;). The set up would then be:<br />
											<br />• M&E - Production 50025<br />
											• M&E - Training 50040<br />
											• M&E - Special Projects 50090<br /><br />
  
                                            To remove the selected category from the list that will be made available to your employees, simply deactivate the category by clicking on <img src="../images/checked.png" width="20px" height="20px" />.
											
                                    </td></tr>
                               </table>                                                    
                            </div>
                        
                        </td></tr>

	
                        <tr><td style="color:#cd1e1e; font-weight:bold;">Employees</td></tr>
                        
                        <tr><td>For GST and QST purposes, it is essential that ITC and ITR and rebate on employees expenses are claimed within the same organization that they are employees of. So the first criterion in selecting these employees is to ascertain that they are in fact employees of that organization. The term &quot;employee&quot;, which includes an officer, refers to the definition of employee under section 123 of the <i>Excise Tax Act</i> and section 1 of the <i>Quebec Sales Tax Act</i>. It may include partners and volunteers under the conditions of sections 174  and 175 of the <i>Excise Tax Act</i> and sections 211 and 212 of the <i>Quebec Sales Tax Act</i>. <b>Some references:</b> See <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/9-4/9-4-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Memorandum 9.4 Reimbursements</u></a>, and <a href="#" onclick="javascript:window.open('http://www.cra-arc.gc.ca/E/pub/gm/9-3/9-3-e.pdf');" style="color:#cd1e1e;"><u>GST/HST Memorandum 9.3 Allowances</u></a>. 
                                Click on <img src="../images/new.png" width="20px" height="20px" /> to add an employee.

                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Last name</td></tr>
                                    <tr><td>Employee's last name</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">First name</td></tr>
                                    <tr><td>Employee's first name</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Employee #</td></tr>        
                                    <tr><td>Employee&#39;s number (optional)</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Division code</td></tr>
                                    <tr><td>Employee&#39;s division code</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Approver</td></tr>
                                    <tr><td>The person who will be approving expense reports for this employee. </td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Email</td></tr>
                                    <tr><td>Employee's email.  For delegating the task of filling out employee expenses, the e-mail address can be substituted with the person the task is delegated to. </td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Username</td></tr>
                                    <tr><td>Username the employee will use to log in Advataxes.</td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Administrator status</td></tr>
                                    <tr><td>Only administrators can view the information provided in the “Admin” tab. An administrator is allowed to proceed with a certain number of modifications in their profile. 
									<tr><td style="color:#cd1e1e;">Approver status</td></tr>
									<tr><td>An approver will be in charge of reviewing employee expense reports. Once an employee is created, an e-mail is sent to him and he can proceed with the set-up of his account.</td></tr>
                                            For employees that no longer work for the organization, click on <img src="../images/checked.png" width="20px" height="20px" /> under Active to deactivate his account. He will no longer have access to Advataxes. </td></tr>
                                    
                                    <tr><td style="color:#cd1e1e;">Notify by email</td></tr>
                                    <tr><td>
                                            If selected, the employee will be notified by email whenever an expense report has been finalized for all employees of his/her organization. Included in the email will be the amount that is owed to the employee. Usually, the person that is in charge of reimbursing employees will be the one to receive this notification.
                                    </td></tr>
                                    
                                
                                </table>                
                            </div>
                        
                        </td></tr>



                        <tr><td style="color:#cd1e1e; font-weight:bold;">Reports</td></tr>
                        
                        <tr><td>The reports sections provide a list of reports for GST-HST-QST, accounting and managerial purposes. 

                        </td></tr>

                        <tr><td>
                            <div style="position:relative;left:20px;">
                                <table>

                                    <tr><td style="color:#cd1e1e;">Report range</td></tr>
                                    <tr><td>This selection can provide reports per period, per employee or a customized date range.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Financial year</td></tr>
                                    <tr><td>This section allows you to select the financial year and accounting period. Select a closed financial period to obtain the posting summary and posting details. The software automatically close all periods.  Assuming an organization that has calendar months as financial periods, then on October 1st the accounting data such as ITC, ITR as well as expense amounts will be available.</td></tr>
                                    <tr><td style="color:#cd1e1e;">Report type</td></tr>        
                                    <tr><td>There are several report types available. You can provide an expense report summary which totals all amounts posted per category of expense as well as all GST, HST and QST to claim or to remit. These reports will list GST and QST to claim as well as recapture of ITC to remit.  The summary per category is useful for proceeding with tax adjustments on selected categories. For instance, the CRA allows to claim ITC on expenses for up to $500 per year on expenses that are incurred for  personal use, so since the software does not calculate any taxes on expenses for personal use, a year end adjustment through this functionality can be done. The same can be said of relocation allowances where GST is claimable on first $650 of the relocation allowance provided. Since the software does not recover any taxes on relocation allowances, a year end adjustment can be performed with this functionality. </td></tr>
                                </table>                
                            </div>
                        
                        </td></tr>

                        <tr><td style="color:#cd1e1e; font-weight:bold;">Dashboard</td></tr>
                        
                        <tr><td>When you go to the dashboard, you will see a list of employees and their last logged in date. When creating a new employee, the creation date will be set as the inital log in date.<br /><br /><br />
                        <tr><td>Should you have any questions, <a href="contactus.aspx" style="color:#cd1e1e">contact us</a> and one of our representatives will get back to you.</td></tr>

                    </table>
                </div>


            </div>
          <asp:HiddenField ID="hdnAdmin" runat="server" />
          <asp:HiddenField ID="hdnApprover" runat="server" />

    </div>
</asp:Content>
