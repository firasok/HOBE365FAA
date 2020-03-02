pageextension 51203 HBRPostedPurchInvoiceSubform extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Service Order No."; "Service Order No.") { }
            field("Service Item No."; "Service Item No.") { }
        }
    }
}