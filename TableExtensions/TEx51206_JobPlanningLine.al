tableextension 51206 "HBR Job Planning Line" extends "Job Planning Line"
{

    trigger OnInsert()
    var
        JobTask: Record "Job Task";
    begin
        JobTask.get(rec."Job No.", rec."Job Task No.");
        if (JobTask."HBR Status" = JobTask."HBR Status"::"Invoice Suggestion Created") or (JobTask."HBR Status" = JobTask."HBR Status"::Invoiced) then
            Error(StrSubstNo(JobTaskStatusError, JobTask."Job Task No.", JobTask."HBR Status"));
    end;

    var
        JobTaskStatusError: Label 'Cannot create new Job Planning Line because Job Task %1 has status %2.';
}