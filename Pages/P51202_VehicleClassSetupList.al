page 51202 "HBR Vehicle Class Setup List"
{
    PageType = List;
    Caption = 'Vehicle Class Setup List';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HBR Vehicle Class Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
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