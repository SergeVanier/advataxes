﻿'------------------------------------------------------------------------------
' <auto-generated>
'     This code was generated by a tool.
'     Runtime Version:4.0.30319.18444
'
'     Changes to this file may cause incorrect behavior and will be lost if
'     the code is regenerated.
' </auto-generated>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On

Imports System

Namespace My.Resources
    
    'This class was auto-generated by the StronglyTypedResourceBuilder
    'class via a tool like ResGen or Visual Studio.
    'To add or remove a member, edit your .ResX file then rerun ResGen
    'with the /str option, or rebuild your VS project.
    '''<summary>
    '''  A strongly-typed resource class, for looking up localized strings, etc.
    '''</summary>
    <Global.System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0"),  _
     Global.System.Diagnostics.DebuggerNonUserCodeAttribute(),  _
     Global.System.Runtime.CompilerServices.CompilerGeneratedAttribute()>  _
    Public Class TaxCalculator
        
        Private Shared resourceMan As Global.System.Resources.ResourceManager
        
        Private Shared resourceCulture As Global.System.Globalization.CultureInfo
        
        <Global.System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")>  _
        Friend Sub New()
            MyBase.New
        End Sub
        
        '''<summary>
        '''  Returns the cached ResourceManager instance used by this class.
        '''</summary>
        <Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Public Shared ReadOnly Property ResourceManager() As Global.System.Resources.ResourceManager
            Get
                If Object.ReferenceEquals(resourceMan, Nothing) Then
                    Dim temp As Global.System.Resources.ResourceManager = New Global.System.Resources.ResourceManager("AdvataxesResources.TaxCalculator", GetType(TaxCalculator).Assembly)
                    resourceMan = temp
                End If
                Return resourceMan
            End Get
        End Property
        
        '''<summary>
        '''  Overrides the current thread's CurrentUICulture property for all
        '''  resource lookups using this strongly typed resource class.
        '''</summary>
        <Global.System.ComponentModel.EditorBrowsableAttribute(Global.System.ComponentModel.EditorBrowsableState.Advanced)>  _
        Public Shared Property Culture() As Global.System.Globalization.CultureInfo
            Get
                Return resourceCulture
            End Get
            Set
                resourceCulture = value
            End Set
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Amount.
        '''</summary>
        Public Shared ReadOnly Property Amount() As String
            Get
                Return ResourceManager.GetString("Amount", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Enter the expense amount tax included or before GST, HST, QST (allowances are calculated on a tax included basis).
        '''</summary>
        Public Shared ReadOnly Property Amount_Instructions() As String
            Get
                Return ResourceManager.GetString("Amount_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Before GST/HST/QST.
        '''</summary>
        Public Shared ReadOnly Property AmountType_BeforeTaxes() As String
            Get
                Return ResourceManager.GetString("AmountType_BeforeTaxes", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Tax included.
        '''</summary>
        Public Shared ReadOnly Property AmountType_TaxIncluded() As String
            Get
                Return ResourceManager.GetString("AmountType_TaxIncluded", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Business size.
        '''</summary>
        Public Shared ReadOnly Property BusinessSize() As String
            Get
                Return ResourceManager.GetString("BusinessSize", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Select whether your organization is a large business or a small⁄medium business for GST⁄HST and QST purposes.
        '''</summary>
        Public Shared ReadOnly Property BusinessSize_Instructions() As String
            Get
                Return ResourceManager.GetString("BusinessSize_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Large.
        '''</summary>
        Public Shared ReadOnly Property BusinessSize_Large() As String
            Get
                Return ResourceManager.GetString("BusinessSize_Large", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Small/medium.
        '''</summary>
        Public Shared ReadOnly Property BusinessSize_SmallMedium() As String
            Get
                Return ResourceManager.GetString("BusinessSize_SmallMedium", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Click image to enlarge.
        '''</summary>
        Public Shared ReadOnly Property ClickImageToEnlarge() As String
            Get
                Return ResourceManager.GetString("ClickImageToEnlarge", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Calculation will use today’s Canadian indirect tax rate.
        '''</summary>
        Public Shared ReadOnly Property Date_Instructions() As String
            Get
                Return ResourceManager.GetString("Date_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Excise tax act.
        '''</summary>
        Public Shared ReadOnly Property ExciseTaxAct() As String
            Get
                Return ResourceManager.GetString("ExciseTaxAct", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Expense Type.
        '''</summary>
        Public Shared ReadOnly Property ExpenseType() As String
            Get
                Return ResourceManager.GetString("ExpenseType", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Allowance.
        '''</summary>
        Public Shared ReadOnly Property ExpenseType_Allowance() As String
            Get
                Return ResourceManager.GetString("ExpenseType_Allowance", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Gas for cars.
        '''</summary>
        Public Shared ReadOnly Property ExpenseType_GasForCars() As String
            Get
                Return ResourceManager.GetString("ExpenseType_GasForCars", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Select the expense type that the employee incurred in the course of commercial activities.
        '''</summary>
        Public Shared ReadOnly Property ExpenseType_Instructions() As String
            Get
                Return ResourceManager.GetString("ExpenseType_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Lodging.
        '''</summary>
        Public Shared ReadOnly Property ExpenseType_Lodging() As String
            Get
                Return ResourceManager.GetString("ExpenseType_Lodging", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to GST / HST Paid.
        '''</summary>
        Public Shared ReadOnly Property GST_HST_Paid() As String
            Get
                Return ResourceManager.GetString("GST_HST_Paid", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Calculates the GST / HST paid (to validate with receipt), or deemed paid for allowances, on the expense.
        '''</summary>
        Public Shared ReadOnly Property GST_HST_Paid_Instructions() As String
            Get
                Return ResourceManager.GetString("GST_HST_Paid_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to ITC.
        '''</summary>
        Public Shared ReadOnly Property ITC() As String
            Get
                Return ResourceManager.GetString("ITC", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to ITC is the input tax credit under the.
        '''</summary>
        Public Shared ReadOnly Property ITC_Instructions() As String
            Get
                Return ResourceManager.GetString("ITC_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to ITR.
        '''</summary>
        Public Shared ReadOnly Property ITR() As String
            Get
                Return ResourceManager.GetString("ITR", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to ITR is the input tax refund under the.
        '''</summary>
        Public Shared ReadOnly Property ITR_Instructions() As String
            Get
                Return ResourceManager.GetString("ITR_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Jurisdiction.
        '''</summary>
        Public Shared ReadOnly Property Jurisdiction() As String
            Get
                Return ResourceManager.GetString("Jurisdiction", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Select the Canadian province or territory where the expense was incurred.
        '''</summary>
        Public Shared ReadOnly Property Jurisdiction_Instructions() As String
            Get
                Return ResourceManager.GetString("Jurisdiction_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Net.
        '''</summary>
        Public Shared ReadOnly Property Net() As String
            Get
                Return ResourceManager.GetString("Net", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Refers to the net expense which equals the Total - ITC - ITR + RITC.
        '''</summary>
        Public Shared ReadOnly Property Net_Instructions() As String
            Get
                Return ResourceManager.GetString("Net_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Calculate net recoverable GST ⁄ HST &amp; QST for small ⁄ medium &amp; large businesses on travel expenses incurred by employees..
        '''</summary>
        Public Shared ReadOnly Property PageMainTitle() As String
            Get
                Return ResourceManager.GetString("PageMainTitle", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to QST Paid.
        '''</summary>
        Public Shared ReadOnly Property QST_Paid() As String
            Get
                Return ResourceManager.GetString("QST_Paid", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Calculates the QST paid (to validate with receipt), or deemed paid for allowances, on the expense.
        '''</summary>
        Public Shared ReadOnly Property QST_Paid_Instructions() As String
            Get
                Return ResourceManager.GetString("QST_Paid_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Quebec sales tax act.
        '''</summary>
        Public Shared ReadOnly Property QuebecSalesTaxAct() As String
            Get
                Return ResourceManager.GetString("QuebecSalesTaxAct", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to RITC.
        '''</summary>
        Public Shared ReadOnly Property RITC() As String
            Get
                Return ResourceManager.GetString("RITC", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to RITC is the Recapture of input tax credit under the.
        '''</summary>
        Public Shared ReadOnly Property RITC_Instructions() As String
            Get
                Return ResourceManager.GetString("RITC_Instructions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Sample Report from Advataxes.
        '''</summary>
        Public Shared ReadOnly Property SampleReportTitle() As String
            Get
                Return ResourceManager.GetString("SampleReportTitle", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to The tax calculator on travel expenses is done under the following assumptions; the person is a GST/HST and a QST registrant. The ratios of commercial activities of the person are 100%. The large business calculation automates the calculation of the recapture of input tax credits (RITC) in Ontario and PEI and restricted input tax refund in Quebec on meals and allowances under paragraph 236(1) of the &lt;i&gt;Excise Tax Act&lt;/i&gt; and section 457.1 of the Quebec Sales Tax Act and gas for cars as motive fuel other than [rest of string was truncated]&quot;;.
        '''</summary>
        Public Shared ReadOnly Property TaxCalculator_Assumptions() As String
            Get
                Return ResourceManager.GetString("TaxCalculator_Assumptions", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Advataxes is an employee expense software that automates the GST ⁄ HST &amp; QST paid, GST ⁄ HST &amp; QST recoverable and the recapture of input tax credits in Ontario and PEI, in the same manor as the tax calculator. Selecting an expense type, a jurisdiction and a date is the preferred system instead of the traditional one requiring all employees to select from a list of tax codes. This is a more efficient responsibility allocation structure. In the example below, you have a travel expense report for an employee  [rest of string was truncated]&quot;;.
        '''</summary>
        Public Shared ReadOnly Property TaxCalculator_Presentation() As String
            Get
                Return ResourceManager.GetString("TaxCalculator_Presentation", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Total.
        '''</summary>
        Public Shared ReadOnly Property Total() As String
            Get
                Return ResourceManager.GetString("Total", resourceCulture)
            End Get
        End Property
        
        '''<summary>
        '''  Looks up a localized string similar to Total expense amount submitted by the employee.
        '''</summary>
        Public Shared ReadOnly Property Total_Instructions() As String
            Get
                Return ResourceManager.GetString("Total_Instructions", resourceCulture)
            End Get
        End Property
    End Class
End Namespace