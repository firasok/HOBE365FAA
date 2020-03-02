
table 51108 "Integration Data KMD"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Data KMD';
    LookupPageId = "Integration Data KMD";

    fields
    {
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(20; "Posting Extension"; Text[15])
        {
            Caption = 'Posting Extension';
            DataClassification = ToBeClassified;
        }

        field(30; "User No."; Text[15])
        {
            Caption = 'User No.';
            DataClassification = ToBeClassified;
        }

        field(40; "Org. type"; Text[15])
        {
            Caption = 'Org. type';
            DataClassification = ToBeClassified;
        }

        field(50; "Posting Type"; Text[15])
        {
            Caption = 'Posting Type';
            DataClassification = ToBeClassified;
        }

        field(60; "Unit of Measure"; Text[15])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }

        field(70; "Registration Location"; Text[20])
        {
            Caption = 'Registration Location';
            DataClassification = ToBeClassified;
        }
        field(80; "Expedition Line No."; text[15])
        {
            Caption = 'Expedition Line No.';
            DataClassification = ToBeClassified;
        }

        field(90; "Rregistration Date"; text[30])
        {
            Caption = 'Rregister Date';
            DataClassification = ToBeClassified;
        }

        field(100; "Registration Acc. No."; text[20])
        {
            Caption = 'Registration Acc. No.';
            DataClassification = ToBeClassified;
        }
        field(110; Amount; text[15])
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }

        field(120; Sign; text[2])
        {
            Caption = 'Sign';
            DataClassification = ToBeClassified;
        }

        field(130; "Account Type"; text[2])
        {
            Caption = 'Account Type';
            DataClassification = ToBeClassified;
        }

        field(140; "Accounting Year"; text[5])
        {
            Caption = 'Accounting Year';
            DataClassification = ToBeClassified;
        }

        field(150; "Doc. archive Number"; text[20])
        {
            Caption = 'Doc. archive Number';
            DataClassification = ToBeClassified;
        }

        field(160; "Value Date"; text[30])
        {
            Caption = 'Value Date';
            DataClassification = ToBeClassified;
        }

        field(170; "Posting Text"; text[35])
        {
            Caption = 'Posting Text';
            DataClassification = ToBeClassified;
        }

        field(180; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = ToBeClassified;
        }

        field(190; "process Date"; date)
        {
            Caption = 'process Date';
            DataClassification = ToBeClassified;
        }

        field(200; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(210; "Start Pos. Shift"; Text[20])
        {
            Caption = 'Dummy';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }

}
