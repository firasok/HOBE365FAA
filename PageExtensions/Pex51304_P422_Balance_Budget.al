pageextension 51304 HBRBalanceBudgetExt extends "G/L Balance/Budget"
//<NCO>
// Pageextension of Page 422, Redirect Copy Budget to "HBR Copy Budget", added Compare budget
//</NCO>
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        modify("Copy Budget")
        {
            Visible = False;
            Enabled = false;

        }
        addafter("Copy Budget")
        {
            action("HBRCopy Budget")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Caption = 'Copy Budget';
                ToolTip = 'Create a copy of the current budget based on a general ledger entry or a general ledger budget entry.';
                Promoted = true;
                Image = CopyBudget;
                PromotedCategory = Category6;


                trigger OnAction()
                begin
                    REPORT.RUNMODAL(REPORT::"HBR Copy G/L Budget", TRUE, FALSE);
                    CurrPage.UPDATE;
                end;
            }
            action("HBRCompare Budget")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Caption = 'Compare Budget';
                ToolTip = 'Regulate shown budget values, based on a different year.';
                Promoted = true;
                Image = CompareCOA;
                PromotedCategory = Category6;


                trigger OnAction()
                begin
                    page.RunModal(50113);
                end;
            }
        }


    }

    var
        myInt: Integer;
}