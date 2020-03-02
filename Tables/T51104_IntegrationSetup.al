
table 51104 "Integration Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Setup';
    LookupPageId = "Integration Setup";

    fields
    {

        field(10; "Application Area"; Option)
        {
            Caption = 'Application Area';
            OptionMembers = " ",ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Planorama,Webshop;
            OptionCaption = ' ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Planorama,Webshop';
        }

        field(20; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            DataClassification = ToBeClassified;
        }

        field(30; "VAT G/L Account"; Code[20])
        {
            Caption = 'VAT G/L Account';
            DataClassification = ToBeClassified;
        }

        field(40; "G/L Account External"; Code[20])
        {
            Caption = 'G/L Account External';
            DataClassification = ToBeClassified;
        }

        field(50; "VAT  G/L Account Ext."; Code[20])
        {
            Caption = 'VAT G/L Account Ext.';
            DataClassification = ToBeClassified;
        }

        field(55; "Owner Entrance Acc."; Code[20])
        {
            Caption = 'Owner Entrance Acc.';
            DataClassification = ToBeClassified;
        }


        field(60; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
        }

        field(65; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
        }

        field(70; "Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(80; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = ToBeClassified;
        }

        field(90; "Quantity to invoice"; Integer)
        {
            Caption = 'Quantity to invoice';
            FieldClass = FlowField;
            BlankZero = true;
            CalcFormula = Count ("Integration Header" WHERE("Application Area" = FIELD("Application Area"), Processed = const(false), Status = const(Inserted)));
        }

        field(100; "Amount to invoice"; Decimal)
        {
            Caption = 'Amount to invoice';
            FieldClass = FlowField;
            BlankZero = true;
            CalcFormula = Sum ("Integration Header".Amount WHERE("Application Area" = FIELD("Application Area"), Processed = CONST(false), Status = const(Inserted)));

        }

        field(101; "Error"; Integer)
        {
            Caption = 'Processed with Error';
            FieldClass = FlowField;
            BlankZero = true;
            CalcFormula = Count ("Integration Header" WHERE("Application Area" = FIELD("Application Area"), Processed = const(false), Status = const(Error)));

        }

        field(110; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
        }

        field(120; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
        }

        field(130; "Int. Cust. Price Grp."; Code[10])
        {
            Caption = 'INT. Cust. Price Grp.';
            DataClassification = ToBeClassified;
        }

        field(140; "Ext. Cust. Price Grp."; Code[10])
        {
            Caption = 'EXT. Cust. Price Grp.';
            DataClassification = ToBeClassified;
        }

        field(150; "EK Cust. Price Grp."; Code[10])
        {
            Caption = 'EK. Cust. Price Grp.';
            DataClassification = ToBeClassified;
        }

        field(160; "Ship to Code"; Boolean)
        {
            Caption = 'Ship to Code';
            DataClassification = ToBeClassified;
        }

        field(170; "Header Text"; Text[100])
        {
            Caption = 'Header Text';
            DataClassification = ToBeClassified;
        }

        field(180; "Footer Text"; Text[100])
        {
            Caption = 'Footer Text';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Application Area")
        {
            Clustered = true;
        }
    }

}
