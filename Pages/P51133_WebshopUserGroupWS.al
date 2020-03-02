// HBR Integration Webshop Webservice

page 51133 "Webshop User Group WS"
{
    Caption = 'Webshop User Group WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Webshop User Group";   
    //DelayedInsert = true;     
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                { 

                }

                field(Name;Name)
                {

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



