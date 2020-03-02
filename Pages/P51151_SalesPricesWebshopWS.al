
page 51151 "Sales Prices Webshop WS"
{
    Caption = 'Sales Prices Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Price";
    SourceTableView = where(Webshop = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                                
                field("Sales Type";"Sales Type")
                {
                    ApplicationArea = all;

                }

                field("Sales Code";"Sales Code")
                {
                    ApplicationArea = all;

                }

                field("Item No.";"Item No.")
                {
                    ApplicationArea = all;

                }

                field("Unit of Measure Code";"Unit of Measure Code")
                {
                    ApplicationArea = all;

                }

                field("Minimum Quantity";"Minimum Quantity")
                {
                    ApplicationArea = all;

                }

                field("Unit Price";"Unit Price")
                {
                    ApplicationArea = all;

                }

                field("Price Includes VAT";"Price Includes VAT")
                {
                    ApplicationArea = all;

                }

                field("Starting Date";"Starting Date")
                {
                    ApplicationArea = all;

                }

                field("Ending Date";"Ending Date")
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



