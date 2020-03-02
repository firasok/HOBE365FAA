
page 51146 "Customers Webshop WS"
{
    Caption = 'Customers Webshop WS';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer";
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

                field("Customer Price Group"; "Customer Price Group")
                {
                    ApplicationArea = all;

                }

                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = all;

                }

                field("Login Prefix";"Login Prefix")
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



