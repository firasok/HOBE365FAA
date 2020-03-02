codeunit 51000 HBRFunctions
{
    Permissions = tabledata "Sales Invoice Header" = rimd, tabledata "Sales Invoice Line" = rimd, tabledata "Service Ledger Entry" = rimd;

    trigger OnRun()
    var
    begin
    end;

    procedure DeleteServiceInvoice(Var ServiceInvoice: Record "Service Header")
    var
        ServiceLedgerEntry: Record "Service Ledger Entry";
        ServiceLine: Record "Service Line";
    begin
        ServiceLine.SetRange("Document No.", ServiceInvoice."No.");
        if ServiceLine.FindSet() then
            repeat
                If ServiceLine."Appl.-to Service Entry" <> 0 then begin
                    ServiceLedgerEntry.get(ServiceLine."Appl.-to Service Entry");
                    ServiceLedgerEntry.Delete();
                    ServiceLine."Appl.-to Service Entry" := 0;
                    ServiceLine.Modify();
                end;
            until serviceline.Next() = 0;

        RollBackServiceContract(ServiceInvoice);
        ServiceInvoice.Delete();
    end;

    local procedure RollBackServiceContract(Var ServiceInvoice: Record "Service Header")
    var
        ContractHeader: Record "Service Contract Header";
        ContractLine: Record "Service Contract Line";
        ServContractMgt: Codeunit ServContractManagement;
        ServDocumentRegistrer: Record "Service Document Register";

    begin
        ContractHeader.get(ContractHeader."Contract Type"::Contract, serviceInvoice."Contract No.");
        GetCalcDateFilter(ContractHeader);

        ServDocumentRegistrer.SetRange("Destination Document No.", ServiceInvoice."No.");
        ServDocumentRegistrer.DeleteAll();

        ContractHeader."Next Invoice Period Start" := CalcDate(CalcdateFormula, ContractHeader."Next Invoice Period Start");
        ContractHeader."Next Invoice Period End" := CalcDate(CalcdateFormula, ContractHeader."Next Invoice Period End");
        ContractHeader."Next Invoice Date" := CalcDate(CalcdateFormula, ContractHeader."Next Invoice Date");

        if ContractHeader.Prepaid then
            ContractHeader."Next Invoice Date" := ContractHeader."Next Invoice Period Start"
        else
            ContractHeader."Next Invoice Date" := ContractHeader."Next Invoice Period End";

        ContractHeader."Last Invoice Period End" := CalcDate(CalcdateFormula, ContractHeader."Last Invoice Period End");
        ContractHeader."Last Invoice Date" := CalcDate(CalcdateFormula, ContractHeader."Last Invoice Date");
        ContractHeader.Modify();

        ContractLine.SetRange("Contract Type", ContractLine."Contract Type"::Contract);
        ContractLine.SetRange("Contract No.", ContractHeader."Contract No.");
        if ContractLine.FindSet() then begin
            repeat
                ContractLine."Invoiced to Date" := Calcdate(CalcdateFormula, ContractLine."Invoiced to Date");
                ContractLine.Modify();
            until ContractLine.Next() = 0;
        end;

    end;

    local procedure GetCalcDateFilter(var ContractHeader: Record "Service Contract Header")
    begin
        case contractheader."Invoice Period" of
            ContractHeader."Invoice Period"::"Half Year":
                CalcdateFormula := '<+1D-6M-1D>';
            ContractHeader."Invoice Period"::Month:
                CalcdateFormula := '<+1D-1M-1D>';
            ContractHeader."Invoice Period"::Quarter:
                CalcdateFormula := '<+1D-1Q-1D>';
            ContractHeader."Invoice Period"::"Two Months":
                CalcdateFormula := '<+1D-2M-1D>';
            ContractHeader."Invoice Period"::Year:
                CalcdateFormula := '<+1D-1y-1D>';
            else
                CalcdateFormula := '';
        end;
    end;

    procedure CreateServiceItemWorksheetLine(PurchInvHdrNo: Code[20]): Boolean
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
        ServiceLine: Record "Service Line";
        ServiceItemLine: Record "Service Item Line";
    begin
        PurchInvHeader.get(PurchInvHdrNo);
        PurchInvLine.SetRange("Document No.", PurchInvHdrNo);

        if PurchInvLine.FindSet() then
            repeat
                if (PurchInvLine."Service Order No." = '') then
                    exit;
                if (PurchInvLine.Type <> PurchInvLine.Type::Item) AND (PurchInvLine.Type <> PurchInvLine.Type::"G/L Account") then
                    exit;
                if PurchInvLine."Service Order No." <> '' then begin
                    ServiceItemLine.SetRange("Document No.", PurchInvLine."Service Order No.");
                    ServiceItemLine.SetRange("Document type", ServiceItemLine."Document Type"::Order);
                    ServiceItemLine.SetRange("Service Item No.", PurchInvLine."Service Item No.");

                    if ServiceItemLine.isEmpty then begin
                        Error(ErrorEmptyLine, ServiceItemLine."Document No.");
                        exit;
                    end else begin
                        ServiceItemLine.FindLast();

                        Serviceline.SetRange("Document No.", PurchInvLine."Service Order No.");
                        ServiceLine.SetRange("Document Type", ServiceLine."Document Type"::Order);
                        if ServiceLine.findLast then begin
                            ServiceLine.Init();
                            ServiceLine."Line No." += 10000;
                            Serviceline.Insert();
                        end else begin
                            ServiceLine.Reset();
                            ServiceLine.Validate("Document Type", ServiceLine."Document Type"::Order);
                            ServiceLine.Validate("Document No.", PurchInvLine."Service Order No.");
                            ServiceLine."Line No." := 10000;
                            Serviceline.Insert();
                        end;
                        ServiceLine.SetHideReplacementDialog(true);
                        ServiceLine.Validate("Service Item No.", PurchInvLine."Service Item No.");
                        Serviceline.Validate("Service Item Line No.", Serviceitemline."Line No.");
                        case (PurchInvLine.Type) of
                            PurchInvLine.Type::"G/L Account":
                                begin
                                    Serviceline.validate(Type, Serviceline.type::"G/L Account");
                                    ServiceLine.Validate("No.", GetSalesAccount(PurchInvLine."No.", ServiceLine."Document No."));
                                end;
                            PurchInvLine.Type::Item:
                                begin
                                    ServiceLine.validate(Type, serviceline.type::Item);
                                    ServiceLine.Validate("No.", PurchInvLine."No.");
                                end;
                        end;
                        ServiceLine.Validate("Purchase Order No.", PurchInvHeader."Order No.");
                        ServiceLine.Validate(Description, PurchInvLine.Description);
                        ServiceLine.Validate("Unit Price", PurchInvLine."Direct Unit Cost");
                        ServiceLine.validate(Quantity, PurchInvLine.Quantity);

                        Serviceline.Modify();
                    end;
                end;
            until PurchInvLine.Next() = 0
    end;


    local procedure GetSalesAccount(GLAccountNo: Code[20]; DocumentNo: Code[20]) SalesAccount: Code[20]
    var
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        GeneralPostingSetup: Record "General Posting Setup";
        ServiceHeader: Record "Service Header";
    begin
        ServiceHeader.Get(ServiceHeader."Document Type"::Order, DocumentNo);
        Customer.Get(ServiceHeader."Customer No.");
        GLAccount.Get(GLAccountNo);
        GeneralPostingSetup.Get(Customer."Gen. Bus. Posting Group", GLAccount."Gen. Prod. Posting Group");
        SalesAccount := GeneralPostingSetup."Sales Account";
    end;

    procedure ValidateServiceOrder(var purchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        ServiceHeader: Record "Service Header";
    begin
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."Service Order No." <> '' then begin
                    serviceheader.get(serviceheader."Document Type"::Order, PurchaseLine."Service Order No.");
                end;
            until purchaseline.Next() = 0;
    end;

    procedure UpdatePostedSalesInvoice(var PostedSalesInvoice: record "Sales Invoice Header")
    var
        Customer: Record Customer;
    begin
        Customer.Get(PostedSalesInvoice."Sell-to Customer No.");
        PostedSalesInvoice.validate("Sell-to Customer No.", customer."No.");
        PostedSalesInvoice.validate("Sell-to Customer Name", Customer.Name);
        PostedSalesInvoice.validate("Sell-to Address", Customer.Address);
        PostedSalesInvoice.validate("Sell-to Address 2", Customer."Address 2");
        PostedSalesInvoice.validate("Sell-to Post Code", Customer."Post Code");
        PostedSalesInvoice.validate("Sell-to City", Customer.City);
        PostedSalesInvoice.validate("Sell-to Country/Region Code", Customer."Country/Region Code");
        PostedSalesInvoice.validate("Sell-to Contact", Customer."Primary Contact No.");
        PostedSalesInvoice.validate("OIOUBL-Sell-to Contact Phone No.", customer."Phone No.");
        PostedSalesInvoice.validate("OIOUBL-Sell-to Contact Fax No.", customer."Fax No.");
        PostedSalesInvoice.validate("OIOUBL-Sell-to Contact E-Mail", customer."E-Mail");
        PostedSalesInvoice.Modify();

        if Customer."Bill-to Customer No." <> '' then
            Customer.Get(customer."Bill-to Customer No.");

        PostedSalesInvoice.Validate("Bill-to Customer No.", customer."No.");
        PostedSalesInvoice.Validate("Bill-to Name", customer.Name);
        PostedSalesInvoice.Validate("Bill-to Address", customer.Address);
        PostedSalesInvoice.Validate("Bill-to Address 2", customer."Address 2");
        PostedSalesInvoice.Validate("Bill-to Post Code", customer."Post Code");
        PostedSalesInvoice.validate("Bill-to City", customer.City);
        PostedSalesInvoice.Validate("Bill-to Country/Region Code", customer."Country/Region Code");
        PostedSalesInvoice.Validate("Bill-to Contact No.", customer."Primary Contact No.");
        PostedSalesInvoice.Validate("Bill-to Contact", customer.Contact);
        PostedSalesInvoice.validate("OIOUBL-GLN", customer.GLN);
        PostedSalesInvoice.validate("VAT Registration No.", customer."VAT Registration No.");

        PostedSalesInvoice.Modify();
    end;

    procedure UpdatePostedSalesCreditMemo(var PostedSalesCreditMemo: Record "Sales Cr.Memo Header")
    var
        Customer: Record Customer;
    begin
        Customer.Get(PostedSalesCreditMemo."Sell-to Customer No.");
        PostedSalesCreditMemo.validate("Sell-to Customer No.", customer."No.");
        PostedSalesCreditMemo.validate("Sell-to Customer Name", Customer.Name);
        PostedSalesCreditMemo.validate("Sell-to Address", Customer.Address);
        PostedSalesCreditMemo.validate("Sell-to Address 2", Customer."Address 2");
        PostedSalesCreditMemo.validate("Sell-to Post Code", Customer."Post Code");
        PostedSalesCreditMemo.validate("Sell-to City", Customer.City);
        PostedSalesCreditMemo.validate("Sell-to Country/Region Code", Customer."Country/Region Code");
        PostedSalesCreditMemo.validate("Sell-to Contact", Customer."Primary Contact No.");
        PostedSalesCreditMemo.validate("OIOUBL-Sell-to Contact Phone No.", customer."Phone No.");
        PostedSalesCreditMemo.validate("OIOUBL-Sell-to Contact Fax No.", customer."Fax No.");
        PostedSalesCreditMemo.validate("OIOUBL-Sell-to Contact E-Mail", customer."E-Mail");
        PostedSalesCreditMemo.Modify();

        if Customer."Bill-to Customer No." <> '' then
            Customer.Get(customer."Bill-to Customer No.");

        PostedSalesCreditMemo.Validate("Bill-to Customer No.", customer."No.");
        PostedSalesCreditMemo.Validate("Bill-to Name", customer.Name);
        PostedSalesCreditMemo.Validate("Bill-to Address", customer.Address);
        PostedSalesCreditMemo.Validate("Bill-to Address 2", customer."Address 2");
        PostedSalesCreditMemo.Validate("Bill-to Post Code", customer."Post Code");
        PostedSalesCreditMemo.validate("Bill-to City", customer.City);
        PostedSalesCreditMemo.Validate("Bill-to Country/Region Code", customer."Country/Region Code");
        PostedSalesCreditMemo.Validate("Bill-to Contact No.", customer."Primary Contact No.");
        PostedSalesCreditMemo.Validate("Bill-to Contact", customer.Contact);
        PostedSalesCreditMemo.validate("OIOUBL-GLN", customer.GLN);
        PostedSalesCreditMemo.validate("VAT Registration No.", customer."VAT Registration No.");

        PostedSalesCreditMemo.Modify();
    end;

    procedure isJobTaskStatusClosed(var JobTask: Record "Job Task"; var IsHandled: Boolean)
    begin
        if JobTask."HBR Status" <> JobTask."HBR Status"::Closed then
            IsHandled := true;
    end;


    procedure SetJobTaskStatusAfterCreateInvoice(VAR SalesHeader: Record "Sales Header"; VAR Job: Record Job)
    var
        SalesLine: Record "Sales Line";
        JobTask: Record "Job Task";
    begin
        SalesLine.SetRange("Document Type", SalesLine."Document Type"::Invoice);
        SalesLine.SetRange("Document No.", SalesHeader."No.");

        if SalesLine.FindSet() then
            repeat
                if (SalesLine."Job No." <> '') AND (SalesLine."Job Task No." <> '') then begin
                    JobTask.Get(SalesLine."Job No.", SalesLine."Job Task No.");
                    if JobTask."HBR Status" = JobTask."HBR Status"::Closed then
                        JobTask."HBR Status" := "JobTask"."HBR Status"::"Invoice Suggestion Created";
                    JobTask.Modify();
                end;
            until SalesLine.Next() = 0
    end;

    procedure CreateTextLines(VAR JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header")
    var
        SalesLines: Record "Sales Line";
        SalesLines2: Record "Sales Line"; //To check if lines exist
        JobTask: Record "Job Task";
    begin

        SalesLines2.SetRange("Document Type", SalesLines."Document Type"::Invoice);
        SalesLines2.SetRange("Document No.", SalesHeader."No.");
        SalesLines2.SetFilter("Job Task No.", JobPlanningLine."Job Task No.");
        if not SalesLines2.IsEmpty then
            exit;

        SalesLines.SetRange("Document Type", SalesLines."Document Type"::Invoice);
        SalesLines.SetRange("Document No.", SalesHeader."No.");
        if SalesLines.IsEmpty then begin
            SalesLines.Init();
            SalesLines."Document Type" := SalesLines."Document Type"::Invoice;
            SalesLines."Document No." := SalesHeader."No.";
            SalesLines."Line No." := 10000;
        end else begin
            SalesLines.FindLast();
            SalesLines.init();
            SalesLines."Line No." += 10000;
        end;

        SalesLines.Insert();
        SalesLines.validate(Description, StrSubstNo(JobNoLbl, JobPlanningLine."Job Task No."));
        SalesLines.Modify();

        SalesLines.FindLast();
        SalesLines.init();
        SalesLines."Line No." += 10000;
        SalesLines.Insert();
        JobTask.get(JobPlanningLine."Job No.", JobPlanningLine."Job Task No.");
        SalesLines.validate(Description, JobTask.Description);
        SalesLines.Modify();

    end;

    procedure SetJobTaskStatusAfterPostInvoice(VAR SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        JobTask: Record "Job Task";
    begin
        SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");

        if SalesInvoiceLine.FindSet() then
            repeat
                if (SalesInvoiceLine."Job No." <> '') AND (SalesInvoiceLine."Job Task No." <> '') then begin
                    JobTask.Get(SalesInvoiceLine."Job No.", SalesInvoiceLine."Job Task No.");
                    if JobTask."HBR Status" = JobTask."HBR Status"::"Invoice Suggestion Created" then
                        JobTask."HBR Status" := "JobTask"."HBR Status"::Invoiced;
                    JobTask.Modify();
                end;
            until SalesInvoiceLine.Next() = 0
    end;

    local procedure CheckIfPurchaseLinesExist(PassedServHeader: Record "Service Header")
    var
        PurchaseLine: record "Purchase Line";
        PurchLineNotFullyInvoicedErrorLbl: Label 'Purchase Line %1 (%2 %3) (Linked to Service Order %4) is not fully invoiced.';
    begin
        PurchaseLine.SetRange("Service Order No.", PassedServHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if PurchaseLine."Quantity Invoiced" <> PurchaseLine.Quantity then
                    Error(strsubstno(PurchLineNotFullyInvoicedErrorLbl, PurchaseLine."Line No.", PurchaseLine."Document Type", PurchaseLine."Document No.", PurchaseLine."Service Order No."));

            until PurchaseLine.next = 0;
    end;

    procedure CheckServiceOrderOnPost(PassedServHeader: Record "Service Header"; PassedInvoice: Boolean)
    var

    begin
        if not PassedInvoice then
            exit;
        CheckIfPurchaseLinesExist(PassedServHeader);
    end;

    procedure CheckServiceOrderOnRelease(PassedServHeader: Record "Service Header")
    begin
        CheckIfRepairStatusFinished(PassedServHeader);
        CheckIfPurchaseLinesExist(PassedServHeader);
    end;

    local procedure CheckIfRepairStatusFinished(PassedServHeader: Record "Service Header")
    var
        ErrorRepairStatusLbl: Label 'Cannot Release because Service Order %1 has Repair Status %2. Status should be %3';
    begin
        if PassedServHeader.Status <> PassedServHeader.Status::Finished then
            Error(ErrorRepairStatusLbl, PassedServHeader."No.", PassedServHeader.Status, PassedServHeader.Status::Finished);
    end;


    procedure GetUsernameFromDomainUserName(Var DomainUserName: Code[50]): Code[20]
    var
        TempText: Text;
        SalespersonPurchaserNo: Code[20];
    begin
        TempText := FORMAT(DomainUserName);

        SalespersonPurchaserNo := CopyStr(TempText, 5);
        Exit(SalespersonPurchaserNo);
    end;

    procedure CheckApprovalStatus(ServiceHeader: Record "Service Header")
    var
        ErrorApprovalStatus: label 'You cannot invoice Service Order %1 because Approval Status is not %2';
    begin
        if (ServiceHeader."Approval Status" <> ServiceHeader."Approval Status"::Released) then
            if (ServiceHeader."Document Type" = ServiceHeader."Document Type"::Order) then
                Error(ErrorApprovalStatus, ServiceHeader."No.", ServiceHeader."Approval Status"::Released);
    end;

    var
        ErrorEmptyLine: label 'No Service item exists on serviceorder %1';
        CalcdateFormula: Text;
        JobNoLbl: Label 'Job No. : %1';

}