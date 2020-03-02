report 51100 "Integration Invoicing"
{
    Caption = 'Integration Invoicing';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integration Header"; "Integration Header")
        {
            DataItemTableView = where(processed = const(false));
            RequestFilterFields = "No.", "Application Area", "Customer No.", Processed;

            trigger OnPreDataItem()
            var
                AppAreaFilter: Text[1024];
                postingDate: date;

            begin
                AppAreaFilter := getfilter("Application Area");
                if StrPos(AppAreaFilter, 'Webshop') > 0 then
                    error(Text004);

                HBRIntManagment.CheckIntegrationInfo("Integration Header");
                Window.OPEN(Text001);
                if postingDate = 0D then
                    PostingDate := Today;
                NoOfRecords := "Integration Header".CountApprox;
            end;

            trigger OnAfterGetRecord()
            Var
            begin
                if "Application Area" = "Application Area"::Webshop then
                    CurrReport.Skip();
                lCounter += 1;
                Window.UPDATE(1, "Integration Header"."No.");
                errorCounter := errorCounter + HBRIntManagment.CreateInvoiceHeader("Integration Header", PostingDate);
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
        Text001: Label 'Invoiceing Debitors: #1####################\';
        Text002: Label 'Integrations : @2@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@';
        Text004: Label 'Webshop is not a valid choice';
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


