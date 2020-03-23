pageextension 51105 HBRGeneralJournal extends "General Journal"
{
    layout
    {

    }

    actions
    {
        addlast("Payro&ll")
        {
            group("User Group")
            {
                action("KMD Payroll")
                {
                    Caption = 'KMD payroll';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = ImportExcel;
                    ToolTip = 'Reading KMD payroll file';
                    RunObject = xmlport "File Integration KMD";

                    trigger OnAction()
                    begin
                    end;
                }
            }
        }

        addlast(processing)
        {
            group("User Group 2")
            {

                action("SKF Paymets")
                {
                    Caption = 'SKF Paymets';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Image = ImportExcel;
                    ToolTip = 'Reading SKF Paymets file';
                    RunObject = xmlport "SKF Payment journal";

                    trigger OnAction()
                    begin
                    end;
                }
            }
        }
    }
}