page 51105 "Process Log Header"
{
    Caption = 'Process Log Header';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Process Log Header";
    Editable = false;
    
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Log No."; "No.")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Start Time"; "Start Time")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("End Time"; "End Time")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Job Name"; "Log Name")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Error Message"; "Error Message")
                {
                    ApplicationArea = all;
                    Visible = False;
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



