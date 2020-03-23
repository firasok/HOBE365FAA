// HBR Integration Webshop Webservice

page 51135 "Webshop Integration Log WS"
{
    Caption = 'Webshop Integration Log WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Webshop Integration Log";
    //DelayedInsert = true;
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {

                }
                field("Integration Table"; "Integration Table")
                {

                }
                field("Integration No."; "Integration No.")
                {

                }
                field("Integration No.2"; "Integration No.2")
                {

                }
                field("Integration Action"; "Integration Action")
                {

                }
                field("Action Date"; "Action Date")
                {

                }
                field("Action Time"; "Action Time")
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



