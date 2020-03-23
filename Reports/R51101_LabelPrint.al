report 51101 "Print Label"
{
    Caption = 'Label Print';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
    }
    requestpage
    {
        SaveValues = true;
        ContextSensitiveHelpPage = 'my-feature';

        layout
        {
            area(content)
            {
                group("Label Information")
                {
                    Caption = 'Label Information';

                    group("Item")
                    {
                        Caption = 'Item';

                        field(ItemNo; ItemNo)
                        {
                            caption = 'Item No.';
                            TableRelation = item;

                            trigger OnValidate()
                            begin
                                TestItemNo(ItemNo);
                                VariantCode := '';
                                SerieNummer := '';
                                LotNummer := '';
                                noOfLabels := 0;
                                ExpireDate := 0D;
                            end;
                        }

                        field(VariantCode; VariantCode)
                        {
                            caption = 'Variant Code';
                            TableRelation = "Item Variant";
                            Editable = not AllVarients;

                            trigger OnLookup(var Text: Text): Boolean
                            var
                                ItemVariant: Record "Item Variant";
                            begin
                                TestItemNo(ItemNo);
                                ItemVariant.FILTERGROUP(2);
                                ItemVariant.SETRANGE("Item No.", ItemNo);
                                ItemVariant.FILTERGROUP(0);
                                IF Page.RUNMODAL(Page::"Item Variants", ItemVariant) = ACTION::LookupOK THEN
                                    VariantCode := ItemVariant.Code;
                            end;
                        }

                        field(AllVarients; AllVarients)
                        {
                            Caption = 'Number of labels';                       

                            trigger OnValidate()
                            begin
                            end;
                        }
                        field(noOfLabels; noOfLabels)
                        {
                            Caption = 'Number of labels';
                            BlankZero = true;
                            Editable = not AllVarients;


                            trigger OnValidate()
                            begin
                                
                            end;
                        }
                        field(Printer; Printer)
                        {
                            Caption = 'Printer';

                            trigger OnValidate()
                            begin
                            end;
                        }
                    }
                }
            }
        }
        actions
        {
        }
    }
    procedure GetItem(pItemNo: code[20]) lItemNo: Code[20];
    var
    begin
        lItemNo := pItemNo;
        if pItemNo = itemRec."No." then exit;
        itemRec.get(itemNo)
    end;

    procedure TestItemNo(pItemNo: code[20]) lItemNo: Code[20];
    var
        Text000: label 'Item No. is empty.';
        Text001: label 'Item No. %1 dose not exist.';
    begin
        lItemNo := pItemNo;
        if pItemNo = '' then Error(Text000);
        IF NOT ItemRec.GET(ItemNo) THEN ERROR(StrSubstNo(Text001, lItemNo));
    end;

    trigger OnInitReport()
    begin
    end;

    trigger OnPreReport()
    var
    begin
        LabelPrinterManagment.LabelInitializer();
    end;

    trigger OnPostReport()
    var
    begin
        if not ItemRec.get(ItemNo) then exit;
        LabelPrinterManagment.LabelItemBarcode(ItemRec."No.", ItemRec.Description, VariantCode, noOfLabels, Printer,AllVarients);
    end;

    var
        ItemRec: Record Item;
        SerialNoInfo: Record "Serial No. Information";
        LotNoInfo: Record "Lot No. Information";
        LabelPrinterManagment: Codeunit "Label Printer Managment";
        ItemNo: Code[20];
        VariantCode: Code[20];
        SerieNummer: Code[20];
        LotNummer: Code[20];
        noOfLabels: Integer;
        labelCount: Integer;
        ExpireDate: Date;
        AllVarients:Boolean;
        Printer: Option ,SVNAVLA3,SVNAVLA4,SVNAVLA6,SVNAVLA9,SVNAVLA10,SVNAVLA11,SVNAVLA12;
}
