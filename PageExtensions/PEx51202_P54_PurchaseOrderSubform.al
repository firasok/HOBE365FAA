pageextension 51202 HBRPurchaseOrderSubform extends "Purchase Order Subform"
{
    layout
    {
        addafter("Shortcut Dimension 2 Code")
        {
            field("Activity Name"; "Activity Name")
            {
                ApplicationArea = All;
            }
            
            field("Service Order No."; "Service Order No.")
            {
                trigger OnValidate()
                var
                    ServiceItemLine: Record "Service Item Line";
                begin
                    if "Service Order No." <> '' then begin
                        ServiceItemLine.Reset();
                        ServiceItemLine.SetRange("Document Type", ServiceItemLine."Document Type"::Order);
                        ServiceItemLine.SetRange("Document No.", "Service Order No.");
                        if not ServiceItemLine.IsEmpty() then begin
                            ServiceItemLine.FindFirst();
                            "Service Item No." := ServiceItemLine."Service Item No.";
                        end else begin
                            error(ServiceOrderHasNoServiceItem, "Service Order No.");
                        end;
                    end else
                        "Service Item No." := '';
                end;
            }
            field("Service Item No."; "Service Item No.") { }

        }
    }
    var
        ServiceOrderHasNoServiceItem: Label 'Serviceorder %1 has no service items';
}