pageextension 51206 "HBR Service Invoices" extends "Service Invoices"
{
    actions
    {
        addafter("P&osting")
        {
            action("Delete Service Invoice")
            {
                Caption = 'Delete Service Invoice';
                trigger OnAction()
                var
                    HBRFunctions: Codeunit "HBRFunctions";
                    DeleteInvoice: Boolean;
                begin

                    DeleteInvoice := Confirm('Are you sure you want to delete Service Invoice %1', true, Rec."No.");
                    if DeleteInvoice = true then
                        HBRFunctions.DeleteServiceInvoice(Rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}