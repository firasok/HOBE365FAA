page 51153 "HBR Integrations"
{
    Caption = 'HBR Integrations';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HBR Cue";

    layout
    {
        area(content)
        {

            cuegroup("Integrations Process")
            {
                field("Outstanding Int. Documents"; "Outstanding Int. Documents")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Outstanding Integrations Documents';
                    DrillDownPageID = IntegrationInvoicingOverview;
                    LookupPageId = IntegrationInvoicingOverview;
                    ToolTip = 'Specifies the number of outstanding Integration Documents to process';

                    trigger OnDrillDown()
                    begin
                        ShowIntegrationoverview(FieldNo("Outstanding Int. Documents"));
                        
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