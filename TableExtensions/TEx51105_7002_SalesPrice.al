tableextension 51105 HBRSalesPrice extends "Sales Price"
{

    fields
    {
        field(5000; "Webshop"; Boolean)
        {
            Caption = 'Webshop';

        }

    }
    trigger OnInsert()
    var
        ItemRec: Record Item;
    begin
        ItemRec.get(Rec."Item No.");
        if ItemRec.Webshop then begin
            Webshop := ItemRec.Webshop;            
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec."Sales Code", IntegrationAction::Update);
        end;
    end;

    trigger OnBeforeDelete()
    begin   
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec."Sales Code", IntegrationAction::Update);
    end;

    trigger OnAfterModify()
    begin
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec."Sales Code", IntegrationAction::Update);
    end;


    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

}