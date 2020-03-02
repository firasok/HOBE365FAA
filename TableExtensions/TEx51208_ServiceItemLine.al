tableextension 51208 "HBR Service Item Lines" extends "Service Item Line"
{
    trigger OnInsert()
    var
        ServiceHeader: Record "Service Header";
        ErrorApprovalStatus: Label 'You cannot modify Service Order %1 because Approval Status is %2';
    begin
        ServiceHeader.get("Document Type"::Order, rec."Document No.");
        if ServiceHeader."Approval Status" = ServiceHeader."Approval Status"::Released then
            Error(ErrorApprovalStatus, ServiceHeader."No.", ServiceHeader."Approval Status");
    end;

    trigger OnBeforeModify()
    var
        ServiceHeader: Record "Service Header";
        ErrorApprovalStatus: Label 'You cannot modify Service Order %1 because Approval Status is %2';
    begin
        ServiceHeader.get("Document Type"::Order, rec."Document No.");
        if ServiceHeader."Approval Status" = ServiceHeader."Approval Status"::Released then
            Error(ErrorApprovalStatus, ServiceHeader."No.", ServiceHeader."Approval Status");
    end;
}
