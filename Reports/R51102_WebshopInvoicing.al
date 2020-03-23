report 51102 "Webshop Invoicing"
{
    Caption = 'Webshop Invoicing';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integration Header"; "Integration Header")
        {
            DataItemTableView = where(processed = const(false), "Integration Source" = const(WEBSHOP));
            RequestFilterFields = "No.", "Customer No.", "Contact No.";

            trigger OnPreDataItem()
            var
                postingDate: date;

            begin
                HBRIntManagment.CheckWebshopInfo("Integration Header");
                Window.OPEN(Text001);
                if postingDate = 0D then
                    PostingDate := Today;
                NoOfRecords := "Integration Header".CountApprox;

            end;

            trigger OnAfterGetRecord()
            Var
            begin
                if "Integration Header".Status = "Integration Header".Status::Error then
                    CurrReport.Skip();
                    
                lCounter += 1;
                Window.UPDATE(1, "Integration Header"."No.");
                errorCounter := errorCounter + HBRIntManagment.CreateWeborderHeader("Integration Header", PostingDate);
                UpdateIntegrationHeaderStatus("Integration Header");

            end;

            trigger OnPostDataItem()
            var

            begin
                Window.Close();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        ContextSensitiveHelpPage = 'my-feature';
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        HBRIntManagment: Codeunit "HBR Integration Managment";
        PostingDate: Date;
        NoOfRecords: Integer;
        errorCounter: Integer;
        logNo: Integer;
        lCounter: Integer;
        Window: Dialog;
        Text000: Label '%1 Setup missing';
        Text001: Label 'Invoiceing : #1####################\';
        Text002: Label 'Webshop : @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text005: Label 'The Job ended with %1 Error. Se the error log.';

    procedure UpdateIntegrationHeaderStatus(var pIntegrationHeader: Record "Integration Header")
    var
        IntegrationHeader: Record "Integration Header";
    begin
        if IntegrationHeader.get(pIntegrationHeader."Integration Source", pIntegrationHeader."No.") then begin
            if "Integration Header".Status <> "Integration Header".Status::Error then begin
                IntegrationHeader.validate("Date Of Proces", Today);
                IntegrationHeader.validate("User ID", UserId);
                IntegrationHeader.validate(Processed, true);
                IntegrationHeader.validate(status, IntegrationHeader.status::Processed);
                IntegrationHeader.modify(true);
            end;
        end;
    end;

    trigger OnInitReport()
    var
    begin

    end;

}


