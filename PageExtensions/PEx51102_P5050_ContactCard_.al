pageextension 51102 HBRPContactCardExt extends "Contact Card"
{
    layout
    {
        addafter(Communication)
        {
            group(Integration)
            {
                Caption = 'Integration';

                field(Webshop; Webshop)
                {
                    Editable = true;
                    ApplicationArea = all;

                }

                field("Webshop User Group"; "Webshop User Group")
                {
                    Editable = Webshop;
                    ApplicationArea = all;

                }

                field("Employee Code"; "Employee Code")
                {
                    Editable = Webshop;
                    ApplicationArea = all;

                }

                field("Login Prefix"; "Login Prefix")
                {
                    Editable = false;
                    ApplicationArea = all;

                }
                
            }

        }
    }
    trigger OnAfterGetRecord()
    begin

    end;

}