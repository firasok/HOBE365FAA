tableextension 51202 HBRPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Order No.';
            TableRelation = "Service Header"."No." where("Document Type" = filter(Order));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Rec."Service Order No." <> xRec."Service Order No." then begin
                    clear("Service Item No.");
                end;
            end;
        }
        field(50001; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Item No.';
            TableRelation = "Service Item";

            trigger OnLookup()
            var
                ServiceItemLine: Record "Service Item Line";
            begin
                if "Service Order No." <> '' then begin
                    ServiceItemLine.Reset();
                    ServiceItemLine.FilterGroup(10);
                    ServiceItemLine.SetRange("Document No.", "Service Order No.");
                    ServiceItemLine.FilterGroup(0);
                    If Page.RunModal(0, ServiceItemLine) = Action::LookupOK Then
                        "Service Item No." := ServiceItemLine."Service Item No.";
                end;
            end;
        }
        field(50010; "Activity Name"; Text[50])
        {
            Caption = 'Activity Name';
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name where("Global Dimension No." = CONST(2), Code = field("Shortcut Dimension 2 Code")));
        }

    }
}