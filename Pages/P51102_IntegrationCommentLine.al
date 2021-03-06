// Welcome to HBR Integration tabels Extention



page 51102 "Integration Comment Line"
{
    Caption = 'Integration Comment Line';
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Comment Line";
    Editable = true;

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

                }

                field("Application Area"; "Application Area")
                {
                    ApplicationArea = all;
                }

                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }

                field(Type; Type)
                {
                    ApplicationArea = all;
                }


                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field(Code; Code)
                {

                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Document Line No."; "Document Line No.")
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



