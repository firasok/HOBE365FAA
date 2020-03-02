
table 51107 "Integration Setup KMD"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Setup KMD';
    LookupPageId = "Integration Setup KMD";

    fields
    {

        field(10; "Account No. KMD"; Code[20])
        {
            Caption = 'Account No. KMD';
            DataClassification = ToBeClassified;
        }

        field(20; "Account Name KMD"; Text[30])
        {
            Caption = 'Account Name KMD';
        }

        field(30; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            TableRelation = "G/L Account";
            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
            begin
                if GLAccount.get(GLAccount."No.") then
                    Validate("Account Name", GLAccount.Name);
            end;
        }

        field(40; "Account Name"; Text[30])
        {
            Caption = 'Account Name';
            DataClassification = ToBeClassified;
        }

        field(50; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
        }

        field(60; "Global Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
        }

        field(70; "Shortcut Dimension 3 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code';
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
        }

        field(80; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
        }

        field(90; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
        }

        field(100; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }

        field(110; "Account Balance"; Decimal)
        {
            Caption = 'Account Balance';
            FieldClass = FlowField;
            CalcFormula = Sum ("G/L Entry".Amount WHERE("G/L Account No." = field("Account No."), "Posting Date" = FIELD("Date Filter")));
        }

        field(120; "VAT Balance"; Decimal)
        {
            Caption = 'VAT Balance';
            FieldClass = FlowField;
            calcFormula = Sum ("G/L Entry"."VAT Amount" WHERE("G/L Account No." = FIELD("Account No."), "Posting Date" = FIELD("Date Filter")));
        }

    }
    keys
    {
        key(PK; "Account No. KMD")
        {
            Clustered = true;
        }
    }

}
