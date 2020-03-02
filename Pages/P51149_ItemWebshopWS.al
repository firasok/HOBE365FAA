
page 51149 "Item Webshop WS"
{
    Caption = 'Item Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item";
    SourceTableView = where(Webshop = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    ApplicationArea = all;

                }

                field(Description;Description)
                {
                    ApplicationArea = all;
                
                }

                field("Description 2";"Description 2")
                {
                    ApplicationArea = all;

                }

                field("Base Unit of Measure";"Base Unit of Measure")
                {
                    ApplicationArea = all;

                }

                 field("Item Category Code";"Item Category Code")
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



