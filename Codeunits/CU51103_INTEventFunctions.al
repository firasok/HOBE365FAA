codeunit 51103 INTEventFunctions
{
    Permissions = tabledata "Sales Invoice Header" = rimd, tabledata "Sales Invoice Line" = rimd;
    procedure UpdateSalesInvLine(var SalesInvHeader: Record "Sales invoice Header"; var SalesInvLine: Record "Sales Invoice Line"; SalesLine: Record "Sales Line")
    var
        SalesHeader: record "Sales Header";
        IntegrationHeader: Record "Integration Header";

    begin
        if SalesInvHeader."External Document No." <> '' then begin
            SalesInvLine."External Document No." := SalesInvHeader."External Document No.";
            if IntegrationHeader.get(IntegrationHeader."Integration Source"::WEBSHOP, SalesInvHeader."External Document No.") then
                SalesInvLine.Validate(Webshop, true);
            if Salesheader.get(SalesLine."Document Type", SalesLine."Document No.") then
                SalesInvLine.Validate("Sell-to Contact No.", SalesHeader."Sell-to Contact No.");
            SalesInvLine.Modify;
        end;
    end;

    procedure UpdateWebshopIntegrationLog(VAR SalesHeader: Record "Sales Header";
                                                VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                                                SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20];
                                                SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

    begin
        if SalesHeader.Webshop then begin
            SalesHeader.CalcFields("Completely Shipped");
            if SalesHeader."Completely Shipped" then
                HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::WebOrder, SalesHeader."External Document No.", SalesHeader."No.", IntegrationAction::FullyInvoiced);
        end;
    end;

}
