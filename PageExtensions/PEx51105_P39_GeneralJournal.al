pageextension 51105 HBRGeneralJournal extends "General Journal"
{
    layout
    {

    }

    actions
    {
        addafter("Payro&ll")
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
    }
}