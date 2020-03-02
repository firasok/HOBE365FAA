pageextension 51214 "HBR Purch Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Activity Name"; "Activity Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(ShortcutDimCode5)
        {
            field("Service Order No."; "Service Order No.")
            {
                ApplicationArea = All;
            }
            field("Service Item No."; "Service Item No.")
            {
                ApplicationArea = All;
            }
        }
    }
}