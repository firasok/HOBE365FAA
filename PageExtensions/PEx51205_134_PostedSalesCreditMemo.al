pageextension 51205 HBRPostedSalesCreditMemo extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("OIOUBL-F&unctions")
        {
            action("Update Customer Information")
            {
                Caption = 'Update Customer Information';
                Image = DocumentEdit;

                trigger OnAction()
                var
                    HBRfunctions: Codeunit HBRFunctions;
                    PostedSalesCreditMemo: Record "Sales Cr.Memo Header";
                begin
                    PostedSalesCreditMemo := Rec;
                    CurrPage.SETSELECTIONFILTER(PostedSalesCreditMemo);
                    PostedSalesCreditMemo.TestField("Bill-to Customer No.");
                    HBRfunctions.UpdatePostedSalesCreditMemo(PostedSalesCreditMemo);
                end;
            }
        }
    }
}