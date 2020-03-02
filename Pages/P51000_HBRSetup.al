page 51000 "HBR Setup"
//<NCO>
// Page to display HBR Setup
//</NCO>
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "HBR Setup";

    layout
    {
        area(Content)
        {
            group(Budget)
            {
                field("Budget Responsible"; "Budget Responsible")
                {
                    ApplicationArea = All;

                }
            }
            group("Vehicle Setup")
            {
                Caption = 'Vehicle Setup';
                field("Vehicle No. Series"; "Vehicle No. Series")
                {
                    ApplicationArea = All;
                }
            }

            group("Printer Setup")
            {
                Caption = 'Printer Setup';
                field("File Name"; "File Name")
                {
                    ApplicationArea = All;
                }
                field("Label Printer 1"; "Label Printer 1")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 2"; "Label Printer 2")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 3"; "Label Printer 3")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 4"; "Label Printer 4")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 5"; "Label Printer 5")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 6"; "Label Printer 6")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 7"; "Label Printer 7")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 8"; "Label Printer 8")
                {
                    ApplicationArea = All;
                }

                field("Label Printer 9"; "Label Printer 9")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

    }

    trigger onopenpage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;
    end;
}