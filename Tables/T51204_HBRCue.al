table 51204 "HBR Cue"
{
    Caption = 'HBR Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(2; "Outstanding Purch. Inv. Approv"; Integer)
        {
            Caption = 'Outstanding Purch. Inv. Approv';
            Editable = false;
            FieldClass = FlowField;
        }

        field(3; "Outstanding Int. Documents"; Integer)
        {
            Caption = 'Outstanding Int. Documents';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count ("Integration Header" WHERE(Processed = const(false), Status = const(Inserted)));

        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure CountInvoices(FieldNumber: Integer): Integer
    var
        CountPurchInvoices: Query "Count Purchase Invoices";
        Result: Integer;
    begin
        case FieldNumber of
            FieldNo("Outstanding Purch. Inv. Approv"):
                begin
                    CountPurchInvoices.SetRange(Status, CountPurchInvoices.Status::"Pending Approval");
                end;
        end;
        CountPurchInvoices.Open;
        CountPurchInvoices.Read;
        Result := CountPurchInvoices.Count_Invoices;

        exit(Result);
    end;

    procedure ShowOrders(FieldNumber: Integer)
    var
        PurchHeader: Record "Purchase Header";
    begin
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Invoice);
        case FieldNumber of
            FieldNo("Outstanding Purch. Inv. Approv"):
                begin
                    PurchHeader.SetRange(Status, PurchHeader.Status::"Pending Approval");
                end;
        end;
        PAGE.Run(PAGE::"Purchase Invoices", PurchHeader);
    end;


    procedure ShowIntegrationoverview(FieldNumber: Integer)
    var
        IntegrationSetup: Record "Integration Setup";
    begin
        PAGE.Run(PAGE::IntegrationInvoicingOverview, IntegrationSetup);
    end;
}