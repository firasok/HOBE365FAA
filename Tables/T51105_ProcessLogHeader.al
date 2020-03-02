
table 51105 "Process Log Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Process Log Header';
    LookupPageId = "Process Log Header";

    fields
    {
        field(10; "No."; Integer)
        {
            Caption = 'No.';

        }
        field(20; Date; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(30; "Start Time"; Time)
        {
            Caption = 'Start Time';
            DataClassification = ToBeClassified;
        }
        field(40; "End Time"; Time)
        {
            Caption = 'End Time';
            DataClassification = ToBeClassified;
        }
        field(50; "Log Name"; Text[50])
        {
            Caption = 'Job Name';
            DataClassification = ToBeClassified;
        }
        field(60; "Description"; text[80])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(70; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(80; "Error Message"; Boolean)
        {
            Caption = 'Error Message';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
