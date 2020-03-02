// HBR Integration Line PLA Webservice

page 51141 "Integration Line WEB WS"
{
    Caption = 'Integration Line Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Line";
    SourceTableView = where("Integration Source" = FILTER(WEBSHOP));
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
                field("Item No."; "Item No.")
                {

                }
                field("Item No. 2"; "Item No. 2")
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
                    BlankZero = True;
                }
                field(Amount; Amount)
                {
                    BlankZero = True;
                }
                field("Item Variant"; "Item Variant")
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



