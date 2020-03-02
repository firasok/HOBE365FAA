// HBR Integration Line AIA Webservice

page 51121 "Integration Line AIA WS"
{
    Caption = 'Integration Line AIA WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Line";
    SourceTableView = where ("Integration Source" = FILTER(AIA));
    DelayedInsert = true;
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
              
                }

                field("Document No."; "Document No.")
                {

                }
                field("Line No."; "Line No.")
                {
        
                }
                field(Description; Description)
                {

                }
                field("Description 2"; "Description 2")
                {

                }
                field("Unit of Measure"; "Unit of Measure")
                {

                }
                field(Quantity; Quantity)
                {

                }
                field(Amount; Amount)
                {
                    BlankZero = True;
                }
                field("Line Reference"; "Line Reference")
                {


                }
                field("School Course"; "School Course")
                {

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



