//HBR Integration tabels Extention



page 51102 "Integration Comment Line"
{
    Caption = 'Integration Comment Line';
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Comment Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;

                }

                field("Application Area"; "Application Area")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field(Date; Date)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; "Document Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;
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



