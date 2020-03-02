table 51203 "HBR Vehicle Lifespan Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'HBR Vehicle Lifespan Setup';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }

        field(3; Dateformula; DateFormula)
        {
            DataClassification = ToBeClassified;
            Caption = 'Dateformula';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin

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

}