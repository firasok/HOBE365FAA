tableextension 51303 HBRGLAccBudgetBuf extends "G/L Acc. Budget Buffer"
//<NCO>
//Tableextension of table 374, used for handling deviation amounts
//</NCO>
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Deviation Amount"; Decimal)
        {
            
        }
    }

    var

    procedure CalcDevAmount()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        DevAmt: Decimal;
    begin
        GLBudgetEntry.SetCurrentKey("Budget Name", "G/L Account No.", "business unit code", "Global Dimension 1 code", "Global Dimension 2 code", "Budget Dimension 1 code", "Budget Dimension 2 code", "Budget Dimension 3 code", "Budget Dimension 4 code", DAte);
        GLBudgetEntry.Setfilter("Budget Name", getfilter("Budget Filter"));
        GLBudgetEntry.Setfilter("G/L Account No.", getfilter("G/L Account Filter"));
        GLBudgetEntry.SetFilter("Business Unit Code", getfilter("Business Unit Filter"));
        GLBudgetEntry.SetFilter("Global Dimension 1 Code", getfilter("Global Dimension 1 Filter"));
        GLBudgetEntry.SetFilter("Global Dimension 2 Code", getfilter("Global Dimension 2 Filter"));
        GLBudgetEntry.SetFilter("Budget Dimension 1 Code", getfilter("Budget Dimension 1 Filter"));
        GLBudgetEntry.SetFilter("Budget Dimension 2 Code", getfilter("Budget Dimension 2 Filter"));
        GLBudgetEntry.SetFilter("Budget Dimension 3 Code", getfilter("Budget Dimension 3 Filter"));
        GLBudgetEntry.SetFilter("Budget Dimension 4 Code", getfilter("Budget Dimension 4 Filter"));
        GLBudgetEntry.SetFilter(Date, getfilter("Date Filter"));
        GLBudgetEntry.SetRange("Budget Deviation Entry", true);

        DevAmt := 0;
        if not GLBudgetEntry.IsEmpty then begin

            GLBudgetEntry.FindSet();

            repeat
                DevAmt += GLBudgetEntry.Amount;
            until GLBudgetEntry.Next() = 0;

        end;
        "Deviation Amount" := DevAmt;

    end;
}