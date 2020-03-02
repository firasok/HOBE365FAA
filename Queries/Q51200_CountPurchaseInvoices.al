query 51200 "Count Purchase Invoices"
{
    Caption = 'Count Purchase Invoices';

    elements
    {
        dataitem(Purchase_Header; "Purchase Header")
        {
            DataItemTableFilter = "Document Type" = CONST(Invoice);
            filter(Completely_Received; "Completely Received")
            {
            }
            filter(Status; Status)
            {
            }
            column(Count_Invoices)
            {
                Method = Count;
            }
        }
    }
}
