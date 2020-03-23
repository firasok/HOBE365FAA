//HBR Integration tabels Extention



page 51101 "Integration Line List"
{
    Caption = 'Integration Line List';
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Line";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Type"; "Document Type")
                {
                    Visible = false;
                }
                field("Application Area"; "Application Area")
                {
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {

                }
                field("Line No."; "Line No.")
                {
                    Visible = false;
                }
                field(Description; Description)
                {

                }
                field("Description 2"; "Description 2")
                {
                    Visible = false;
                }
                field(Quantity; Quantity)
                {

                }
                field(Amount; Amount)
                {
                    BlankZero = True;
                }
                field("Unit of Measure"; "Unit of Measure")
                {

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



