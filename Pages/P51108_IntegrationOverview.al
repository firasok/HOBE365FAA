page 51108 "Integration Overview"
{

    Caption = 'Integration Overview';
    PageType = Document;
    SourceTable = "Integration Header";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group("Integrations")
            {

                repeater(Group)
                {
                    field("No."; "No.")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Aplication Area"; "Application Area")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field("Document Type"; "Document Type")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field("Customer No"; "Customer No.")
                    {
                        ApplicationArea = all;
                        Editable = True;
                    }
                    field(Name; Name)
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Name 2"; "Name 2")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field(Adresse; Address)
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Adresse 2"; "Address 2")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field(Amount; Amount)
                    {
                        ApplicationArea = all;
                        Editable = false;
                        BlankZero = True;
                    }
                    field("Source Code"; "Source Code")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field("External Invoice No"; "External Invoice No")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Your Refrence"; "Your Reference")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Our Refrence"; "Our Reference")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Reference Remarks"; "Reference Remarks")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Date of Creation"; "Date of Creation")
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                    field("Time of Creation"; "Time of Creation")
                    {
                        ApplicationArea = all;
                        Visible = FALSE;
                        Editable = false;
                    }
                    field("Date Of Proces"; "Date Of Proces")
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field(Processed; Processed)
                    {
                        ApplicationArea = all;
                        Visible = false;
                        Editable = false;
                    }
                    field(Status; Status)
                    {
                        ApplicationArea = all;
                        Editable = false;
                    }
                }
            }

            part(IntegrationLines; "Integration Line list")
            {
                Caption = 'Integration Lines';
                SubPageLink = "Document No." = field("No.");
            }

            part(IntegrationComments; "Integration Comment Line")
            {
                Caption = 'Integration Comment Lines';
                SubPageLink = "Document No." = field("No.");
            }
            systempart("Links"; Links)
            {
            }
            systempart("Notes"; Notes)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Show&Process Log")
            {
                Caption = 'Show &Process Log';
                Image = GetLines;
                trigger OnAction()
                var
                    ProcessLogHeader: Record "Process Log Header";
                begin
                    ProcessLogHeader.findset;
                    PAGE.Run(PAGE::"Process Log Overview", ProcessLogHeader);
                    CurrPage.Update(true);
                end;
            }

            action("S&how All")
            {
                Caption = 'S&how All';
                Image = GetLines;
                trigger OnAction()
                begin
                    Rec.SetRange(Status);
                    Rec.SetRange(Processed);
                    CurrPage.Update(true);
                end;
            }
        }
    }

    var
        myInt: Integer;
        filterReset: Boolean;

}

