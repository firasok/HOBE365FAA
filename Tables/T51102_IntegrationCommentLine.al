// HBR Integration tabels Extention

table 51102 "Integration Comment Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Comment Line';

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
            OptionMembers = ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Teatervagt,Planorama,Webshop;
            OptionCaption = ' ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Teatervagt,Planorama,Webshop';

        }
        field(30; "Document No."; Text[50])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(35; "Integration Source"; option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = URS,AIA,PLANORAMA,WEBSHOP;
            OptionCaption = 'URS,AIA,Planorama,Webshop';
        }

        field(40; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(50; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }

        field(60; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }

        field(70; "Comment"; Text[100])
        {
            Caption = 'Comment';
            DataClassification = ToBeClassified;
        }

        field(80; "Document Line No."; Integer)
        {
            Caption = 'Line No. 2';
            DataClassification = ToBeClassified;
        }
        field(90; Type; Integer)
        {
            
        }
    }
    keys
    {
        key(PK; "Integration Source", "Document No.", "Line No.", "Document Line No.")
        {
            Clustered = true;
        }
    }

}
