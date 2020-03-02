
page 51150 "Item Variant Webshop WS"
{
    Caption = 'Item Variants Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Variant";
    SourceTableView = where(Webshop = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;

                }

                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;

                }

                field(Description; Description)
                {
                    ApplicationArea = all;

                }

                field("Description 2"; "Description 2")
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



