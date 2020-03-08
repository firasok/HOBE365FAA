
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
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }

        field(30; "VAT G/L Account"; Code[20])
        {
            Caption = 'VAT G/L Account';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }

        field(40; "G/L Account External"; Code[20])
        {
            Caption = 'G/L Account External';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }

        field(50; "VAT  G/L Account Ext."; Code[20])
        {
            Caption = 'VAT G/L Account Ext.';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }

        field(55; "Owner Entrance Acc."; Code[20])
        {
            Caption = 'Owner Entrance Acc.';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }


        field(60; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value" where("Dimension Code" = FILTER(1));
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
        }

        field(65; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value" where("Dimension Code" = FILTER(2));
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
            TableRelation = "Gen. Business Posting Group";
            DataClassification = ToBeClassified;
        }

        field(120; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
            DataClassification = ToBeClassified;
        }

        field(130; "Int. Cust. Price Grp."; Code[10])
        {
            Caption = 'Cust. Price Grp.';
            TableRelation = "Customer Price Group";
            DataClassification = ToBeClassified;
        }

        field(140; "Ext. Cust. Price Grp."; Code[10])
        {
            Caption = 'EXT. Cust. Price Grp.';
            TableRelation = "Customer Price Group";
            DataClassification = ToBeClassified;
        }

        field(150; "EK Cust. Price Grp."; Code[10])
        {
            Caption = 'EK. Cust. Price Grp.';
            TableRelation = "Customer Price Group";
            DataClassification = ToBeClassified;
        }

        field(160; "Ship to Code"; Boolean)
        {
            Caption = 'Ship to Code';
            TableRelation = "Ship-to Address";
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

        field(190; "Text G/L Acc."; Code[20])
        {
            Caption = 'Text G/L Acc.';
            TableRelation = "G/L Account";
            DataClassification = ToBeClassified;
        }

        field(2000; "Unit Of Measure"; Text[100])
        {
            Caption = 'Text Unit Of Measure';
            TableRelation = "Unit of Measure";
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
