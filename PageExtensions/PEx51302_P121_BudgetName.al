pageextension 51302 HBRBudgetNameExt extends "G/L Budget Names"
//<NCO>
// Pageextension of Page 121, added fields Locked and "Budget Regulation Base Year", changed link to budget so HBR Budget is called instead
//</NCO>
{
    layout
    {
        // Add changes to page layout here
        addafter(Blocked)
        {
            field("Budget Regulation Base Year"; "Budget Regulation Base Year")
            {
                ApplicationArea = All;

            }
            field(locked; locked)
            {
                ApplicationArea = All;

            }

        }
    }

    actions
    {
        // Add changes to page actions here
        modify(EditBudget)
        {
            Enabled = false;
            Visible = false;
            ShortcutKey = CtrlShiftZ;

        }
        addafter(EditBudget)
        {
            action(HBREditBudget)
            {
                ApplicationArea = All;
                ShortCutKey = Return;
                Caption = 'Edit Budget';
                ToolTip = 'Specify budgets that you can create in the general ledger application area. If you need several different budgets, you can create several budget names.';
                Promoted = true;
                PromotedIsBig = true;
                Image = EditLines;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    HBRbudget: page HBRBudget;
                begin
                    hbrBudget.SetBudgetName(Name);
                    hbrBudget.RUN;
                end;
            }


        }

    }

    var
        myInt: Integer;
}