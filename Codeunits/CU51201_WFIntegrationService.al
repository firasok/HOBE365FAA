codeunit 51201 "WF Integration Service"
{
    trigger OnRun()
    begin

    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnSendServiceOrderforApproval(VAR ServHeader: Record "Service Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnCancelServiceOrderApprovalRequest(VAR ServHeader: Record "Service Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnReopenServiceOrderApprovalRequest(VAR ServHeader: Record "Service Header");
    begin
    end;

    [IntegrationEvent(false, false)]
    PROCEDURE OnPerformManualRelease(VAR ServHeader: Record "Service Header");
    begin
    end;
}