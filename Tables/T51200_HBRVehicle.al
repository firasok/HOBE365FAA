table 51200 "HBR Vehicle"
//<NCO>
//Table containing master data for HBR vehicles
//</NCO>
{

    DataClassification = ToBeClassified;
    LookupPageId = 51200;
    DrillDownPageId = 51200;
    Caption = 'HBR Vehicle';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            DataClassification = ToBeClassified;
        }
        field(4; "VIN No."; Text[50])
        {
            Caption = 'VIN No.';
            DataClassification = ToBeClassified;
        }
        field(5; "HBR Vehicle No."; Text[50])
        {
            Caption = 'HBR Vehicle No.';
            DataClassification = ToBeClassified;
        }
        field(6; "HBR Leasing No."; Text[50])
        {
            Caption = 'HBR Leasing No.';
            DataClassification = ToBeClassified;
        }

        field(7; "Vehicle Brand"; Text[50])
        {
            Caption = 'Vehicle Brand';
            DataClassification = ToBeClassified;
        }
        field(8; "Original Registration Year"; Integer)
        {
            MinValue = 1900;
            MaxValue = 9999;
            Caption = 'Original Registration Year';
            DataClassification = ToBeClassified;
        }
        field(9; "Primary Function"; Text[50])
        {
            Caption = 'Primary Function';
            DataClassification = ToBeClassified;
        }
        field(10; "Tax"; Boolean)
        {
            Caption = 'Tax';
            DataClassification = ToBeClassified;
        }
        field(11; "Station"; Text[50])
        {
            Caption = 'Station';
            DataClassification = ToBeClassified;

            trigger OnLookup()
            var
                ResponsibilityCenter: Record "Responsibility Center";
            begin
                if page.RunModal(page::"Responsibility Center List", ResponsibilityCenter) = Action::LookupOK then
                    Validate("Station", ResponsibilityCenter.Name);
            end;
        }
        field(12; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,U,P,D,A;
            OptionCaption = ' ,U,P,D,A';
        }
        field(13; "Daily User"; Text[50])
        {
            Caption = 'Daily User';
            DataClassification = ToBeClassified;
        }
        field(14; "Vehicle Function"; Text[50])
        {
            Caption = 'Vehicle Function';
            DataClassification = ToBeClassified;
        }
        field(15; "AED"; Boolean)
        {
            Caption = 'AED';
            DataClassification = ToBeClassified;
        }
        field(16; "Type"; Text[50])
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(17; "Vendor Build No"; Text[50])
        {
            Caption = 'Vendor Build No';
            DataClassification = ToBeClassified;
        }
        field(18; "Class"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Class';
            TableRelation = "HBR Vehicle Class Setup".Description;
            ValidateTableRelation = True;

            trigger OnLookup()
            var
                VehicleClassSetup: Record "HBR Vehicle Class Setup";
            begin
                if page.RunModal(page::"HBR Vehicle Class Setup List", VehicleClassSetup) = Action::LookupOK then
                    Validate("Class", VehicleClassSetup.Description);
            end;
        }

        field(19; "Lifespan"; DateFormula)
        {
            Caption = 'Lifespan';
            DataClassification = ToBeClassified;
            TableRelation = "HBR Vehicle Lifespan Setup".Dateformula;
            ValidateTableRelation = True;

            trigger OnLookup()
            var
                VehicleLifespanSetup: Record "HBR Vehicle Lifespan Setup";
            begin
                if page.RunModal(page::"HBR Vehic. Lifespan Setup List", VehicleLifespanSetup) = Action::LookupOK then
                    Validate("Lifespan", VehicleLifespanSetup.Dateformula);
            end;
        }

        field(20; "Technical Replacement"; Date)
        {
            Caption = 'Technical Replacement';
            Editable = false;
            DataClassification = ToBeClassified;

        }
        field(23; "Remaining Lifespan"; Integer)
        {
            Caption = 'Remaining Lifespan';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(24; "Age"; Integer)
        {
            Caption = 'Age';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(21; "Sales Year"; Integer)
        {
            MinValue = 1900;
            MaxValue = 9999;
            Caption = 'Sales Year';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::D then
                    Error(ErrorStatusNotD);
            end;
        }

        field(22; "Sales Price"; Decimal)
        {
            Caption = 'Sales Price';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Status <> Status::D then
                    Error(ErrorStatusNotD);
            end;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Registration No.", "Registration Date", "VIN No.", "Vehicle Brand", "HBR Vehicle No.") { }
    }

    var
        ErrorVehicleOnServiceItem: Label 'Vehicle %1 cannot be deleted. Registration No. is used on Service Item %2';
        ErrorVehicleOnFixedAsset: Label 'Vehicle %1 cannot be deleted. Registration No. is used on Fixed Asset %2';
        ErrorStatusNotD: Label 'Cannot insert value because status is not D';
        HBRSetup: Record "HBR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            HBRSetup.Get();
            HBRSetup.TESTFIELD("Vehicle No. Series");
            Validate("No.", NoSeriesMgt.GetNextNo(HBRSetup."Vehicle No. Series", 0D, true));
        end;
    end;

    trigger OnModify()
    var
        DateformulaVar: DateFormula;
    begin
        If ("Registration Date" <> 0D) AND (Lifespan <> DateformulaVar) then
            "Technical Replacement" := CalcDate(Lifespan, "Registration Date");
    end;

    trigger OnDelete()
    var
        ServiceItem: Record "Service Item";
        FixedAsset: Record "Fixed Asset";
    begin

        if "Registration No." <> '' then begin
            ServiceItem.SetRange("Registration No.", Rec."Registration No.");
            if not ServiceItem.IsEmpty then begin
                ServiceItem.FindFirst();
                Error(ErrorVehicleOnServiceItem, rec."Registration No.", ServiceItem."No.");
            end;

            FixedAsset.SetRange("Registration No.", Rec."Registration No.");
            if not FixedAsset.IsEmpty then begin
                FixedAsset.FindFirst();
                Error(ErrorVehicleOnFixedAsset, rec."Registration No.", FixedAsset."No.");
            end;
        end;
    end;

    trigger OnRename()
    begin

    end;

    procedure GetRemainingLifespan(var HBRVehicle: Record "HBR Vehicle") RemainingLifespanInt: Integer
    var
        DateformulaVar: DateFormula;
    begin
        if HBRVehicle."Technical Replacement" <> 0D then begin
            RemainingLifespanInt := Date2DMY(HBRVehicle."Technical Replacement", 3) - Date2DMY(WorkDate, 3);
        end;
    end;

    procedure GetAge(var HBRVehicle: Record "HBR Vehicle") AgeInt: Integer
    begin
        if HBRVehicle."Registration Date" <> 0D then
            AgeInt := Date2DMY(WorkDate(), 3) - Date2DMY(HBRVehicle."Registration Date", 3);
    end;

}