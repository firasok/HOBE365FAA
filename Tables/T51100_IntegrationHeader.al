table 51100 "Integration Header"
{
    DataClassification = ToBeClassified;
    Caption = 'Integration Header';
    LookupPageId = "Integration Header";

    fields
    {
        field(10; "No."; Text[50])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }

        field(20; "Application Area"; Option)
        {
            Caption = 'Application Area';
            OptionMembers = " ",ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Planorama,Webshop;
            OptionCaption = ' ,ABAafgift,ABAopret,Blindalarm,UrsFrbMat,AIAUdrykning,Planorama,Webshop';
        }

        field(30; "Document Type"; Option)
        {
            OptionMembers = " ",Invoice,"Kredit Memo";
            optionCaption = ' ,Invoice,Kredit Memo';
        }

        field(35; "Integration Source"; option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = URS,AIA,PLANORAMA,WEBSHOP;
            OptionCaption = 'URS,AIA,Planorama,Webshop';
        }

        field(40; "Customer No."; code[20])
        {
            Caption = 'Customer No.';

            TableRelation = Customer;
            ValidateTableRelation = false;
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(50; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }

        field(60; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = ToBeClassified;
    
        }

        field(70; "Address"; Text[100])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }

        field(80; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }

        field(81; "Contact No."; Code[20])
        {
            Caption = 'Contact No.';
            DataClassification = ToBeClassified;
        }

        field(82; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            DataClassification = ToBeClassified;
        }

        field(90; "Your Reference"; Text[100])
        {
            Caption = 'Your Reference';
            DataClassification = ToBeClassified;
        }

        field(100; "Our Reference"; Text[100])
        {
            Caption = 'Our Reference';
            DataClassification = ToBeClassified;
        }

        field(110; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }

        field(120; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = ToBeClassified;
        }

        field(130; "External Invoice No"; Code[20])
        {
            Caption = 'External Invoice No';
            DataClassification = ToBeClassified;
        }

        field(140; Description; Code[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(150; "Reference Remarks"; Text[35])
        {

            Caption = 'Reference Remarks';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(160; "Date of Creation"; Date)
        {
            Caption = 'Date of Creation';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(170; "Time of Creation"; Time)
        {
            Caption = 'Time of Creation';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(180; "Processed"; Boolean)
        {
            Caption = 'Processed';
            DataClassification = ToBeClassified;
        }

        field(190; "Date Of Proces"; Date)
        {
            Caption = 'Date Of Proces';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(200; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            Editable = true;
        }

        field(210; Corrected; Boolean)
        {
            Caption = 'Corrected';
            DataClassification = ToBeClassified;
        }

        field(220; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Inserted,Processed,Error;
            OptionCaption = 'Inserted,Processed,Error';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(230; "Sell-to-Contact No"; Code[20])
        {
            Caption = 'Sell-to-Contact No';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Integration Source", "No.")
        {
            Clustered = true;
        }
        key("Aplication Area"; "Date of Creation")
        {
            Unique = false;
        }
    }

    var
        IntLineRec: Record "Integration Line";
        IntCommLineRec: Record "Integration Comment Line";

    trigger OnModify()
    var
        CustomerRec: Record Customer;

    begin
        if xRec."Customer No." <> rec."Customer No." then begin
            If CustomerRec.get(Rec."Customer No.") then begin
                rec.Corrected := true;
                rec.Status := Rec.Status::Inserted;
                rec.Name := CustomerRec.Name;
                Modify;
            end;
        end;
    end;

    trigger OnDelete()
    begin
        IntLineRec.Reset();
        IntLineRec.setrange("Document No.", "No.");
        IntLineRec.SetRange("Integration Source", "Integration Source");
        if IntLineRec.FindSet() then
            IntLineRec.DeleteAll();

        IntcommLineRec.Reset();
        IntcommLineRec.setrange("Document No.", "No.");
        IntLineRec.SetRange("Integration Source", "Integration Source");
        if IntcommLineRec.FindSet() then
            IntcommLineRec.DeleteAll();
    end;
}

