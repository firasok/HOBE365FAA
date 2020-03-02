tableextension 51100 HBRSalesInvoiceLine extends "Sales Invoice Line"
{
    fields
    {
        field(50000; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';

        }

        field(50001; "Sell-to Contact No."; Code[20])
        {
            Caption = 'Sell-to Contact No.';            

        }

        field(50002; "Webshop"; Boolean)
        {
            Caption = 'Webshop';

        }
    }

}