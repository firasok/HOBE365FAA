// HBR Integration tabels Extention



page 51100 "Integration Header"
{
    Caption = 'Integration Header';
    PageType = List;
    ApplicationArea = ALL;
    UsageCategory = Administration;
    SourceTable = "Integration Header";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Application Area"; "Application Area")
                {
                    ApplicationArea = all;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }
                field("Customer No"; "Customer No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = all;
                }
                field(Adress; Address)
                {
                    ApplicationArea = all;
                }
                field("Adress 2"; "Address 2")
                {
                    ApplicationArea = all;
                }
                field("Your Reference"; "Your Reference")
                {
                    ApplicationArea = all;
                }
                field("Our Reference"; "Our Reference")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                    BlankZero = True;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = all;
                }
                field("External Invoice No"; "External Invoice No")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Reference Remarks"; "Reference Remarks")
                {
                    ApplicationArea = all;
                }
                field("Date of Creation"; "Date of Creation")
                {
                    ApplicationArea = all;
                }
                field("Time of Creation"; "Time of Creation")
                {
                    ApplicationArea = all;
                }
                field("Date Of Proces"; "Date Of Proces")
                {
                    ApplicationArea = all;
                }
                field(Processed; Processed)
                {
                    ApplicationArea = all;
                }
                field(Corrected; Corrected)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
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



