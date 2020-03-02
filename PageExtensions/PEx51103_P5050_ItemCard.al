pageextension 51103 HBRPItemCardExt extends "Item Card"
{
    layout
    {
        addafter(Warehouse)
        {
            group(Integration)
            {
                Caption = 'Integration';

                field(Webshop; Webshop)
                {
                    Visible = true;
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
                action("Item User Group")
                {
                    Caption = 'Item User Group';
                    ApplicationArea = All;
                    Enabled = Webshop;
                    Visible = Webshop;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = ItemGroup;
                    ToolTip = 'Item User Group for Webshop';
                    RunObject = page "Item User Group";
                    RunPageLink = "Item No." = FIELD("No.");

                    trigger OnAction()

                    begin
                    end;
                }
            }
        }
    }


}