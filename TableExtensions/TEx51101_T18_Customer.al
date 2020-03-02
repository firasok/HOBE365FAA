tableextension 51101 HBRCustomer extends "Customer"
{
    fields
    {
        field(50000; "Planorama"; Boolean)
        {
            Caption = 'Planorama';
            trigger OnValidate()
            begin
                planoramaTrigger := true;
            end;

        }

        field(50001; "Webshop"; Boolean)
        {
            Caption = 'Webshop';

            trigger OnValidate()
            begin
                WebshopTrigger := false;
                if xRec.Webshop <> Rec.Webshop then begin
                    if Rec.Webshop = true then begin
                        TestField("Primary Contact No.");
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Customer, Rec."No.", '', IntegrationAction::Create);
                    End else begin
                        clear("Login Prefix");
                        UpdateContacts(Rec, false);
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Customer, Rec."No.", '', IntegrationAction::Delete);
                    end;
                    WebshopTrigger := true;
                end;
            end;
        }

        field(50002; "Login Prefix"; Code[4])
        {
            TableRelation = "Login Prefix";
            Caption = 'Login Prefix';

            trigger OnValidate()
            begin
                UpdateContacts(Rec, Webshop);
            end;
        }

    }
    trigger OnAfterModify()
    begin
        if ((WebshopTrigger = false) and (webshop)) then begin
            if (planoramaTrigger = false) then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Customer, Rec."No.", '', IntegrationAction::Update);
        end;
    end;

    trigger OnBeforeDelete()
    Begin
        if ((WebshopTrigger = false) and (Webshop)) then begin

                HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Customer, Rec."No.", '', IntegrationAction::Delete);
        end;
    End;

    procedure UpdateContacts(var pCustomerRec: Record Customer; pWebshop: Boolean)

    var
        CustomerRec: Record Customer;
        ContactRec: Record Contact;
        Webshop: Boolean;
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;
        Text00: Label 'There is one or more contact connected to Customer %1 do you want to continue ?';
    begin
        Webshop := pWebshop;
        CustomerRec := pCustomerRec;
        ContactRec.setrange(ContactRec.Type, ContactRec.Type::Person);
        ContactRec.setrange(ContactRec."Company No.", CustomerRec."Primary Contact No.");
        ContactRec.setrange(Webshop, true);
        if ContactRec.Findset then
            if Confirm(StrSubstNo(Text00, CustomerRec."No."), true) then begin
                repeat
                    if WebShop then
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, CustomerRec."No.", ContactRec."No.", IntegrationAction::Update)
                    else
                        HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, CustomerRec."No.", ContactRec."No.", IntegrationAction::Delete);
                    ContactRec.Webshop := Webshop;
                    ContactRec."Login Prefix" := CustomerRec."Login Prefix";
                    clear(ContactRec."Webshop User Group");
                    ContactRec.Modify;
                until ContactRec.next = 0;
            End;
    end;

    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;
        WebshopTrigger: Boolean;
        planoramaTrigger: Boolean;
}