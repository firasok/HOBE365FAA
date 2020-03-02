// HBR Integration tabels Extention

table 51101 "Integration Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Line';

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

        field(41; "Item No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(42; "Item No. 2"; Code[20])
        {
            Caption = 'Item No. 2';
            DataClassification = ToBeClassified;
        }
        field(43; "Item Variant"; Code[10])
        {
            Caption = 'Item Variant';
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

        field(70; "Unit of Measure"; Text[100])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
        }

        field(80; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }

        field(90; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }

        field(100; "Line Reference"; Text[100])
        {
            Caption = 'Line Reference';
            DataClassification = ToBeClassified;
        }

        field(110; "School Course"; Boolean)
        {
            Caption = 'School Course';
            DataClassification = ToBeClassified;
        }

        field(120; "Log Date"; Date)
        {
            Caption = 'Log Date';
            DataClassification = ToBeClassified;
        }

        field(130; "Log time"; Time)
        {
            Caption = 'Log Time ';
            DataClassification = ToBeClassified;
        }

        field(140; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Integration Source", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }


}

