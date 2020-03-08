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
    actions
    {
        addlast(processing)
        {
            group("User Group")
            {
                action("Posted Invoice Lines")
                {
                    Caption = 'Posted Invoice Lines';
                    ApplicationArea = All;
                    Enabled = Webshop;
                    Visible = Webshop;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = ItemGroup;
                    ToolTip = 'Posted Invoice Lines for Webshop Contact';
                    RunObject = page "Posted Sales Invoice Subform";
                    RunPageLink = "Sell-to Contact No." = FIELD("No.");

                    trigger OnAction()

                    begin
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin

    end;

}