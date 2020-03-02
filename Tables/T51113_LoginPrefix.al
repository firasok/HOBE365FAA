
table 51113 "Login Prefix"
{
    DataClassification = ToBeClassified;
    Caption = 'Login Prefix';
    LookupPageId = "Login Prefix";

    fields
    {
        field(10; "Code"; Code[4])
        {
            Caption = 'Code';

        }

        field(20; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }            
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}
