
page 51147 "Contact Webshop WS"
{
    Caption = 'Contact Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Contact";
    SourceTableView = where(Webshop = filter(true));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;

                }
                field(Name; Name)
                {
                    ApplicationArea = all;

                }
                field("Name 2"; "Name 2")
                {
                    ApplicationArea = all;

                }
                field(Address; Address)
                {
                    ApplicationArea = all;

                }
                field("Address 2"; "Address 2")
                {
                    ApplicationArea = all;

                }

                field("Post Code"; "Post Code")
                {
                    ApplicationArea = all;

                }
                field(City; City)
                {
                    ApplicationArea = all;

                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = all;

                }

                field("Phone No."; "Phone No.")
                {
                    ApplicationArea = all;

                }

                field("E-Mail"; "E-Mail")
                {
                    ApplicationArea = all;

                }

                field("E-Mail 2"; "E-Mail 2")
                {
                    ApplicationArea = all;

                }


                field("Webshop User Group"; "Webshop User Group")
                {
                    ApplicationArea = all;

                }

                field("Login Prefix"; "Login Prefix")
                {
                    ApplicationArea = all;

                }

                field("Employee Code"; "Employee Code")
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



