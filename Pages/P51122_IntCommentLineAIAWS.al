// HBR Integration Comment Line AIA Webservice

page 51122 "Integration Comment Ln AIA WS"
{
    Caption = 'Integration Comment Line AIA WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Comment Line";
    SourceTableView = where("Integration Source" = FILTER(AIA));
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
                field(Type; Type)
                {

                }

                field(Date; Date)
                {

                }
                field(Code; Code)
                {

                }
                field(Comment; Comment)
                {

                }
                field("Document Line No."; "Document Line No.")
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



