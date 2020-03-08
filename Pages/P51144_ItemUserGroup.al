

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

        area(Navigation)
        {
            action("User group Items")
            {

                ApplicationArea = All;
                ToolTip = 'Items Connected to user Item Group';
                Image = Group;
                //RunObject = page "Item User Group";
                //RunPageLink = "User Group" = FIELD("User Group");

                trigger OnAction()
                var
                    ItemUserGroup: record "Item User Group";
                begin
                    ItemUserGroup.SETRANGE("User Group", Rec."User Group");
                    if ItemUserGroup.findset then begin
                        IF Page.RUNMODAL(Page::"Item User Group", ItemUserGroup) = ACTION::LookupOK THEN;
                    end;
                end;

            }
            action("User group Contacts")
            {
                ApplicationArea = All;
                ToolTip = 'Contacts Connected to user Item Group';
                Image = Group;
                RunObject = page "Contact list";
                RunPageLink = "Webshop User Group" = FIELD("User Group");

                trigger OnAction()
                begin

                end;

            }
        }
    }

    var
        myInt: Integer;
}



