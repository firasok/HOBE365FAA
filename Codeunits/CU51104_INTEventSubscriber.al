codeunit 51104 INTEventSubscriber
{
    EventSubscriberInstance = StaticAutomatic;
    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', true, true)]
    local procedure OnAfterSalesInvLineInsert(VAR SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header";SalesLine : Record "Sales Line")

    var
        INTEventFunctions: Codeunit INTEventFunctions;

    begin        
        INTEventFunctions.UpdateSalesInvLine(SalesInvHeader, SalesInvLine,SalesLine);

    end;


}
