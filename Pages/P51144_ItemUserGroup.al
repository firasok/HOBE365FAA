

page 51144 "Item User Group"
{
    Caption = 'Item User Group';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item User Group";
    Editable = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;

                }

                field("User Group"; "User Group")
                {
                    ApplicationArea = all;

                }

                field(Name; Name)
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



