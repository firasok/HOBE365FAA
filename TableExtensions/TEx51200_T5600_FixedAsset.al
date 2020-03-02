tableextension 51200 HBRFixedAsset extends "Fixed Asset"
{
    fields
    {
        field(50000; "Registration No."; Code[10])
        {
            Caption = 'Registration No.';

            trigger OnValidate()
            var
                FixedAsset: Record "Fixed Asset";
                ErrorRegistrationNoIsUsed: Label 'Registration No. %1 cannot be used. Registration No. is used on Fixed Asset %2';
            begin
                if "Registration No." <> '' then begin
                    FixedAsset.SetRange("Registration No.", Rec."Registration No.");
                    FixedAsset.SetFilter("No.", '<>%1', Rec."No.");
                    if not FixedAsset.IsEmpty then begin
                        FixedAsset.FindFirst();
                        Error(ErrorRegistrationNoIsUsed, rec."Registration No.", FixedAsset."No.");
                    end;
                end;
            end;

            trigger OnLookup()
            var
                HBRVehicle: Record "HBR Vehicle";
            begin
                if page.RunModal(page::HBRVehicleList, HBRVehicle) = Action::LookupOK then
                    Validate("Registration No.", HBRVehicle."Registration No.");
            end;
        }

        field(50001; "HBR Leasing No."; Text[50])
        {
            Caption = 'HBR Leasing No.';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."HBR Leasing No." where ("Registration No." = field ("Registration No.")));
            Editable = false;
        }
        field(50002; "VIN No."; Text[50])
        {
            Caption = 'VIN No.';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."VIN No." where ("Registration No." = field ("Registration No.")));
            Editable = false;
        }
        field(50003; "HBR Vehicle No."; Text[50])
        {
            Caption = 'HBR Vehicle No.';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."HBR Vehicle No." where ("Registration No." = field ("Registration No.")));
            Editable = false;
        }

    }
}