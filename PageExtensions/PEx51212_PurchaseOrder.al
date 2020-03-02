pageextension 51212 "HBR Purchase Order" extends "Purchase Order"
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

    actions
    {
    }

}