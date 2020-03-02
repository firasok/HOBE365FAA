tableextension 51103 HBRItem extends Item
{
    fields
    {
        field(5000; "Webshop"; Boolean)
        {
            Caption = 'Webshop';
            trigger OnValidate()

            begin
                if rec.Webshop <> xRec.Webshop then begin
                    WebshopTrigger := false;
                    UpdateItemVariant(rec, Webshop);
                    UpdateSalesPrices(rec, Webshop);

                    if Webshop then begin
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "No.", Rec."Item Category Code", IntegrationAction::Create)
                    end else begin
                        CheckItemUserGroups(Rec);
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "No.", Rec."Item Category Code", IntegrationAction::Delete);
                    End;
                    WebshopTrigger := true;
                end;
            end;
        }
    }

    trigger OnAfterModify()
    begin
        if (WebshopTrigger = false) and webshop then begin
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "No.", Rec."Item Category Code", IntegrationAction::Update);
        end;
    end;

    trigger OnBeforeDelete()
    var
        ItemUserGroup: Record "Item User Group";
    begin
        if Webshop then begin
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "No.", Rec."Item Category Code", IntegrationAction::Delete);
            ItemUserGroup.setrange("Item No.", "No.");
            if ItemUserGroup.Findset then
                ItemUserGroup.DeleteAll;
        end;
    end;

    procedure UpdateItemVariant(var pItem: Record Item; pWebshop: Boolean)
    var
        ItemRec: Record Item;
        ItemVariant: Record "Item Variant";
        lWebshop: Boolean;

    begin
        ItemRec := pItem;
        lWebshop := pWebshop;
        ItemVariant.setrange("Item No.", ItemRec."No.");
        if ItemVariant.FindSet then
            ItemVariant.ModifyAll(Webshop, lWebshop);
    end;

    procedure UpdateSalesPrices(var pItem: Record Item; pWebshop: Boolean)
    var
        ItemRec: Record Item;
        SalesPrice: Record "Sales Price";
        lWebshop: Boolean;

    begin
        ItemRec := pItem;
        lWebshop := pWebshop;
        SalesPrice.setrange("Item No.", ItemRec."No.");
        if SalesPrice.FindSet then
            SalesPrice.ModifyAll(Webshop, lWebshop);
    end;

    procedure CheckItemUserGroups(var pItemRec: Record Item);
    var
        ItemRec: Record Item;
        ItemUserGroup: Record "Item User Group";
        noOfRecords: integer;
        Text000: Label 'Item  %1 is Connected %2 User Groups do you want to remove connection?';
        Text001: Label 'Item  %1 is a Webshop member';

    begin
        ItemRec := pItemRec;
        ItemUserGroup.SetRange("Item No.", ItemRec."No.");
        if ItemUserGroup.Findset then begin
            noOfRecords := ItemUserGroup.CountApprox;

            if Confirm(StrSubstNo(Text000, ItemRec."No.", format(noOfRecords), true)) then
                ItemUserGroup.DeleteAll(true)
            else
                Error(StrSubstNo(Text001, ItemRec."No."));
        end;
    End;

    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;
        WebshopTrigger: Boolean;
}