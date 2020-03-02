pageextension 51100 HBRPostedSalesInvoiceSubExt extends "Posted Sales Invoice Subform"
{
    layout
    {
        addafter("No.")
        {
            field("External Document No."; "External Document No.")
            {
                Visible = false;
                ApplicationArea = all;
            }
        }
    }

} 