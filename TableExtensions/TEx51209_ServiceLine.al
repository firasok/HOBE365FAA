tableextension 51209 "HBR Service Line" extends "Service Line"
{
    fields
    {
        field(50000; "Purchase Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order No.';
            Editable = false;
        }
    }
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