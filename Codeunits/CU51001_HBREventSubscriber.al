codeunit 51001 HBREventSubscriber
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure OnBeforePostPurchaseDoc(VAR PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    var
        HBRFunction: CodeUnit HBRfunctions;
    begin
        HBRFunction.ValidateServiceOrder(PurchaseHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Service-Post (Yes/No)", 'OnBeforeConfirmServPost', '', false, false)]
    local procedure OnBeforeConfirmServPost(var ServiceHeader: Record "Service Header"; var HideDialog: Boolean; var Ship: Boolean; var Consume: Boolean; var Invoice: Boolean; var IsHandled: Boolean; PreviewMode: Boolean; var ServiceLine: Record "Service Line")
    begin
        HBRFunction.CheckApprovalStatus(ServiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PurchRcpHdrNo: Code[20]; RetShptHdrNo: Code[20]; PurchInvHdrNo: Code[20]; PurchCrMemoHdrNo: Code[20]; CommitIsSupressed: Boolean)
    var
        HBRFunctions: CodeUnit HBRFunctions;
    begin
        if PurchInvHdrNo = '' then
            exit;
        HBRFunctions.CreateServiceItemWorksheetLine(PurchInvHdrNo);
    end;


    [EventSubscriber(ObjectType::Report, Report::"Job Create Sales Invoice", 'OnBeforeJobTaskOnAfterGetRecord', '', false, false)]
    local procedure OnBeforeJobTaskOnAfterGetRecord(JobTask: Record "Job Task"; VAR IsHandled: Boolean)
    begin
        HBRFunction.isJobTaskStatusClosed(JobTask, IsHandled);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskOnAfterLinesCreated', '', false, false)]
    local procedure OnCreateSalesInvoiceJobTaskOnAfterLinesCreated(VAR SalesHeader: Record "Sales Header"; VAR Job: Record Job)
    begin
        HBRFunction.SetJobTaskStatusAfterCreateInvoice(SalesHeader, Job);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Create-Invoice", 'OnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLine', '', false, false)]
    local procedure OnCreateSalesInvoiceJobTaskOnBeforeCreateSalesLine(VAR JobPlanningLine: Record "Job Planning Line"; SalesHeader: Record "Sales Header"; SalesHeader2: Record "Sales Header"; VAR NoOfSalesLinesCreated: Integer)
    begin
        HBRFunction.CreateTextLines(JobPlanningLine, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]

    local procedure OnAfterFinalizePosting(VAR SalesHeader: Record "Sales Header"; VAR SalesShipmentHeader: Record "Sales Shipment Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"; VAR ReturnReceiptHeader: Record "Return Receipt Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean; PreviewMode: Boolean);
    begin
        HBRFunction.SetJobTaskStatusAfterPostInvoice(SalesInvoiceHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"service-Post", 'OnBeforePostWithLines', '', false, false)]
    local procedure OnBeforeServicePostWithLines(VAR PassedServHeader: Record "Service Header"; VAR PassedServLine: Record "Service Line"; VAR PassedShip: Boolean; VAR PassedConsume: Boolean; VAR PassedInvoice: Boolean);
    var
        HBRFunctions: CodeUnit HBRFunctions;
    begin
        HBRFunctions.CheckServiceOrderOnPost(PassedServHeader, PassedInvoice);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Service Document", 'OnBeforePerformManualRelease', '', false, false)]
    local procedure OnBeforePerformManualRelease(var ServiceHeader: Record "Service Header")
    begin
        HBRFunction.CheckServiceOrderOnRelease(ServiceHeader);
    end;

    var
        HBRFunction: CodeUnit HBRfunctions;






}