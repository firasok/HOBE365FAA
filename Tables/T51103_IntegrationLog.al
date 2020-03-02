
table 51103 "Integration Log"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Log';
    //LookupPageId = "Integration Log";

    fields
    {

        field(10; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = ,Invoice,"Credit Memo";
            optionCaption = ' ,Invoice,Credit Memo';

        }

        field(20; "Application Area"; Option)
        {
            Caption = 'Application Area';
            OptionMembers =   ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,"AIA-Udrykning",Planorama;
            OptionCaption = ' ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIA-Udrykning,Planorama';
        }

        field(30; "Document No."; Text[50])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }

        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(50; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(60; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}










