// HBR Integration Comment Line Planorama Webservice

page 51143 "Webshop User Group"
{
    Caption = 'Webshop User Group';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Webshop User Group";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {

                    ApplicationArea = all;
                }
                field(Name; Name)
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



