pageextension 51201 ServiceItemCard extends "Service Item Card"
{
    layout
    {
        addafter(Detail)
        {
            group("Vehicle")
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
                field("Registration Date"; "Registration Date") { }

                field("HBR VIN No."; "VIN No.") { }

                field("HBR Vehicle No."; "HBR Vehicle No.") { }

                field("Vehicle Brand"; "Vehicle Brand") { }
                field("Original Registration Year"; "Original Registration Year") { }

            }
        }
    }

    actions
    {
        addbefore(New)
        {
            action("New Serviceorder")
            {
                Caption = 'New serviceorder';
                ApplicationArea = All;
                Image = NewOrder;

                trigger OnAction()
                var
                    ServiceItem: Record "Service Item";
                    ServiceOrder: Record "Service Header";
                begin
                    ServiceItem.CreateServiceOrder(rec, ServiceOrder);
                    PAGE.Run(Page::"Service Order", ServiceOrder);
                end;
            }

        }
    }
}