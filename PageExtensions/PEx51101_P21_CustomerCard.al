pageextension 51101 HBRPCustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter(Shipping)
        {
            group(Integration)
            {
                Caption = 'Integration';

                field(Webshop; Webshop)
                {
                    Visible = true;
                    ApplicationArea = all;
                }

                field("Login Prefix"; "Login Prefix")
                {
                    Editable = Webshop;
                    ApplicationArea = all;
                }

                field(Planorama; Planorama)
                {
                    Visible = true;
                    ApplicationArea = all;
                }
            }

        }
    }
}