page 51209 "HBR Activities"
{
    Caption = 'HBR Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HBR Cue";

    layout
    {
        area(content)
        {

            cuegroup("Purchase Approval Follow-up")
            {
                Caption = 'Purchase Approval Follow-up';
                field(OutstandinPurchInvApprov; "Outstanding Purch. Inv. Approv")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Outstanding Purchase Approvals';
                    DrillDownPageID = "Purchase Order List";
                    ToolTip = 'Specifies the number of outstanding purchase invoice approval that are displayed in the Purchase Cue on the Role Center. The documents are filtered by todays date.';

                    trigger OnDrillDown()
                    begin
                        ShowOrders(FieldNo("Outstanding Purch. Inv. Approv"));
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues;
    end;

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;
    end;

    local procedure CalculateCueFieldValues()
    begin
        if FieldActive("Outstanding Purch. Inv. Approv") then
            "Outstanding Purch. Inv. Approv" := CountInvoices(FieldNo("Outstanding Purch. Inv. Approv"));
    end;
}