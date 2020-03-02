report 51201 "HBR Service Tasks"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/HBRServiceTasks.rdl';
    ApplicationArea = Service;
    Caption = 'Service Tasks';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Service Item Line"; "Service Item Line")
        {
            column(TodayFormat; Format(Today, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(ServItem_ServItemLine; TableCaption + ': ' + ServItemLineFilter)
            {
            }
            column(ServItemLineFilter; ServItemLineFilter)
            {
            }
            column(ResponseDate_ServItemLine; Format("Response Date"))
            {
            }
            column(ResponseTime_ServItemLine; "Response Time")
            {
                IncludeCaption = true;
            }
            column(Priority_ServItemLine; Priority)
            {
                IncludeCaption = true;
            }
            column(DocNo_ServItemLine; "Document No.")
            {
                IncludeCaption = true;
            }
            column(RepairStatus_ServItemLine; "Repair Status Code")
            {
                IncludeCaption = true;
            }
            column(ServItemGr_ServItemLine; "Service Item Group Code")
            {
                IncludeCaption = true;
            }
            column(ServItemNo_ServItemLine; "Service Item No.")
            {
                IncludeCaption = true;
            }
            column(ItemNo_ServItemLine; "Item No.")
            {
                IncludeCaption = true;
            }
            column(SerialNo_ServItemLine; "Serial No.")
            {
                IncludeCaption = true;
            }
            column(ServShelfNo_ServItemLine; "Service Shelf No.")
            {
                IncludeCaption = true;
            }
            column(Warranty_ServItemLine; Warranty)
            {
                IncludeCaption = true;
            }
            column(ContractNo_ServItemLine; "Contract No.")
            {
                IncludeCaption = true;
            }
            column(FormatWarranty; Format(Warranty))
            {
            }
            column(ServiceTasksCaption; ServiceTasksCaptionLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(ResponseDateCaption; ResponseDateCaptionLbl)
            {
            }
            //<NCO>
            column(Line_No_; "Line No.") { IncludeCaption = true; }
            column(Description; Description) { IncludeCaption = true; }
            column(Description_2; "Description 2") { IncludeCaption = true; }
            column(Service_Item_Group_Code; "Service Item Group Code") { IncludeCaption = true; }
            column(Contract_No_; "Contract No.") { IncludeCaption = true; }
            column(Location_of_Service_Item; "Location of Service Item") { IncludeCaption = true; }
            column(Customer_No_; "Customer No.") { IncludeCaption = true; }
            column(Description_2_Lbl; Description2Lbl) { }
            column(Line_No_Lbl; LineNoLbl) { }
            //<NCO>
            trigger OnPreDataItem()
            begin
                if (GetFilter("Allocation Status Filter") <> '') or
                   (GetFilter("Resource Filter") <> '') or
                   (GetFilter("Resource Group Filter") <> '')
                then
                    SetFilter("No. of Allocations", '>0');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ServItemLineFilter := "Service Item Line".GetFilters;
    end;

    var
        ServItemLineFilter: Text;
        ServiceTasksCaptionLbl: Label 'Service Tasks';
        CurrReportPageNoCaptionLbl: Label 'Page';
        ResponseDateCaptionLbl: Label 'Response Date';
        Description2Lbl: label 'Setup year'; //<NCO> Opsætningsår
        LineNoLbl: Label 'Order'; //<NCO> Rækkefølge

}

