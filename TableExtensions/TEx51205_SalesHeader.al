tableextension 51205 "HBR Sales Header" extends "Sales Header"
{
    fields
    {
        //HBR Integration 
        field(5000; "Webshop"; Boolean)
        {
            Caption = 'Webshop';

        }
    }

    trigger OnAfterModify()

    var
        integraiotnHeader: Record "Integration Header";
        Text000: label 'Order %1 is connected to a weborder do you want to continue?';
        Text001: label 'The filed value %1:%2 have not been changed';
    begin
        if ("External Document No." <> '') and (integraiotnHeader.get(integraiotnHeader."Integration Source"::WEBSHOP, "External Document No.")) then begin
            if xRec."Sell-to Contact No." <> Rec."Sell-to Contact No." then begin
                if not Confirm(StrSubstNo(Text000, rec."No."), true) then
                    Error(StrSubstNo(Text000, FieldCaption("Sell-to Contact No."), "Sell-to Contact No."));
            end;

            if xRec."External Document No." <> Rec."External Document No." then begin
                if not Confirm(StrSubstNo(Text000, rec."No."), true) then
                    Error(StrSubstNo(Text000, FieldCaption("External Document No."), "External Document No."));
            end;
        end;
    end;

    trigger OnbeforeDelete()
    var
        SalesLine: Record "Sales Line";
        JobTask: Record "Job Task";
        //>>HBR-FAA
        IntegrationHeader: Record "Integration Header";
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;
    //<<HBR-FAA

    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Invoice);
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."Job Task No." <> '' then begin
                    JobTask.get(SalesLine."Job No.", SalesLine."Job Task No.");
                    if JobTask."HBR Status" = JobTask."HBR Status"::"Invoice Suggestion Created" then begin
                        JobTask."HBR Status" := JobTask."HBR Status"::Closed;
                        JobTask.Modify();
                    end;
                end;
            until SalesLine.Next() = 0;

        //>>HBR-FAA
        //if rec."External Document No." <> '' then begin
        if rec.Webshop then begin
            //if IntegrationHeader.get(rec."External Document No.") then begin
            //if UpdateWebshopLog(Rec) then
            //HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::WebOrder, rec."External Document No.", Rec."No.", IntegrationAction::FullyInvoiced)
            //else
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::WebOrder, rec."External Document No.", Rec."No.", IntegrationAction::Delete)
        end;
    end;
    //<<HBR-FAA
    //end;

    procedure UpdateWebshopLog(pSalesHeader: Record "Sales Header"): Boolean
    var

        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        fullInvoiced: Boolean;
    begin
        fullInvoiced := true;
        SalesHeader := pSalesHeader;
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", "Document Type"::Order);
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                if SalesLine."Quantity Shipped" <> SalesLine."Quantity Invoiced" then begin
                    fullInvoiced := false;
                    exit(fullInvoiced)
                end;
            until SalesLine.next = 0;
        exit(fullInvoiced);

    end;

}