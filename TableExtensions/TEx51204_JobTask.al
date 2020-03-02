tableextension 51204 "HBR Job Task" extends "Job Task"
{
    fields
    {
        field(51000; "HBR Status"; Option)
        {

            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = Received,"In Progress",Closed,"Invoice Suggestion Created",Invoiced;
            //OptionMembers = Modtaget,Igang,Afsluttet,"Fakturaforslag dannet",Faktureret;
            OptionCaption = 'Received,In Progress,Closed,Invoice Suggestion Created,Invoiced';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if (xRec."HBR Status" = "HBR Status"::"Invoice Suggestion Created") or (xRec."HBR Status" = "HBR Status"::Invoiced) then begin
                    Error(StatusError, xRec."HBR Status");
                end;
                if (Rec."HBR Status" = "HBR Status"::"Invoice Suggestion Created") or (Rec."HBR Status" = "HBR Status"::"Invoiced") then
                    Error(SysStatusError, rec."HBR Status");
            end;
        }
        field(51300; "HBR Responsible"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Responsible';
            TableRelation = Resource;
        }
    }
    var
        StatusError: Label 'Cannot change the system status: %1.';
        SysStatusError: Label 'Status: %1 can only be set by the system';
}