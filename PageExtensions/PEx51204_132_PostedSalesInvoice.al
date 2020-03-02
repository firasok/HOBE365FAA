pageextension 51204 HBRPostedSalesInvoice extends "Posted Sales Invoice"
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
                    PostedSalesInvoice: Record "Sales Invoice Header";
                begin
                    PostedSalesInvoice := Rec;
                    CurrPage.SETSELECTIONFILTER(PostedSalesInvoice);
                    PostedSalesInvoice.TestField("Bill-to Customer No.");
                    HBRfunctions.UpdatePostedSalesInvoice(PostedSalesInvoice);
                end;
            }
        }
    }

}