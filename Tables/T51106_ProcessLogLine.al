
table 51106 "Process Log Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Process Log Detais';
    LookupPageId = "Process Log Lines";

    fields
    {
        field(10; "Log No."; Integer)
        {
            Caption = 'Log No.';
        }

        field(50; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(60; "Description"; text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(70; "Description 2"; text[250])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
        
    }
    keys
    {
        key(PK; "Log No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
