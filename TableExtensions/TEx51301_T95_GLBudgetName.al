tableextension 51301 HBRGLBudgetNameExt extends "G/L Budget Name"
//<NCO>
//Tableextension of table 95, Used for locking budgets and handling base year for copying and comparison purposes
//</NCO>
{

    fields
    {
        // Add changes to table fields here
        field(50000; "Budget Regulation Base Year"; integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Year';
            MinValue = 2000;
            MaxValue = 2999;

        }
        field(50001; Locked; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Locked';
            trigger onvalidate()
            var
                HBRSetup: Record "HBR Setup";
            begin
                if not HBRSetup.IsBudgetResponsible(userID) then
                    error(BudgetLockedEditErrorLbl);
            end;
        }

    }
    var
        BudgetLockedEditErrorLbl: Label 'Budget may only be locked or unlocked by the budget responsible.';

}