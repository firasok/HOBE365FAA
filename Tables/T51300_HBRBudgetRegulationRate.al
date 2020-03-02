table 51300 "HBR Budget Regulation Rate"
//<NCO>
// Table used for Budget Regulation rates
//</NCO>
{
    DataClassification = ToBeClassified;
    Caption = 'HBR Budget Regulation Rate';

    fields
    {
        field(1; Year; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Year';
            MinValue = 2000;
            MaxValue = 2999;
            NotBlank = true;

        }
        field(2; "Budget Regulation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","P","L","PL";
            Caption = 'Budget Regulation Type';
            OptionCaption = ' ,P,L,PL';
            NotBlank = true;
        }
        field(3; Rate; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rate';
            NotBlank = true;
            DecimalPlaces = 4 : 4;
            MinValue = 0.5;
            MaxValue = 1.5;
        }
    }

    keys
    {
        key(PK; Year, "Budget Regulation Type")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        TestField(Year);
        TestField(Rate);

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetRegulationRate(AccountRegulationType: Integer; FromYear: Integer; ToYear: Integer): Decimal;
    var
        BudgetRegulationRate: Record 51300;
        RateFromYear: Integer;
        RateToYear: Integer;
        RegulationRate: Decimal;
        YearCounter: Integer;
        DoInverse: Boolean;

    begin
        if FromYear = ToYear then
            exit(1);
        if FromYear < ToYear then begin
            RateFromYear := FromYear;
            RateToYear := ToYear;
            DoInverse := false;
        end else begin
            RateFromYear := ToYear;
            RateToYear := FromYear;
            DoInverse := true;
        END;
        RegulationRate := 1;
        for YearCounter := (RateFromYear + 1) to RateToYear do begin
            if BudgetRegulationRate.get(YearCounter, AccountRegulationType) then
                RegulationRate := RegulationRate * BudgetRegulationRate.Rate;
        END;
        if DoInverse then
            RegulationRate := 1 / RegulationRate;
        exit(RegulationRate);

    end;

    procedure GetRegulationRates(FromYear: Integer; ToYear: Integer; VAR pRate: Decimal; VAR lRate: Decimal; VAR plRate: Decimal)
    begin
        pRate := GetRegulationRate(Rec."Budget Regulation Type"::P, FromYear, toyear);
        lRate := GetRegulationRate(Rec."Budget Regulation Type"::L, FromYear, ToYear);
        plRate := GetRegulationRate(rec."Budget Regulation Type"::PL, FromYear, ToYear);
    end;
}