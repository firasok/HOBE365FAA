
table 51110 "Webshop User Group"
{
    DataClassification = ToBeClassified;
    Caption = 'Webshop User Group';
    LookupPageId = "Webshop User Group";


    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }

        field(20; "Name"; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::UserGroup, "No.", '', IntegrationAction::Create);
    end;

    trigger OnModify()
    begin
        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::UserGroup, "No.", '', IntegrationAction::Update);
    end;

    trigger OnDelete()
    var
        ContactRec: Record Contact;
        ItemUserGroup: Record "Item User Group";
        recordCount: Integer;
        Text000: Label 'there are %1 Contacts that has User Group %2 do you like to disconnect?';
        Text001: Label 'Deleting is overrouled';
    begin
        ItemUserGroup.SetRange("User Group", Rec."No.");
        if ItemUserGroup.FindFirst then
            ItemUserGroup.DeleteAll;
        ContactRec.SetRange("Webshop User Group", rec."No.");
        if ContactRec.Findset then begin
            recordCount := ContactRec.CountApprox;
            if Confirm(StrSubstNo(Text000, recordCount, rec."No.", false)) then begin
                ContactRec.ModifyAll("Webshop User Group", '');
                HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::UserGroup, "No.", '', IntegrationAction::Delete);
            End else begin
                Error(Text001);
            end;
        end;

    end;


    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

}

