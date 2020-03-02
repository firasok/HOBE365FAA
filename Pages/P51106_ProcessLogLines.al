page 51106 "Process Log Lines"
{
    Caption = 'Process Log Lines';
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Process Log Line";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Log No."; "Log No.")
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



