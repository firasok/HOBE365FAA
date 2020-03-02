tableextension 51201 HBRServiceItem extends "Service Item"
{
    fields
    {
        field(50000; "Registration No."; Code[10])
        {
            Caption = 'Registration No.';

            trigger OnValidate()
            var
                ServiceItem: Record "Service Item";
                ErrorRegistrationNoIsUsed: Label 'Registration No. %1 cannot be used. Registration No. is used on Service Item %2';
            begin
                if "Registration No." <> '' then begin
                    ServiceItem.SetRange("Registration No.", Rec."Registration No.");
                    ServiceItem.SetFilter("No.", '<>%1', Rec."No.");
                    if not ServiceItem.IsEmpty then begin
                        ServiceItem.FindFirst();
                        Error(ErrorRegistrationNoIsUsed, rec."Registration No.", ServiceItem."No.");
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
        field(50001; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."Registration Date" where("Registration No." = field("Registration No.")));
            Editable = false;
        }
        field(50002; "VIN No."; Text[50])
        {
            Caption = 'VIN No.';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."VIN No." where("Registration No." = field("Registration No.")));
            Editable = false;
        }
        field(50003; "HBR Vehicle No."; Text[50])
        {
            Caption = 'HBR Vehicle No.';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."HBR Vehicle No." where("Registration No." = field("Registration No.")));
            Editable = false;
        }
        field(50004; "Vehicle Brand"; Text[20])
        {
            Caption = 'Vehicle Brand';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."Vehicle Brand" where("Registration No." = field("Registration No.")));
            Editable = false;
        }
        field(50005; "Original Registration Year"; Integer)
        {
            Caption = 'Original Registration Year';
            FieldClass = FlowField;
            CalcFormula = lookup ("HBR Vehicle"."Original Registration Year" where("Registration No." = field("Registration No.")));
            Editable = false;
        }
    }

    procedure CreateServiceOrder(ServiceItem: Record "Service Item"; var ServHeader: Record "Service Header")
    var
        ServLine: Record "Service Item Line";
    begin
        ServHeader.init;
        ServHeader.Validate("No.", '');
        ServHeader.Validate("Document Type", ServHeader."Document Type"::Order);
        ServHeader.Insert(true);
        ServHeader.Validate("Customer No.", ServiceItem."Customer No.");
        ServHeader.Modify();
        if ServHeader.ServLineExists() = false then begin
            ServLine.init;
            ServLine.Validate("Document Type", ServHeader."Document Type");
            ServLine.Validate("Document No.", ServHeader."No.");
            ServLine.Validate("Line No.", 10000);
            ServLine.Validate("Service Item No.", ServiceItem."No.");
            ServLine.Insert(true);
        end;
    end;
}