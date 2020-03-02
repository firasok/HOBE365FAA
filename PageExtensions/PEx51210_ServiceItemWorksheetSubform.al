pageextension 51210 "HBR Serv Item WS Subform" extends "Service Item Worksheet Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Purchase Order No."; "Purchase Order No.")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order No.';
            }
        }
    }
}