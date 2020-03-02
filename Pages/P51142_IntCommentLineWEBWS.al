// HBR Integration Comment Line Planorama Webservice

page 51142 "Integration Comment Ln WEB WS"
{
    Caption = 'Integration Comment Line Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Comment Line";
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
                field("Line No. 2"; "Document Line No.")
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



