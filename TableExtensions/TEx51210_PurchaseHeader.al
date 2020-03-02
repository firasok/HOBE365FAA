tableextension 51210 "HBR Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Activity Name"; Text[50])
        {
            Caption = 'Activity Name';
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name where("Global Dimension No." = CONST(2), Code = field("Shortcut Dimension 2 Code")));
        }
    }
}