
page 51145 "Webshop Integration Log"
{
    Caption = 'Webshop Integration Log';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Webshop Integration Log";
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;

                }
                field("Integration Table"; "Integration Table")
                {
                    ApplicationArea = all;

                }
                field("Integration No."; "Integration No.")
                {
                    ApplicationArea = all;

                }
                field("Integration No.2"; "Integration No.2")
                {
                    ApplicationArea = all;

                }
                field("Integration Action"; "Integration Action")
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



