page 51155 "HBR GL Entry WS"
{
    Caption = 'HBR GL Entry WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "G/L Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }

                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = all;
                }

                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = all;
                }

                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }

                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }

                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                }

                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = all;
                }

                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = all;
                }

                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }

                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }

                field(Quantity; Quantity)
                {
                    ApplicationArea = all;
                }

                field("VAT Amount"; "VAT Amount")
                {
                    ApplicationArea = all;
                }

                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                }

                field("Gen. Posting Type"; "Gen. Posting Type")
                {
                    ApplicationArea = all;
                }

                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                }

                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }

                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = all;
                }



                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }


                field("External Document No."; "External Document No.")
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



