pageextension 51207 "HBR Job Task Lines Subform" extends "Job Task Lines Subform"
{
    layout
    {
        addafter("WIP Method")
        {
               field("HBR Responsible";"HBR Responsible")
            {

            }
            field("HBR Status"; "HBR Status") { Caption = 'Status'; }
        }
    }

}