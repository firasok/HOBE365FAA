xmlport 51100 "SKF Payment journal"
{
    Caption = 'SKF Payment journal';
    Direction = Import;
    TextEncoding = UTF8;
    format = VariableText;
    FieldDelimiter = '"';
    FieldSeparator = ';';
    UseRequestPage = true;

    schema
    {
        textelement(root)
        {
            tableelement(Integer; Integer)
            {
                AutoReplace = false;
                AutoSave = false;
                AutoUpdate = false;
                SourceTableView = sorting(Number) WHERE(Number = const(1));
                textelement(RepportDate) { }
                textelement(Fejer) { }
                textelement(repportNo) { }
                textelement(invoiceDate) { }
                textelement(invoiceNo) { }
                textelement(AccountNo) { }
                textelement(descriptionText) { }
                textelement(amountVar)
                {
                    trigger onbeforePassvariable();
                    var
                        decemalVar: Decimal;
                    begin
                        if not evaluate(decemalVar, amountVar) then
                            currXMLport.SKIP;
                    end;
                }

                textelement(feesVar) { }
                textelement(VATVar) { }

                trigger OnAfterInitRecord()
                var

                begin

                end;

                trigger OnBeforeInsertRecord()
                Var
                    lText000: Label 'Invoice No.:';

                begin
                    SkipCount += 1;
                    if SkipCount = 1 then
                        currXMLport.Skip();

                    IF DELCHR(UPPERCASE(VATVar), '<>', ' ') = 'JA' THEN
                        currXMLport.SKIP;
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", JourTemplate);
                    GenJournalLine.SETRANGE("Journal Batch Name", journalBatch);
                    IF GenJournalLine.FINDLAST THEN BEGIN
                        lineNo := GenJournalLine."Line No.";
                    END ELSE
                        lineNo := 0;
                    GenJournalLine.RESET;
                    GenJournalLine.VALIDATE("Journal Template Name", GenJournalBatch."Journal Template Name");
                    GenJournalLine.VALIDATE("Journal Batch Name", GenJournalBatch.Name);
                    lineNo += 10000;
                    GenJournalLine."Line No." := lineNo;
                    GenJournalLine.VALIDATE("Document No.", DocumentNo);
                    if postingDate = 0D then
                        GenJournalLine.VALIDATE("Posting Date", TODAY)
                    else
                        GenJournalLine.VALIDATE("Posting Date", postingDate);
                    GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
                    GenJournalLine.VALIDATE("Account No.", AccountNo);
                    GenJournalLine.VALIDATE(Description, FORMAT(invoiceDate) + ' ' + lText000 + invoiceNo);
                    IF amountVar <> '' THEN
                        EVALUATE(amountDecemal, amountVar);

                    amountDecemal := ((amountDecemal + ((amountDecemal * 25) / 100) * -1));
                    GenJournalLine.VALIDATE(Quantity, 1);
                    GenJournalLine.VALIDATE(Amount, amountDecemal);
                    IF contraAccountType = contraAccountType::Bank THEN
                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"Bank Account"
                    ELSE
                        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
                    GenJournalLine."Bal. Account No." := contraAccountNo;
                    GenJournalLine.INSERT;

                    RepportDate := '';
                    feesVar := '';
                    repportNo := '';
                    invoiceDate := '';
                    invoiceNo := '';
                    AccountNo := '';
                    descriptionText := '';
                    amountVar := '';
                    feesVar := '';
                    VATVar := '';
                    amountDecemal := 0;
                END;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(SKF)
                {
                    field(JourTemplate; JourTemplate)
                    {
                        Caption = 'Jornal Template Name';
                        TableRelation = "Gen. Journal Template";
                    }

                    field(JournalBatch; JournalBatch)
                    {
                        Caption = 'Journal Batch Name';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            generalJournalBatches: Page "General Journal Batches";

                        begin
                            CLEAR(GenJournalBatch);
                            GenJournalBatch.SETRANGE(GenJournalBatch."Journal Template Name", JourTemplate);
                            IF GenJournalBatch.FINDSET THEN BEGIN
                                generalJournalBatches.SETTABLEVIEW(GenJournalBatch);
                                generalJournalBatches.LOOKUPMODE(TRUE);
                                IF generalJournalBatches.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    generalJournalBatches.GETRECORD(GenJournalBatch);
                                    journalBatch := GenJournalBatch.Name;
                                END;
                            END
                        end;

                    }
                    field(contraAccountType; contraAccountType)
                    {
                        Caption = 'Contra Account Type';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var

                        begin

                        end;
                    }
                    field(contraAccountNo; contraAccountNo)
                    {
                        Caption = 'Contra Account No.';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            bankAccountList: Page "Bank Account List";
                            chartOfAccounts: Page "chart Of Accounts";

                        begin
                            IF contraAccountType = contraAccountType::Bank THEN BEGIN
                                bankAccount.RESET;
                                CLEAR(bankAccountList);
                                IF bankAccount.FINDSET THEN BEGIN
                                    bankAccountList.SETTABLEVIEW(bankAccount);
                                    bankAccountList.LOOKUPMODE(TRUE);
                                    IF bankAccountList.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                        bankAccountList.GETRECORD(bankAccount);
                                        contraAccountNo := bankAccount."No.";
                                    END;
                                END;
                            END ELSE
                                IF contraAccountType = contraAccountType::Finans THEN BEGIN
                                    GlAccount.RESET;
                                    CLEAR(chartOfAccounts);
                                    IF GlAccount.FINDSET THEN BEGIN
                                        chartOfAccounts.SETTABLEVIEW(GlAccount);
                                        chartOfAccounts.LOOKUPMODE(TRUE);
                                        IF chartOfAccounts.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                            chartOfAccounts.GETRECORD(GlAccount);
                                            contraAccountNo := GlAccount."No.";
                                            bankNo := bankAccount."No.";
                                        END;
                                    END;
                                END ELSE
                                    ;
                        END;
                    }
                    field(postingDate; postingDate)
                    {
                        Caption = 'posting Date';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var

                        begin

                        end;
                    }
                    field(fileName; fileName)
                    {
                        Caption = 'File Name';
                        ApplicationArea = all;
                        Visible = false;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            lText000: Label 'Upload .csv file';
                            FileManagement: Codeunit "File Management";
                        begin
                            fileName := FileManagement.OpenFileDialog(lText000, fileName, '');
                            currXMLport.FILENAME(fileName);

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
            lText000: Label 'Journal Batch Name  and Posting date cannot be empty';

        begin
            IF (journalBatch = '') OR (postingDate = 0D) THEN
                ERROR(lText000);
            IF GenJournalBatch."No. Series" <> '' THEN BEGIN
                CLEAR(NoSeriesMgt);
                DocumentNo := NoSeriesMgt.TryGetNextNo(GenJournalBatch."No. Series", postingDate);
            END;
        end;
    }

    var

        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        "BankAccount": Record "Bank Account";
        GLAccount: Record "G/L Account";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        JourTemplate: Code[20];
        DocumentNo: Code[15];
        RapportdDte: Text[20];
        rapportNo: Text[20];
        InvoiceDatw: Text[20];
        InvociceNo: Text[20];
        Ammount: Text[50];
        fees: Text[10];
        VatAmmount: Text[10];
        JournalBatch: Code[20];
        FileNam: Text[250];
        lineNo: Integer;
        SkipCount: Integer;
        contraAccountType: Option ,Bank,Finans;
        contraAccountNo: code[20];
        amountDecemal: Decimal;
        postingDate: Date;
        bankNo: Code[20];
}