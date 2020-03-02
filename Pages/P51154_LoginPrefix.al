

page 51154 "Login Prefix"
{
    Caption = 'Login Prefix';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Login Prefix";
    Editable = True;

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

                field(Description; Description)
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



