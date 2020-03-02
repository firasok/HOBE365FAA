// HBR Integration Header Planorama Webservice

page 51140 "Integration Header WEB WS"
{
    Caption = 'Integration Header Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Header";
    SourceTableView = where("Integration Source" = FILTER(WEBSHOP));
    DelayedInsert = TRUE;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {

                }
                field("No."; "No.")
                {

                }
                field("Application Area"; "Application Area")
                {

                }
                field("Customer No"; "Customer No.")
                {

                }
                field(Name; Name)
                {

                }
                field("Name 2"; "Name 2")
                {

                }
                field(Adress; Address)
                {

                }
                field("Adress 2"; "Address 2")
                {

                }
                field("Contact No."; "Contact No.")
                {

                }
                field("Contact Name"; "Contact Name")
                {

                }
                field("Your Reference"; "Your Reference")
                {

                }
                field("Our Reference"; "Our Reference")
                {

                }
                field(Amount; Amount)
                {
                    BlankZero = True;

                }
                field("Source Code"; "Source Code")
                {

                }
                field("External Invoice No"; "External Invoice No")
                {

                }
                field(Description; Description)
                {

                }

                field("Reference Remarks"; "Reference Remarks")
                {

                }
                field("Date of Creation"; "Date of Creation")
                {

                }
                field("Time of Creation"; "Time of Creation")
                {

                }
                field("Date Of Proces"; "Date Of Proces")
                {

                }
                field(Status; Status)
                {
                    Editable = false;
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



