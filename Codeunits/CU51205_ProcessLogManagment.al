codeunit 51205 "Process Log Managment"
{
    trigger OnRun();

    begin

    end;

    var
        errorCount: Integer;

    procedure InsertProcessLog(logName: text[100]; var logNo: Integer)
    var
        ProcessLogRec: Record "Process Log Header";
    begin
        ProcessLogRec.Reset();
        IF ProcessLogRec.FINDlast THEN
            logNo := ProcessLogRec."No." + 1
        ELSE
            logNo := 1;
        ProcessLogRec.INIT;
        ProcessLogRec."No." := logNo;
        ProcessLogRec.Date := TODAY;
        ProcessLogRec."Start Time" := TIME;
        ProcessLogRec."Log Name" := logName;
        ProcessLogRec."User ID" := USERID;
        ProcessLogRec.INSERT(true);
        errorCount := 1;
    end;

    procedure InsertProcessLogLine(ErrorText: text[250]; pLogNo: integer)
    var
        ProcessLogRec: Record "Process Log Header";
        ProcessLogLineRec: Record "Process Log Line";
        logLineNo: Integer;
        logNo: Integer;
    begin
        logNo := pLogNo;
        ProcessLogRec.Reset();
        ProcessLogRec.GET(logNo);
        ProcessLogLineRec.RESET;
        ProcessLogLineRec.SETRANGE("Log No.", ProcessLogRec."No.");
        IF ProcessLogLineRec.FindLast() THEN
            logLineNo := ProcessLogLineRec."Line No." + 1
        ELSE
            logLineNo := 1;

        ProcessLogLineRec.INIT;
        ProcessLogLineRec."Log No." := ProcessLogRec."No.";
        ProcessLogLineRec."Line No." := logLineNo;
        ProcessLogLineRec."Description" := ErrorText;
        ProcessLogLineRec.INSERT(true);
    end;

    procedure InsertProcessLogEnding(endingText: text[250]; plogNo: integer)
    var
        ProcessLogRec: Record "Process Log Header";
        logNo: Integer;
    begin 
        logNo := pLogNo;
        ProcessLogRec.Reset();
        ProcessLogRec.GET(logNo);
        ProcessLogRec."End Time" := TIME;
        ProcessLogRec.Description := endingText;
        ProcessLogRec.MODIFY(true);
    end;

}


