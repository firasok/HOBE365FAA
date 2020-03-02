page 51300 "HBR Budget Regulation Rates"
//<NCO>
// Page for showing and editing Budget Regulation Rates
//</NCO>
{
    PageType = List;
    Caption = 'HBR Budget Regulation Rate';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HBR Budget Regulation Rate";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Year; Year)
                {
                    ApplicationArea = All;

                }
                field("Budget Regulation Type"; "Budget Regulation Type")
                {
                    ApplicationArea = All;

                }
                field(Rate; Rate)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}
