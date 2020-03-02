page 51103 "Process Log Overview"
{
    Caption = 'Process Log Overview';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "process Log Header";
    Editable = false;

    layout
    {
        area(Content)
        {
            group(Log)
            {
                repeater(Group)
                {
                    field("Log No."; "No.")
                    {
                        ApplicationArea = all;
                    }
                    field(Date; Date)
                    {
                        ApplicationArea = all;
                    }
                    field("Start Time"; "Start Time")
                    {
                        ApplicationArea = all;
                    }
                    field("End Time"; "End Time")
                    {
                        ApplicationArea = all;
                    }
                    field("Job Name"; "Log Name")
                    {
                        ApplicationArea = all;
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = all;
                    }
                    field("User ID"; "User ID")
                    {
                        ApplicationArea = all;
                    }
                    field("Error Message"; "Error Message")
                    {
                        ApplicationArea = all;
                    }

                }

            }
            part("process log Lines"; "process log Lines")
            {
                Caption = 'process log Lines';
                SubPageLink = "Log No." = field ("No.");
            }
            systempart("Links"; Links)
            {
            }
            systempart("Notes"; Notes)
            {
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



