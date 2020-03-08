pageextension 51106 HBRPContactListExt extends "Contact List"

{
    layout
    {
        addafter("Fax No.")
        {
            field("Employee Code"; "Employee Code")
            {
                Editable = false;
                Visible = false;
                ApplicationArea = all;
            }
        }
    }
}