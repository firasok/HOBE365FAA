codeunit 51101 "HBR Integration Managment"
{
    trigger OnRun();
    begin
    end;

    procedure CreateInvoiceHeader(var pIntegrationHeader: record "integration header";
    var pInvoiceDate: Date): Integer
    var
        integrationSetup: Record "Integration Setup";
        IntegrationHeader: Record "Integration Header";
        customerRec: Record Customer;
        salesHeader: Record "Sales Header";
        ProcessLogManagment: Codeunit "Process Log Managment";
        errorCounter: Integer;
        "Line No.": Integer;
        OurRefrence: Text[100];
        invoiceDate: date;
        Text001: Label '------End :%1------';
    begin
        errorCounter := 0;
        invoiceDate := pInvoiceDate;
        IntegrationHeader := pIntegrationHeader;
        integrationSetup.get(IntegrationHeader."Application Area");
        ourRefrence := DELCHR(IntegrationHeader."Our Reference", '<>', ' ');
        if not customerRec.get(IntegrationHeader."Customer No.") then exit(errorCounter + 1);
        salesHeader.INIT;
        salesHeader."Document Type" := salesHeader."Document Type"::Invoice;
        salesHeader."No." := '';
        salesHeader.INSERT(TRUE);
        salesHeader.VALIDATE(salesHeader."Sell-to Customer No.", customerRec."No.");
        IF IntegrationHeader."Application Area" in [IntegrationHeader."Application Area"::Blindalarm, IntegrationHeader."Application Area"::ABAafgift, IntegrationHeader."Application Area"::UrsFrbMat, IntegrationHeader."Application Area"::AIAUdrykning, IntegrationHeader."Application Area"::Planorama] THEN salesHeader.VALIDATE(salesHeader."Sell-to Customer No.", IntegrationHeader."Customer No.");
        if (ourRefrence <> '') then
            salesHeader."Sell-to Contact" := ourRefrence
        else
            salesHeader.VALIDATE("Sell-to Contact", 'NA');
        salesHeader.VALIDATE(salesHeader."Document Date", InvoiceDate);
        salesHeader.VALIDATE(salesHeader."Posting Date", InvoiceDate);
        if IntegrationHeader."Application Area" <> IntegrationHeader."Application Area"::AIAUdrykning then begin
            if IntegrationHeader."External Invoice No" <> '' then
                salesHeader.VALIDATE(salesHeader."External Document No.", IntegrationHeader."External Invoice No")
            else
                salesHeader.VALIDATE(salesHeader."External Document No.", format(IntegrationHeader."Application Area"));
        end
        else begin
            salesHeader.VALIDATE(salesHeader."External Document No.", format(IntegrationHeader."Application Area"));
        end;
        if IntegrationHeader."Application Area" in [IntegrationHeader."Application Area"::Blindalarm, IntegrationHeader."Application Area"::UrsFrbMat, IntegrationHeader."Application Area"::Planorama] then;
        salesHeader.Modify(true);
        "line No." := InsertCommentLine(IntegrationHeader, SalesHeader, errorCounter);
        errorCounter := errorCounter + InsertInvoiceLine(IntegrationHeader, salesHeader, "Line No.");
        if IntegrationHeader."Application Area" = IntegrationHeader."Application Area"::ABAafgift then begin
            //----Annual Fees Footer (ABAAfgift)------------------
            //ABAFooterComments()
        end;
        exit(errorCounter);
    end;

    procedure InsertInvoiceLine(var pIntegrationHeader: Record "Integration Header";
    var pSalesHeader: record "Sales Header";
    pLineNo: Integer) resultMessage: Integer
    var
        integrationSetup: Record "Integration Setup";
        IntegrationHeader: Record "Integration Header";
        integrationLine: Record "Integration Line";
        salesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";
        unitOfMeasureRec: Record "Unit of Measure";
        customerRec: Record Customer;
        "Line No.": Integer;
        errorCounter: Integer;
        recordsCount: Integer;
        Text001: Label 'Årsafgift ABA anlæg', Comment = 'Comment', MaxLength = 100, Locked = true;
    begin
        salesHeader := pSalesHeader;
        IntegrationHeader := pIntegrationHeader;
        SalesLine.SetRange("Document Type", Salesheader."Document Type");
        SalesLine.SetRange("Document No.", Salesheader."No.");
        if SalesLine.FindLast() then
            "Line No." := SalesLine."Line No."
        else
            "Line No." := 0;
        integrationSetup.get(IntegrationHeader."Application Area");
        integrationLine.reset;
        salesLine.reset;
        integrationLine.SETRANGE(integrationLine."Document No.", IntegrationHeader."No.");
        IF integrationLine.FINDSET THEN recordsCount := integrationLine.count;
        REPEAT
            case IntegrationHeader."Application Area" of
                IntegrationHeader."Application Area"::ABAopret, IntegrationHeader."Application Area"::Blindalarm, IntegrationHeader."Application Area"::AIAUdrykning, IntegrationHeader."Application Area"::UrsFrbMat:
                    begin
                        IF integrationLine."Line Reference" <> '' THEN BEGIN
                            "Line No." := CommentLine(SalesHeader, integrationLine."Line Reference", "Line No.");
                        END;
                    end;
                IntegrationHeader."Application Area"::ABAafgift:
                    begin
                        "Line No." := CommentLine(SalesHeader, DELCHR(Text001 + DelChr(integrationLine."Unit of Measure", '<>', ' ')), "Line No.");
                        "Line No." := CommentLine(SalesHeader, integrationLine."Line Reference", "Line No.");
                    end;
            end;
            "Line No." := "Line No." + 10000;
            salesLine.INIT;
            salesLine."Document Type" := salesHeader."Document Type";
            salesLine."Document No." := salesHeader."No.";
            salesLine."Line No." := "Line No.";
            salesLine.insert(true);
            salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
            salesLine.VALIDATE(salesLine."No.", integrationSetup."G/L Account");
            if integrationLine.Quantity > 0 then
                Salesline.VALIDATE(Quantity, integrationLine.Quantity)
            else
                Salesline.VALIDATE(Quantity, 1);
            Salesline.VALIDATE("Unit Price", integrationLine.Amount);
            case customerRec."Customer Posting Group" of
                'EKSTERN':
                    begin
                        CASE integrationSetup."Application Area" OF
                            integrationSetup."Application Area"::Planorama:
                                BEGIN
                                    IF integrationLine."School Course" THEN BEGIN
                                        salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                                        Salesline.VALIDATE("No.", integrationSetup."G/L Account");
                                    END
                                    ELSE BEGIN
                                        customerRec.TESTFIELD("Gen. Bus. Posting Group");
                                        IF customerRec."Gen. Bus. Posting Group" = integrationSetup."Gen. Bus. Posting Group" THEN begin
                                            salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                                            Salesline.VALIDATE("No.", integrationSetup."G/L Account External")
                                        end
                                        ELSE begin
                                            salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                                            Salesline.VALIDATE("No.", integrationSetup."VAT  G/L Account Ext.");
                                        end;
                                    END;
                                END ELSE BEGIN
                                            salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                                            Salesline.VALIDATE("No.", integrationSetup."G/L Account External");
                                        END;
                        END
                    end;
                'EKSTERN EK':
                    begin
                        salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                        Salesline.VALIDATE("No.", integrationSetup."Owner Entrance Acc.");
                    end;
                'INTERN':
                    begin
                        salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                        Salesline.VALIDATE("No.", integrationSetup."G/L Account");
                    end;
                else begin
                        salesLine.VALIDATE(salesLine.Type, salesLine.Type::"G/L Account");
                        Salesline.VALIDATE("No.", integrationSetup."G/L Account");
                    end;
            end;
            salesLine.Validate("Shortcut Dimension 1 Code", integrationSetup."Global Dimension 1 Code");
            salesLine.Validate("Shortcut Dimension 2 Code", integrationSetup."Global Dimension 2 Code");
            if integrationLine.Description <> '' then
                SalesLine.VALIDATE(Description, integrationLine.Description);
            if integrationLine."Unit of Measure" <> '' then
                Salesline.VALIDATE("Unit of Measure Code", integrationLine."Unit of Measure")
            else
                Salesline.VALIDATE("Unit of Measure Code", 'STK');
            if integrationLine.Quantity <> 0 then
                Salesline.VALIDATE(Quantity, integrationLine.Quantity)
            else
                integrationLine.Quantity := 1;

            Salesline.VALIDATE("Unit Price", integrationLine.Amount);
            Salesline.modify(TRUE);
        UNTIL integrationLine.NEXT = 0;
        exit("Line No.");
    end;

    procedure InsertCommentLine(var pIntegrationHeader: Record "Integration Header";
    var pSalesHeader: Record "Sales Header";
    pErrorCounter: Integer): Integer
    var
        integrationSetup: Record "Integration Setup";
        IntegrationHeader: Record "Integration Header";
        IntegrationCommentLine: record "Integration Comment Line";
        Salesheader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        errorCounter: Integer;
        "Line No.": Integer;
    begin
        errorCounter := pErrorCounter;
        IntegrationHeader := pIntegrationHeader;
        if SalesHeader.get(pSalesHeader."Document Type", pSalesHeader."No.") then;
        IntegrationCommentLine.SETRANGE("Document No.", IntegrationHeader."No.");
        if not IntegrationCommentLine.FindFirst() then begin
            Exit(errorCounter + 1);
        end
        else begin
            SalesLine.SetRange("Document Type", Salesheader."Document Type");
            SalesLine.SetRange("Document No.", Salesheader."No.");
            if SalesLine.FindLast() then
                "Line No." := SalesLine."Line No."
            else
                "Line No." := 0;
        end;
        "line No." := CommentLine(Salesheader, '', "Line No.");
        IF integrationSetup."Header Text" <> '' THEN BEGIN
            "Line No." := CommentLine(Salesheader, integrationSetup."Header Text", "Line No.");
            IF IntegrationHeader."Application Area" <> IntegrationHeader."Application Area"::AIAUdrykning THEN BEGIN
                "Line No." := CommentLine(Salesheader, '', "Line No.");
            END;
        END;
        IF IntegrationCommentLine.FINDSET THEN
            REPEAT
                "Line No." := CommentLine(Salesheader, DELCHR(IntegrationCommentLine.Comment, '<>', ' '), "Line No.");
            UNTIL IntegrationCommentLine.NEXT = 0;
        "Line No." := CommentLine(Salesheader, '', "Line No.");
        exit("Line No.");
    end;

    procedure CommentLine(var pSalesHeader: Record "Sales Header";
    pComment: Text[250];
    pLineNo: Integer): integer
    var
        "Line No.": Integer;
        commentText: Text[250];
        salesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader := pSalesHeader;
        "Line No." := pLineNo;
        commentText := pComment;
        "Line No." := "Line No." + 10000;
        Salesline.INIT;
        Salesline.VALIDATE("Document Type", salesHeader."Document Type");
        Salesline.VALIDATE("Document No.", salesHeader."No.");
        Salesline.VALIDATE("Line No.", "Line No.");
        Salesline.VALIDATE(Description, commentText);
        Salesline.INSERT(TRUE);
        exit("Line No.");
    end;

    procedure IntegSetupFootergComment(pSalesLine: Record "Sales Line";
    "pLineNo.": Integer;
    pApplicationArea: Integer): Integer
    var
        integrationSetup: Record "Integration Setup";
        Salesheader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        appliacationArea: Integer;
        "Line No.": Integer;
    begin
        appliacationArea := pApplicationArea;
        "Line No." := "pLineNo.";
        integrationSetup.get(appliacationArea);
        IF integrationSetup."Footer Text" <> '' THEN BEGIN
            "Line No." := CommentLine(SalesHeader, integrationSetup."Header Text", "Line No.");
        END;
    end;

    procedure checkIntegrationHeader(var pIntegrationHeader: Record "Integration Header"): Integer
    var
        IntegrationHeader: Record "Integration Header";
        integrationSetup: Record "Integration Setup";
        customerRec: Record Customer;
        processLogManagment: Codeunit "Process Log Managment";
        errorCounter: Integer;
        erroBool: Boolean;
        Text000: Label 'Integration Header:%1';
        Text001: Label 'Customer No.:  %1 dose not exist. Integraion Header No.: %2';
        Text002: Label 'Chek application Area %1 on integration Setup. Integraion Header No.: %2 .';
    begin
        IntegrationHeader := pIntegrationHeader;
        erroBool := false;
        if not customerRec.get(IntegrationHeader."Customer No.") then begin
            processLogManagment.InsertProcessLogLine(StrSubstNo(Text001, customerRec."No.", IntegrationHeader."No."), logNo);
            errorCounter += 1;
            erroBool := true;
        end;
        if IntegrationHeader."Integration Source" <> IntegrationHeader."Integration Source"::WEBSHOP then begin
            if not integrationSetup.get(IntegrationHeader."Application Area") then begin
                processLogManagment.InsertProcessLogLine(StrSubstNo(Text002, format(ApplicationArea), IntegrationHeader."No."), logNo);
                errorCounter += 1;
                erroBool := true;
            end;
        end;
        if erroBool then begin
            IntegrationHeader.Status := IntegrationHeader.Status::Error;
            IntegrationHeader.Modify();
        end
        else begin
            if IntegrationHeader.Status <> IntegrationHeader.Status::Inserted then begin
                IntegrationHeader.Status := IntegrationHeader.Status::Inserted;
                IntegrationHeader.Modify();
                errorCounter := errorCounter + checkIntegrationLine(IntegrationHeader, logNo);
            end;
        end;
        exit(errorCounter);
    end;

    procedure checkIntegrationLine(var pIntegrationHeader: record "Integration Header";
    var logNo: Integer): Integer
    var
        customerRec: Record Customer;
        IntegrationHeader: Record "Integration Header";
        integrationLine: Record "Integration Line";
        unitOfMeasureRec: Record "Unit of Measure";
        ItemRec: record Item;
        processLogManagmnent: Codeunit "Process Log Managment";
        errorCounter: Integer;
        erroBool: Boolean;
        Text000: Label 'Unit of Measure field cannot be empty line No. %1.';
        Text001: Label 'Error Unit of Measure  %1 line No.%2.';
        Text002: Label 'Error Item No.  %1 line No.%2. is not exist';
        Text003: Label 'Error Item No.  %1 line No.%2. is Blocked';
    begin
        IntegrationHeader := pIntegrationHeader;
        integrationLine.Reset();
        erroBool := false;
        integrationLine.setrange("Document No.", IntegrationHeader."No.");
        if integrationLine.FindSet() then
            repeat
                case IntegrationHeader."Integration Source" of
                    IntegrationHeader."Integration Source"::AIA, IntegrationHeader."Integration Source"::PLANORAMA, IntegrationHeader."Integration Source"::URS:
                        begin
                            if integrationLine."Unit of Measure" = '' then begin
                                processLogManagmnent.InsertProcessLogLine(StrSubstNo(Text000, integrationLine."Line No."), logNo);
                                erroBool := true;
                            end;
                            if (not unitOfMeasureRec.Get(integrationLine."Unit of Measure")) then begin
                                processLogManagmnent.InsertProcessLogLine(StrSubstNo(Text001, integrationLine."Unit of Measure", integrationLine."Line No."), logNo);
                                erroBool := true;
                            end;
                        end;
                    IntegrationHeader."Integration Source"::WEBSHOP:
                        begin
                            if (not ItemRec.Get(integrationLine."Item No. 2")) then begin
                                processLogManagmnent.InsertProcessLogLine(StrSubstNo(Text002, integrationLine."Item No. 2", integrationLine."Line No."), logNo);
                                erroBool := true;
                            end
                            else begin
                                if itemRec.blocked then begin
                                    processLogManagmnent.InsertProcessLogLine(StrSubstNo(Text003, integrationLine."Item No. 2", integrationLine."Line No."), logNo);
                                    erroBool := true;
                                end;
                            end;
                        end;
                end;
            until integrationLine.next = 0;
        if erroBool then begin
            IntegrationHeader.Status := IntegrationHeader.Status::Error;
            IntegrationHeader.Modify(true);
            errorCounter += 1;
        end
        else begin
            IntegrationHeader.Status := IntegrationHeader.Status::Inserted;
            IntegrationHeader.Modify(true);
            exit(errorCounter);
        end;
    end;

    procedure ABAFooter()
    var
    begin
    end;

    procedure WebshopIntegrationLog(IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
    IntegrationNo: code[20];
    IntegrationNo2: Code[20];
    IntegrationAction: option Create,Update,Delete,FullyInvoiced)
    var
        entryNo: Integer;
        WebshopIntegrationLog: Record "Webshop Integration Log";
    begin
        WebshopIntegrationLog.reset;
        if WebshopIntegrationLog.findlast then
            entryNo := WebshopIntegrationLog."Entry No."
        else
            entryNo := 1;
        WebshopIntegrationLog.reset;
        WebshopIntegrationLog.init;
        entryNo += 1;
        WebshopIntegrationLog."Entry No." := entryNo;
        WebshopIntegrationLog.Insert;
        WebshopIntegrationLog.validate("Integration Table", IntegrationTable);
        WebshopIntegrationLog."Integration No." := IntegrationNo;
        WebshopIntegrationLog."Integration No.2" := IntegrationNo2;
        WebshopIntegrationLog."Integration Action" := IntegrationAction;
        WebshopIntegrationLog.modify;
    end;

    procedure CreateWeborderHeader(var pIntegrationHeader: record "integration header";
    var pInvoiceDate: Date): Integer
    var
        IntegrationHeader: Record "Integration Header";
        customerRec: Record Customer;
        salesHeader: Record "Sales Header";
        ProcessLogManagment: Codeunit "Process Log Managment";
        errorCounter: Integer;
        "Line No.": Integer;
        OurRefrence: Text[100];
        invoiceDate: date;
        Text000: Label 'Error log %1';
    begin
        errorCounter := 0;
        invoiceDate := pInvoiceDate;
        IntegrationHeader := pIntegrationHeader;
        ourRefrence := DELCHR(IntegrationHeader."Our Reference", '<>', ' ');
        customerRec.get(IntegrationHeader."Customer No.");
        salesHeader.INIT;
        salesHeader.SetHideValidationDialog(true);
        salesHeader."Document Type" := salesHeader."Document Type"::Order;
        salesHeader."No." := '';
        salesHeader.INSERT(TRUE);
        salesHeader.VALIDATE(salesHeader."Sell-to Customer No.", customerRec."No.");
        if IntegrationHeader."Contact No." <> '' then
            salesHeader.VALIDATE(salesHeader."Sell-to Contact No.", IntegrationHeader."Contact No.")
        else
            salesHeader.VALIDATE("Sell-to Contact No.", 'NA');
        salesHeader.VALIDATE(salesHeader."Document Date", InvoiceDate);
        salesHeader.VALIDATE(salesHeader."Posting Date", InvoiceDate);
        salesHeader.VALIDATE(salesHeader."Order Date", IntegrationHeader."Date of Creation");
        salesHeader.Validate(salesHeader."External Document No.", IntegrationHeader."No.");
        salesHeader.Modify(true);
        IF DELCHR(IntegrationHeader."Reference Remarks", '<>', ' ') <> '' THEN;
        "line No." := InsertCommentLine(IntegrationHeader, SalesHeader, errorCounter);
        errorCounter := errorCounter + InsertWeborderLine(IntegrationHeader, salesHeader, "Line No.");
        exit(errorCounter);
    end;

    procedure InsertWeborderLine(var pIntegrationHeader: Record "Integration Header";
    var pSalesHeader: record "Sales Header";
    pLineNo: Integer) resultMessage: Integer
    var
        integrationSetup: Record "Integration Setup";
        IntegrationHeader: Record "Integration Header";
        integrationLine: Record "Integration Line";
        salesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";
        unitOfMeasureRec: Record "Unit of Measure";
        customerRec: Record Customer;
        "Line No.": Integer;
        errorCounter: Integer;
        recordsCount: Integer;
        Text001: Label 'Web Order';
    begin
        salesHeader := pSalesHeader;
        IntegrationHeader := pIntegrationHeader;
        SalesLine.SetRange("Document Type", Salesheader."Document Type");
        SalesLine.SetRange("Document No.", Salesheader."No.");
        if SalesLine.FindLast() then
            "Line No." := SalesLine."Line No."
        else
            "Line No." := 0;
        integrationLine.reset;
        salesLine.reset;
        integrationLine.SETRANGE(integrationLine."Document No.", IntegrationHeader."No.");
        IF integrationLine.FINDSET THEN recordsCount := integrationLine.count;
        REPEAT
            IF integrationLine."Line Reference" <> '' THEN BEGIN
                "Line No." := CommentLine(SalesHeader, integrationLine."Line Reference", "Line No.");
            END;
            "Line No." := "Line No." + 10000;
            salesLine.INIT;
            salesLine."Document Type" := salesHeader."Document Type";
            salesLine."Document No." := salesHeader."No.";
            salesLine."Line No." := "Line No.";
            salesLine.insert(true);
            salesLine.VALIDATE(salesLine.Type, salesLine.Type::Item);
            Salesline.VALIDATE(salesLine."No.", integrationLine."Item No. 2");
            Salesline.VALIDATE(Quantity, integrationLine.Quantity);
            Salesline.VALIDATE("Unit Price", integrationLine.Amount);
            salesLine.Validate("Shortcut Dimension 1 Code", integrationSetup."Global Dimension 1 Code");
            salesLine.Validate("Shortcut Dimension 2 Code", integrationSetup."Global Dimension 2 Code");
            SalesLine.VALIDATE(Description, integrationLine.Description);
            Salesline.VALIDATE("Unit of Measure Code", integrationLine."Unit of Measure");
            Salesline.VALIDATE(Quantity, integrationLine.Quantity);
            Salesline.VALIDATE("Unit Price", integrationLine.Amount);
            Salesline.modify(TRUE);
        UNTIL integrationLine.NEXT = 0;
        exit("Line No.");
    end;

    procedure CheckIntegrationInfo(var pIntegrationHeader: Record "Integration Header")
    var
        IntegrationHeader: Record "Integration Header";
        errorCounter: Integer;
        Text000: Label 'Create Integration Invoice Process';
        Text001: Label 'The Job Ended with %1 error.';
        Text002: Label 'The Job Ended with No error';
        Text003: Label '------------End------------';
    begin
        IntegrationHeader := pIntegrationHeader;
        IntegrationHeader.CopyFilters(pIntegrationHeader);
        IntegrationHeader.SetFilter(IntegrationHeader.Status, '%1|%2', IntegrationHeader.Status::Inserted, IntegrationHeader.Status::Error);
        processLogManagment.InsertProcessLog(StrSubstNo(Text000, IntegrationHeader."No."), logNo);
        if IntegrationHeader.FindSet then
            repeat
                errorCounter := errorCounter + checkIntegrationHeader(IntegrationHeader);
            until IntegrationHeader.next = 0;
        if errorCounter > 0 then
            processLogManagment.InsertProcessLogLine(StrSubstNo(Text001, Format(errorCounter)), logNo)
        else
            processLogManagment.InsertProcessLogLine(StrSubstNo(Text002, Format(errorCounter)), logNo);
        processLogManagment.InsertProcessLogLine(Text003, logNo);
    end;

    procedure CheckWebshopInfo(var pIntegrationHeader: Record "Integration Header")
    var
        IntegrationHeader: Record "Integration Header";
        errorCounter: Integer;
        Text000: Label 'Create Weborder Process';
        Text001: Label 'The Job Ended with %1 error.';
        Text002: Label 'The Job Ended with No error';
        Text003: Label '------------End------------';
    begin
        IntegrationHeader := pIntegrationHeader;
        IntegrationHeader.CopyFilters(pIntegrationHeader);
        IntegrationHeader.SetFilter(IntegrationHeader.Status, '%1|%2', IntegrationHeader.Status::Inserted, IntegrationHeader.Status::Error);
        processLogManagment.InsertProcessLog(StrSubstNo(Text000, IntegrationHeader."No."), logNo);
        if IntegrationHeader.FindSet then
            repeat
                errorCounter := errorCounter + checkIntegrationHeader(IntegrationHeader);
            until IntegrationHeader.next = 0;
        if errorCounter > 0 then
            processLogManagment.InsertProcessLogLine(StrSubstNo(Text001, Format(errorCounter)), logNo)
        else
            processLogManagment.InsertProcessLogLine(StrSubstNo(Text002, Format(errorCounter)), logNo);
        processLogManagment.InsertProcessLogLine(Text003, logNo);
    end;

    var
        ProcessLogManagment: Codeunit "Process Log Managment";
        ProcessLog: Record "Process Log Header";
        ProcessLogLine: Record "Process Log Line";
        logNo: Integer;
}
