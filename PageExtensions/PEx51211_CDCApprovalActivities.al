pageextension 51211 "HBR CDC Appr. Activities" extends "CDC Approval Activities"
{
    layout
    {
        addlast(Bilagsgodkendelse)
        {
            field("Requests to Approve"; "Requests to Approve")
            {
                ApplicationArea = Basic, Suite;
                DrillDownPageID = "Requests to Approve";
                ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }
}