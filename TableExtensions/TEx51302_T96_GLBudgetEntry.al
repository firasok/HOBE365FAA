tableextension 51302 GLBudgetEntryExt extends "G/L Budget Entry"
//<NCO>
//Tableextension of table 96, used for handling budget deviations
//</NCO>
{

    fields
    {
        modify(Amount)
        {
            trigger onaftervalidate()
            var
                HBRSetup: record "HBR Setup";
            begin
                if amount <> xRec.Amount then begin
                    if BudgetName.Name <> "Budget Name" then
                        BudgetName.Get("Budget Name");
                    if BudgetName.Locked then
                        if not HBRSetup.IsBudgetResponsible(UserId) then
                            error(BudgetLockedError);
                end;
                UpdateDeviationEntryYesNo();

            end;
        }
        field(50000; "Budget Deviation Comment"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Deviation Comment';

        }
        field(50001; "Budget New Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget New Value';
            AutoFormatType = 1;
        }
        field(50002; "Budget Deviation"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Deviation';
            AutoFormatType = 1;
            trigger onvalidate()
            begin
                UpdateDeviationEntryYesNo();
            end;
        }
        field(50003; "Budget Deviation Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Budget Deviation Entry';
            Editable = false;
        }

    }


    var
        BudgetName: Record "G/L Budget Name";
        BudgetLockedError: label 'Amount may only be edited by the budget responsible, when budget is locked.';

    trigger oninsert()
    begin
        CheckLocked();

    end;

    trigger Onmodify()
    var
        myInt: Integer;
    begin
        CheckLocked();

    end;

    trigger ondelete()
    begin
        CheckLocked();

    end;

    local procedure CheckLocked()
    var
        GLBudgetName2: record "G/L Budget Name";
        HBRSetup: Record "HBR Setup";

    begin
        if amount = 0 then
            exit;
        IF "Budget Name" = GLBudgetName2.Name THEN
            EXIT;
        IF GLBudgetName2.Name <> "Budget Name" THEN
            GLBudgetName2.GET("Budget Name");
        if not HBRSetup.IsBudgetResponsible("User ID") then
            GLBudgetName2.TESTFIELD(locked, FALSE);

    end;

    local procedure UpdateDeviationEntryYesNo()

    begin
        "Budget Deviation Entry" := ((Amount <> 0) AND ("Budget Deviation" <> 0));
    end;


}