tableextension 51104 HBRItemVariant extends "Item Variant"
{
    fields
    {
        field(5000; "Webshop"; Boolean)
        {
            Caption = 'Webshop';
            trigger OnValidate()
            begin
                HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec.Code, IntegrationAction::Update);
            end;
        }
    }
    trigger OnAfterInsert()
    var
        ItemRec: Record Item;
    begin
        itemrec.get(rec."Item No.");
        if ItemRec.Webshop then begin
            Webshop := ItemRec.Webshop;
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec.Code, IntegrationAction::Update);
        end;
    end;

    trigger OnBeforeDelete()
    begin
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec.Code, IntegrationAction::Update);
    end;

    trigger OnAfterModify()
    begin
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, rec."Item No.", rec.Code, IntegrationAction::Update);
    end;


    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

}