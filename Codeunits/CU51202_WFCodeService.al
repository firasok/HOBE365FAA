codeunit 51202 "WF Code Service"
{
    trigger OnRun()
    begin

    end;

    procedure RunWorkflowOnSendServiceOrderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendServiceOrderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WF Integration Service", 'OnSendServiceOrderforApproval', '', false, false)]
    procedure OnSendServiceOrderforApproval(var ServHeader: Record "Service Header")
    begin
        if ServHeader."Release Status" = ServHeader."Release Status"::Open then
            Error(ErrorServiceOrderNotRelased);
        if not IsServiceOrderEnabled(ServHeader) then
            Error(ErrorWorkFlowNotEnabled);
        WFMngt.HandleEvent(RunWorkflowOnSendServiceOrderApprovalCode(), ServHeader);
    end;

    procedure RunWorkflowOnCancelServiceOrderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelServiceOrderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WF Integration Service", 'OnCancelServiceOrderApprovalRequest', '', false, false)]
    procedure OnCancelServiceOrderApprovalRequest(var ServHeader: Record "Service Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelServiceOrderApprovalCode(), ServHeader);
    end;

    procedure RunWorkflowOnApproveServiceOrderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveServiceOrderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveServiceOrderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveServiceOrderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnRejectServiceOrderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectServiceOrderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectServiceOrderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectServiceOrderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    procedure RunWorkflowOnDelegateServiceOrderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateServiceOrderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateServiceOrderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateServiceOrderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WF Integration Service", 'OnReopenServiceOrderApprovalRequest', '', false, false)]
    procedure OnReopenServiceOrderApprovalRequest(var ServHeader: Record "Service Header")
    var
        RecRef: Variant;
    begin
        if ServHeader."Release Status" = ServHeader."Release Status"::Open then
            Error(ErrorServiceOrderNotRelased);
        RecRef := ServHeader;
        ReOpenServiceOrder(RecRef);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WF Integration Service", 'OnPerformManualRelease', '', false, false)]
    procedure OnPerformManualRelease(var ServHeader: Record "Service Header")
    var
        ServLines: Record "Service Line";
    begin
        if ServHeader."Release Status" = ServHeader."Release Status"::Open then
            Error(ErrorNotReleasedToShip);
        if (ServHeader."Approval Status" = ServHeader."Approval Status"::"Pending Approval") OR (ServHeader."Approval Status" = ServHeader."Approval Status"::Released) then
            Error(ErrorServiceHeaderApprovalSent);
        if IsServiceOrderEnabled(ServHeader) then begin
            ServLines.SetRange("Document Type", ServHeader."Document Type");
            ServLines.SetRange("Document No.", ServHeader."No.");
            if ServLines.FindSet() then begin //This checks if service lines are outside of budget.
                repeat
                    if ServLines."Qty. to Invoice" <> 0 then
                        Error(ErrorWorkFlowEnabled);
                until ServLines.next = 0;
            end;
        end;
        ServHeader."Approval Status" := ServHeader."Approval Status"::Released;
    end;

    procedure SetStatusToPendingApprovalCodeServiceOrder(): Code[128]
    begin
        exit(UpperCase('SetStatusToPendingApprovalServiceOrder'));
    end;

    procedure SetStatusToPendingApprovalServiceOrder(var Variant: Variant)
    var
        RecRef: RecordRef;
        ServHeader: Record "Service Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Service Header":
                begin
                    RecRef.SetTable(ServHeader);
                    ServHeader.Validate("Approval Status", ServHeader."Approval Status"::"Pending Approval");
                    ServHeader.Modify();
                    Variant := ServHeader;
                end;
        end;
    end;

    procedure ReleaseServiceOrderCode(): Code[128]
    begin
        exit(UpperCase('ReleaseServiceOrder'));
    end;

    procedure ReleaseServiceOrder(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ServHeader: Record "Service Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReleaseServiceOrder(Variant);
                end;
            DATABASE::"Service Header":
                begin
                    RecRef.SetTable(ServHeader);
                    ServHeader.Validate("Approval Status", ServHeader."Approval Status"::Released);
                    ServHeader.Modify();
                    Variant := ServHeader;
                end;
        end;
    end;

    procedure ReOpenServiceOrderCode(): Code[128]
    begin
        exit(UpperCase('ReOpenServiceOrder'));
    end;

    procedure ReOpenServiceOrder(var Variant: Variant)
    var
        RecRef: RecordRef;
        TargetRecRef: RecordRef;
        ApprovalEntry: Record "Approval Entry";
        ServHeader: Record "Service Header";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number() of
            DATABASE::"Approval Entry":
                begin
                    ApprovalEntry := Variant;
                    TargetRecRef.Get(ApprovalEntry."Record ID to Approve");
                    Variant := TargetRecRef;
                    ReOpenServiceOrder(Variant);
                end;
            DATABASE::"Service Header":
                begin
                    RecRef.SetTable(ServHeader);
                    ServHeader.Validate("Approval Status", ServHeader."Approval Status"::Open);
                    ServHeader.Modify();
                    Variant := ServHeader;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure AddServiceOrderEventToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendServiceOrderApprovalCode(), Database::"Service Header", SendServiceOrderReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveServiceOrderApprovalCode(), Database::"Approval Entry", AppReqServiceOrder, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectServiceOrderApprovalCode(), Database::"Approval Entry", RejReqServiceOrder, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateServiceOrderApprovalCode(), Database::"Approval Entry", DelReqServiceOrder, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelServiceOrderApprovalCode(), Database::"Service Header", CancelReqServiceOrder, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsesToLibrary', '', false, false)]
    procedure AddServiceOrderRespToLibrary()
    begin
        WorkflowResponseHandling.AddResponseToLibrary(SetStatusToPendingApprovalCodeServiceOrder(), 0, SendForPendAppTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReleaseServiceOrderCode(), 0, ReleaseServiceOrderTxt, 'GROUP 0');
        WorkflowResponseHandling.AddResponseToLibrary(ReOpenServiceOrderCode(), 0, ReOpenServiceOrderTxt, 'GROUP 0');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', false, false)]
    procedure ExeRespForServiceOrder(var ResponseExecuted: Boolean; Variant: Variant; xVariant: Variant; ResponseWorkflowStepInstance: Record "Workflow Step Instance")
    var
        WorkflowResponse: Record "Workflow Response";
    begin
        IF WorkflowResponse.GET(ResponseWorkflowStepInstance."Function Name") THEN
            case WorkflowResponse."Function Name" of
                SetStatusToPendingApprovalCodeServiceOrder():
                    begin
                        SetStatusToPendingApprovalServiceOrder(Variant);
                        ResponseExecuted := true;
                    end;
                ReleaseServiceOrderCode():
                    begin
                        ReleaseServiceOrder(Variant);
                        ResponseExecuted := true;
                    end;
                ReOpenServiceOrderCode():
                    begin
                        ReOpenServiceOrder(Variant);
                        ResponseExecuted := true;
                    end;
            end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        ServHeader: Record "Service Header";
    begin
        case RecRef.Number of
            DATABASE::"Service Header":
                begin
                    RecRef.SetTable(ServHeader);
                    ApprovalEntryArgument."Document Type" := ServHeader."Document Type";
                    ApprovalEntryArgument."Document No." := ServHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := ServHeader."Salesperson Code";
                    ApprovalEntryArgument."Currency Code" := ServHeader."Currency Code";
                end;
        end;
    end;

    procedure IsServiceOrderEnabled(var ServHeader: Record "Service Header"): Boolean
    var
        WFMngt: Codeunit "Workflow Management";
        WFCode: Codeunit "WF Code Service";
    begin
        exit(WFMngt.CanExecuteWorkflow(ServHeader, WFCode.RunWorkflowOnSendServiceOrderApprovalCode()))
    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";

        SendServiceOrderReq: Label 'Approval Request for Service Order is requested';
        AppReqServiceOrder: Label 'Approval Request for Service Order is approved';
        RejReqServiceOrder: Label 'Approval Request for Service Order is rejected';
        DelReqServiceOrder: Label 'Approval Request for Service Order is delegated';
        SendForPendAppTxt: Label 'Status of Service Order changed to Pending approval';
        ReleaseServiceOrderTxt: Label 'Release Service Order';
        ReOpenServiceOrderTxt: Label 'Reopen Service Order';
        CancelReqServiceOrder: label 'Approval Request for Service Order is cancelled';
        ErrorServiceOrderNotRelased: label 'Cannot send Approval Request because Service Order is not Released to Ship';
        ErrorNotReleasedToShip: label 'Cannot perform action because Service Order is not Released to Ship';
        ErrorCancelApproval: Label 'The approval process must be cancelled or completed to reopen this document.';
        ErrorServiceHeaderApprovalSent: Label 'Cannot perform action because Approval has been sent for Service Order.';
        ErrorWorkFlowEnabled: Label 'Cannot set Approval Status to Released because workflow is enabled for the Record';
        ErrorWorkFlowNotEnabled: Label 'Cannot send Approval Request because no workflow is enabled for the Record';

}