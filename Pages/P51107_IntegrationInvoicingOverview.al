
page 51107 "IntegrationInvoicingOverview"
{
    Caption = 'Integration Invoicing Over view';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Setup";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application Area"; "Application Area")
                {
                    ApplicationArea = all;
                }
                field("Quantity to invoice"; "Quantity to invoice")
                {
                    ApplicationArea = all;
                }
                field("Amount to invoice"; "Amount to invoice")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("I&nvoiceing Detales")
            {
                Caption = 'I&nvoiceing Detales';
                Image = GetLines;
                RunObject = Page "Integration Overview";
                RunPageLink = "Application Area" = Field("Application Area"), Processed = Const(false);
            }

            
        }
        area(Processing)
        {
            action("In&voiceing")
            {
                Caption = 'In&voiceing';
                Image = Invoice;
                RunObject = report "Integration Invoicing";

                trigger OnAction()
                begin
                    CurrPage.Update(true);
                end;

            }

        }
    }

    var
}



