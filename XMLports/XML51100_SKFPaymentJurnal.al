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

                begin
                    IF DELCHR(UPPERCASE(VATVar), '<>', ' ') = 'JA' THEN
                        currXMLport.SKIP;
                    GenJournalLine.RESET;
                    GenJournalLine.SETRANGE("Journal Template Name", 'KASSE');
                    //GenJournalLine.SETRANGE("Journal Batch Name", 'STANDARD');
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
                    GenJournalLine.VALIDATE(Description, FORMAT(invoiceDate) + ' ' + 'fakt.nr.: ' + invoiceNo);
                    IF amountVar <> '' THEN
                        EVALUATE(amountDecemal, amountVar);

                    amountDecemal := ((amountDecemal + ((amountDecemal * 25) / 100) * -1));
                    GenJournalLine.VALIDATE(Amount, amountDecemal);
                    GenJournalLine.VALIDATE(Quantity, 1);
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

                    field(JournalBatch; JournalBatch)
                    {
                        Caption = 'Journal Batch';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            generalJournalBatches: Page "General Journal Batches";

                        begin
                            CLEAR(GenJournalBatch);
                            //GenJournalBatch.SETRANGE(GenJournalBatch."Journal Template Name", 'GENERELT');
                            GenJournalBatch.SETRANGE(GenJournalBatch."Journal Template Name", 'KASSE');
                            IF GenJournalBatch.FINDSET THEN BEGIN
                                generalJournalBatches.SETTABLEVIEW(GenJournalBatch);
                                generalJournalBatches.LOOKUPMODE(TRUE);
                                IF generalJournalBatches.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                    generalJournalBatches.GETRECORD(GenJournalBatch);
                                    journalBatch := GenJournalBatch.Name;
                                    //journalBatch := 'STANDARD';
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
                        Caption = 'file Name';
                        ApplicationArea = all;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            FileManagement: Codeunit "File Management";
                        begin
                            fileName := FileManagement.OpenFileDialog('Indlæse .csv fil', fileName, '');
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

        begin
            IF (journalBatch = '') OR (postingDate = 0D) THEN
                ERROR('Kladdetypenavn og Bogføringsdate skal være udfyles');
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
        contraAccountType: Option " ",Bank,Finans;
        contraAccountNo: code[20];
        amountDecemal: Decimal;
        postingDate: Date;
        bankNo: Code[20];


}