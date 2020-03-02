pageextension 51200 HBRFixedAssetCard extends "Fixed Asset Card"
{
    layout
    {
        addafter(Maintenance)
        {
            group("Vehicles")
            {
                Caption = 'Vehicle';

                field("HBR Registration No."; "Registration No.")
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }

                field("HBR VIN No."; "VIN No.") { }

                field("HBR Vehicle No."; "HBR Vehicle No.") { }

                field("HBR Leasing No."; "HBR Leasing No.") { }

            }
        }
    }
}