
table 51111 "Item User Group"
{
    DataClassification = ToBeClassified;
    Caption = 'Item User Group';
    LookupPageId = "Item User Group";

    fields
    {
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = ToBeClassified;
        }

        field(20; "User Group"; Code[20])
        {
            Caption = 'User Group';
            TableRelation = "Webshop User Group";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                WebshopUserGroup: Record "Webshop User Group";
            begin
                if WebshopUserGroup.Get(rec."User Group") then
                    rec.name := WebshopUserGroup.name;
            end;
        }

        field(30; "Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Item No.", "User Group")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "Item No.", "User Group", IntegrationAction::Update);
    end;

    trigger OnModify()
    begin
        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "Item No.", "User Group", IntegrationAction::Update);
    end;

    trigger OnDelete()
    begin
        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Item, "Item No.", "User Group", IntegrationAction::Update);
    end;

    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

}
