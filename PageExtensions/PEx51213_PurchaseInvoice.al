pageextension 51213 "HBR Purchase Invoice" extends "Purchase Invoice"
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
    }

}