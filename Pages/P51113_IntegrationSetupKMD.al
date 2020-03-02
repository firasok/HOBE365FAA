page 51113 "Integration Setup KMD"
{
    Caption = 'Integration Setup KMD';

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Setup KMD";
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Account No. KMD"; "Account No. KMD")
                {
                    ApplicationArea = all;
                }
                field("Account Name KMD"; "Account Name KMD")
                {
                    ApplicationArea = all;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = all;
                }
                field("Account Name"; "Account Name")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 2 Code";"Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                
                field("Shortcut Dimension 3 Code";"Shortcut Dimension 3 Code")
                {
                    ApplicationArea = all;
                }
                
                field("Shortcut Dimension 4 Code";"Shortcut Dimension 4 Code")
                {
                    ApplicationArea = all;
                }
                
                field("Shortcut Dimension 5 Code";"Shortcut Dimension 5 Code")
                {
                    ApplicationArea = all;
                }
                
                field("Date Filter";"Date Filter")
                {
                    ApplicationArea = all;
                }
                
                field("Account Balance";"Account Balance")
                {
                    ApplicationArea = all;
                }
                
                field("VAT Balance";"VAT Balance")
                {
                    ApplicationArea = all;
                }
                
               
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;

            }
        }
    }

    var
        myInt: Integer;
}



