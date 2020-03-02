page 51200 HBRVehicleList
//<NCO>
// Page to display Table HBR Vehicle in a list.
//</NCO>
{
    PageType = List;
    Caption = 'HBR Vehicles';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "HBR Vehicle";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; "Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Registration Date"; "Registration Date")
                {
                    ApplicationArea = All;
                }
                field("VIN No."; "VIN No.")
                {
                    ApplicationArea = All;
                }
                field("HBR Vehicle No."; "HBR Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field("HBR Leasing No."; "HBR Leasing No.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Brand"; "Vehicle Brand")
                {
                    ApplicationArea = All;
                }
                field("Original Registration Year"; "Original Registration Year")
                {
                    ApplicationArea = All;
                }

                field("Primary Function"; "Primary Function")
                {
                    ApplicationArea = All;
                }
                field("Tax"; "Tax")
                {
                    ApplicationArea = All;
                }
                field("Station"; "Station")
                {
                    ApplicationArea = All;
                }
                field("Status"; "Status")
                {
                    ApplicationArea = All;
                }
                field("Daily User"; "Daily User")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Function"; "Vehicle Function")
                {
                    ApplicationArea = All;
                }
                field("AED"; AED)
                {
                    ApplicationArea = All;
                }
                field("Type"; Type)
                {
                    ApplicationArea = All;
                }
                field("Class"; "Class")
                {
                    ApplicationArea = All;
                }
                field("Lifespan"; "LifeSpan")
                {
                    ApplicationArea = All;
                }
                field("Technical Replacement"; "Technical Replacement")
                {
                    ApplicationArea = All;
                }

                field("Remaining LifeSpan"; "Remaining LifeSpan")
                {
                    ApplicationArea = All;
                }
                field("Age"; "Age")
                {
                    ApplicationArea = All;
                }

                field("Sales Year"; "Sales Year")
                {
                    ApplicationArea = All;
                }

                field("Sales Price"; "Sales Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UpdateFields;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UpdateFields;
    end;

    local procedure UpdateFields()
    var
        VehicleTable: Record "HBR Vehicle";
    begin
        "Remaining Lifespan" := VehicleTable.GetRemainingLifespan(Rec);
        Age := VehicleTable.GetAge(Rec);
    end;

}