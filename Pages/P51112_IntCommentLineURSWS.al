// HBR Integration Comment Line URS Webservice

page 51112 "Integration Comment Ln URS WS"
{
    Caption = 'Integration Comment Line URS WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Comment Line";
    SourceTableView = where("Integration Source" = FILTER(URS));
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



