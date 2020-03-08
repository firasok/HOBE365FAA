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


    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
    local procedure OnAfterPostSalesDoc(VAR SalesHeader: Record "Sales Header"; GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";SalesShptHdrNo : Code [20];SalesInvHdrNo: code[20])

    var
        INTEventFunctions: Codeunit INTEventFunctions;

    begin        
      INTEventFunctions.UpdateWebshopIntegrationLog(SalesHeader,GenJnlPostLine,'','','','');
    end;


}
