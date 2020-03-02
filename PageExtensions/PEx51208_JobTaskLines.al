pageextension 51208 "HBR Job Task Lines" extends "Job Task Lines"
{
    layout
    {
        addafter("WIP Method")
        {
            field("HBR Responsible";"HBR Responsible")
            {

            }
            field("HBR Status"; "HBR Status")
            {
                Caption = 'Status';
            }
        }
    }

    actions
    {

        modify("Create &Sales Invoice")
        {
            Visible = false;
            Enabled = false;
        }

        addbefore("F&unctions")
        {
            action("HBR Create Sales Invoice")
            {
                Caption = 'Create Sales Invoices';
                ApplicationArea = All;
                Ellipsis = true;
                Image = CreateJobSalesInvoice;

                trigger OnAction()
                var
                    JobTask: Record "Job Task";
                begin
                    JobTask.Copy(Rec);
                    REPORT.RUNMODAL(REPORT::"Job Create Sales Invoice", TRUE, FALSE, JobTask);
                end;
            }
        }
    }
}