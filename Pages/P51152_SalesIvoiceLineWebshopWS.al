page 51152 "Sales Invoice Line WS"
{
    Caption = 'Sales Invoice Line WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Invoice Line";
    SourceTableView = where(Webshop = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = all;
                }

                field("Sell-to Contact No."; "Sell-to Contact No.")
                {
                    ApplicationArea = all;
                }

                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }

                field(Type; Type)
                {
                    ApplicationArea = all;
                }

                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;

            }
        }
    }

    var
        myInt: Integer;
}



