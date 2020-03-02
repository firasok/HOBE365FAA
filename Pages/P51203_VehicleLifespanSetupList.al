page 51203 "HBR Vehic. Lifespan Setup List"
{
    PageType = List;
    Caption = 'Vehicle Lifespan Setup List';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HBR Vehicle Lifespan Setup";

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
                field(Dateformula; Dateformula)
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