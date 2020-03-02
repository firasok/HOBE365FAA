page 51114 "Integration Data KMD"
{
    Caption = 'Integration Data KMD';

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Data KMD";
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                }

                field("Posting Extension"; "Posting Extension")
                {
                    ApplicationArea = all;
                }

                field("User No."; "User No.")
                {
                    ApplicationArea = all;
                }

                field("Org. type"; "Org. type")
                {
                    ApplicationArea = all;
                }

                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = all;
                }

                field("Unit of Measure"; "Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Registration Location"; "Registration Location")
                {
                    ApplicationArea = all;
                }

                field("Expedition Line No."; "Expedition Line No.")
                {
                    ApplicationArea = all;
                }
                field("Rregistration Date"; "Rregistration Date")
                {
                    ApplicationArea = all;
                }

                field("Registration Acc. No."; "Registration Acc. No.")
                {
                    ApplicationArea = all;
                }

                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }

                field(Sign; Sign)
                {
                    ApplicationArea = all;
                }

                field("Account Type";"Account Type")
                {
                    ApplicationArea = all;
                }
                field("Accounting Year"; "Accounting Year")
                {
                    ApplicationArea = all;
                }

                field("Doc. archive Number"; "Doc. archive Number")
                {
                    ApplicationArea = all;
                }
                field("Value Date"; "Value Date")
                {
                    ApplicationArea = all;
                }

                field("Posting Text"; "Posting Text")
                {
                    ApplicationArea = all;
                }

                field(Processed;Processed)
                {
                    ApplicationArea = all;
                }

                field("process Date";"process Date")
                {
                    ApplicationArea = all;
                }
                   field("User ID";"User ID")
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



