xmlport 51101 "File Integration KMD"
{
    Caption = 'File Integration KMD';
    Direction = Import;
    TextEncoding = WINDOWS;
    format = FixedText;
    UseRequestPage = true;

    schema
    {
        textelement(root)
        {
            tableelement(IntegrationDataKMD; "Integration Data KMD")
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                SourceTableView = sorting("Line No.");

                fieldelement(LineNo; IntegrationDataKMD."Line No.")
                {
                    Width = 0;
                }

                fieldelement(PostingExtension; IntegrationDataKMD."Posting Extension")
                {
                    Width = 3;
                }

                fieldelement(UserNo; IntegrationDataKMD."User No.")

                {
                    Width = 3;
                }

                fieldelement(Orgtype; IntegrationDataKMD."Org. type")
                {
                    Width = 2;
                }

                fieldelement(PostingType; IntegrationDataKMD."Posting Type")
                {
                    Width = 3;
                }

                fieldelement(Dummy; IntegrationDataKMD."Start Pos. Shift")
                {
                    //Dummy position shift
                    Width = 10;
                }

                fieldelement(UnitOfMeasure; IntegrationDataKMD."Unit of Measure")
                {
                    Width = 5;
                }

                fieldelement(RegistrationLocation; IntegrationDataKMD."Registration Location")
                {
                    Width = 5;
                }

                fieldelement(Dummy; IntegrationDataKMD."Start Pos. Shift")
                {
                    //Dummy position shift
                    Width = 3;
                }

                fieldelement(ExpeditionLineNo; IntegrationDataKMD."Expedition Line No.")
                {
                    Width = 4;
                }

                fieldelement(RregistrationDate; IntegrationDataKMD."Rregistration Date")
                {
                    Width = 8;
                }

                fieldelement(RegistrationAccNo; IntegrationDataKMD."Registration Acc. No.")
                {
                    Width = 10;
                }


                fieldelement(Amount; IntegrationDataKMD.Amount)
                {
                    width = 12;
                }

                fieldelement(Sign; IntegrationDataKMD.Sign)
                {
                    width = 1;
                }

                fieldelement(DebetCredit; IntegrationDataKMD."Account Type")
                {
                    width = 1;
                }

                fieldelement(AcountingYear; IntegrationDataKMD."Accounting Year")
                {
                    width = 4;
                }

                fieldelement(Dummy; IntegrationDataKMD."Start Pos. Shift")
                {
                    //Dummy position shift
                    Width = 8;
                }

                fieldelement(DocArchiveNumber; IntegrationDataKMD."Doc. Archive Number")
                {
                    Width = 10;
                }

                fieldelement(Dummy; IntegrationDataKMD."Start Pos. Shift")
                {
                    //Dummy position shift
                    Width = 20;
                }

                fieldelement(ValueDate; IntegrationDataKMD."Value Date")
                {
                    Width = 8;
                }

                fieldelement(Dummy; IntegrationDataKMD."Start Pos. Shift")
                {
                    //Dummy position shift
                    Width = 64;
                }

                fieldelement(PostingText; IntegrationDataKMD."Posting Text")
                {
                    width = 35;
                }

                trigger OnAfterInsertRecord()
                var
                begin
                    IntegrationDataKMD.INSERT;

                end;

                trigger OnBeforeInsertRecord()
                var

                begin
                    LineNo += 1000;
                    IntegrationDataKMD."Line No." := LineNo;

                end;

                trigger OnBeforeModifyRecord()
                begin

                end;


            }
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {

                group(KMD)
                {
                    caption = 'KMD';

                    field(JourTemplate; JourTemplate)
                    {
                        Caption = 'Jornal Template Name';
                        TableRelation = "Gen. Journal Template";
                    }
                    field(JournalName; JournalName)
                    {
                        Caption = 'Jornal Name';

                        TableRelation = "Gen. Journal Batch";
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            GenJournalBatch: Record "Gen. Journal Batch";
                        begin
                            GenJournalBatch.SETRANGE("Journal Template Name", JourTemplate);
                            if GenJournalBatch.findset then begin
                                IF Page.RUNMODAL(Page::"General Journal Batches", GenJournalBatch) = ACTION::LookupOK THEN
                                    JournalName := GenJournalBatch.Name;
                            end;
                        end;
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

                }
            }
        }
        trigger OnClosePage()
        var

        begin
        end;
    }

    trigger OnPreXmlPort()
    begin
        fileName := GetFileName();
        currXMLport.FILENAME(FileName);
        IF IntegrationDataKMD.FINDLAST THEN
            "Line No." := IntegrationDataKMD."Line No."
        ELSE
            "Line No." := 0;
    end;

    trigger OnPostXmlPort()
    begin
        InsertJournalLines;
        IntegrationDataKMD.DeleteAll();
    end;


    procedure GetFileName(): Text[250]
    var
        lFileName: Text[250];
    begin
        lFileName := '';
        Exit(FileName);
    end;

    procedure InsertJournalLines()
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        GLAccount: Record "G/L Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        integrationDataKMD: Record "Integration Data KMD";
        integrationSetupKMD: Record "Integration Setup KMD";
        NameValueBuffer: Record "Name/Value Buffer";
        FileManagement: Codeunit "File Management";

        Window: Dialog;
        postingDate: Date;
        NoSeries: Code[20];
        documentNo: Code[20];
        amountStr: Text[30];
        FilesFolderPath: Text[250];

        lineNo: Integer;
        yyyy: Integer;
        mm: Integer;
        dd: Integer;
        RecNo: Integer;
        TotalRecNo: Integer;
        lText001: Label 'Type Journal Name';
        lText002: Label 'Insert Records : @1@@@@@@@@@@@@@@@@@@@@@@@@@\';
        lText003: Label 'Nor a valid account, Account No. %1';
        lText004: Label 'Årstal in Posting date is not a numeric value';
        lText005: Label 'Month in is not a numeric value';
        lText006: Label 'Day in is not a numeric value';

    begin

        IF NOT GenJournalBatch.GET(JourTemplate, JournalName) THEN
            ERROR(lText001);
        lineNo := 0;
        NoSeries := GenJournalBatch."No. Series";
        documentNo := NoSeriesMgt.GetNextNo(NoSeries, WORKDATE, TRUE);
        Window.OPEN(lText002);
        Window.UPDATE(1, 0);

        GenJournalLine.SetRange("Journal Template Name", JourTemplate);
        GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
        if GenJournalLine.FindLast() then
            lineNo := GenJournalLine."Line No."
        else
            lineNo := 0;

        integrationDataKMD.SETRANGE(processed, FALSE);
        IF integrationDataKMD.FINDSET THEN
            TotalRecNo := integrationDataKMD.CountApprox;
        REPEAT
            GenJournalLine.INIT;
            GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
            lineNo := lineNo + 10000;
            GenJournalLine."Line No." := lineNo;
            GenJournalLine.VALIDATE("Document No.", documentNo);
            GenJournalLine.VALIDATE("Account Type", GenJournalLine."Account Type"::"G/L Account");
            IF NOT integrationSetupKMD.GET(integrationDataKMD."Registration Acc. No.") THEN
                ERROR(lText003, integrationDataKMD."Registration Acc. No.");
            IF NOT EVALUATE(yyyy, COPYSTR(integrationDataKMD."Rregistration Date", 1, 4)) THEN BEGIN
                ERROR(lText004);
            END;
            IF NOT EVALUATE(mm, COPYSTR(integrationDataKMD."Rregistration Date", 5, 2)) THEN BEGIN
                ERROR(lText005);
            END;
            IF NOT EVALUATE(dd, COPYSTR(integrationDataKMD."Rregistration Date", 7, 2)) THEN BEGIN
                ERROR(lText006);
            END;
            postingDate := DMY2DATE(dd, mm, yyyy);
            GenJournalLine.VALIDATE("Posting Date", postingDate);
            GenJournalLine.VALIDATE("Account No.", integrationSetupKMD."Account No.");
            GenJournalLine.VALIDATE("Shortcut Dimension 1 Code", integrationSetupKMD."Global Dimension 1 Code");
            GenJournalLine.VALIDATE("Shortcut Dimension 2 Code", integrationSetupKMD."Global Dimension 2 Code");
            GenJournalLine.VALIDATE(Comment, integrationSetupKMD."Account No. KMD");
            GenJournalLine.VALIDATE(Quantity, 1);
            amountStr := DELCHR(integrationDataKMD.Amount, '<', '0');
            IF UPPERCASE(DELCHR(integrationDataKMD."Account Type", '<>', ' ')) = 'K' THEN BEGIN
                EVALUATE(GenJournalLine.Amount, (amountStr));
                GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount / 100 * -1);
            END ELSE BEGIN
                EVALUATE(GenJournalLine.Amount, (amountStr));
                GenJournalLine.VALIDATE(Amount, GenJournalLine.Amount / 100);
            END;
            GenJournalLine.Description := integrationDataKMD."Posting Text";
            GenJournalLine.INSERT;
            integrationDataKMD.processed := TRUE;
            integrationDataKMD."process Date" := TODAY;
            integrationDataKMD."User ID" := USERID;
            integrationDataKMD.MODIFY;
            RecNo := RecNo + 1;
            Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
        UNTIL integrationDataKMD.NEXT = 0;
    end;

    var
        fileName: Text[250];
        JourTemplate: Code[20];
        JournalName: code[20];
        "Line No.": Integer;
        LineNo: integer;
}