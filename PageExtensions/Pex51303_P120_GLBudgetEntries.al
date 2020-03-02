pageextension 51303 HBRGlBudgetEntriesExt extends "G/L Budget Entries"
//<NCO>
// Pageextension of Page 120, added fields after Amount
//</NCO>
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Budget New Value"; "Budget New Value")
            {
                ApplicationArea = All;
            }
            field("Budget Deviation"; "Budget Deviation")
            {
                ApplicationArea = All;
            }
            field("Budget Deviation Comment"; "Budget Deviation Comment")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}