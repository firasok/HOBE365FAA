tableextension 51203 HBRPurchInvLine extends "Purch. Inv. Line"
{
    fields
    {
        field(50000; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Order No.';
            TableRelation = "Service Header"."No." where ("Document Type" = filter (Order));
        }
        field(50001; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Item No.';
            TableRelation = "Service Item";
        }
    }

    var
        myInt: Integer;
}