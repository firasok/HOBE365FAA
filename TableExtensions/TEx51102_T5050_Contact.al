tableextension 51102 HBRContact extends "Contact"
{

    fields
    {
        field(50001; "Webshop"; Boolean)
        {
            Caption = 'Webshop';
            trigger OnValidate()
            var
                CustomerNo: code[20];
                CustomerRec: Record Customer;
                WebshopValidate: Boolean;

            begin
                WebshopValidate := true;
                if rec.Webshop <> xRec.Webshop then begin
                    if webshop then begin
                        WebshopValidate := true;
                        CustomerNo := CheckCustomer(Rec, WebshopValidate);
                        if CustomerRec.get(CustomerNo) then begin
                            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, CustomerNo, "No.", IntegrationAction::Create);
                            "Login Prefix" := CustomerRec."Login Prefix";
                            Modify;
                        end;
                    end else begin
                        CustomerNo := CheckCustomer(Rec, WebshopValidate);
                        if CustomerRec.get(CustomerNo) then begin
                            Clear("Login Prefix");
                            Clear("Webshop User Group");
                            Clear("Employee Code");
                            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, CustomerNo, "No.", IntegrationAction::Delete);
                            Modify;
                        end;
                    end;
                end;
            End;
        }
        field(50002; "Webshop User Group"; Code[20])
        {
            Caption = 'Webshop User Group';
            TableRelation = "Webshop User Group";

        }

        field(50003; "Login Prefix"; Code[20])
        {
            Caption = 'Login Prefix';

        }

        field(50004; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';

        }

    }

    trigger OnAfterInsert()
    var

    begin
    end;

    trigger OnBeforeDelete()
    begin
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, getCustomer(Rec), "No.", IntegrationAction::Delete);
    end;

    trigger OnAfterModify()
    begin
        if Webshop then
            HBRIntegrationManagment.WebshopIntegrationLog(IntegrationTable::Contact, getCustomer(Rec), "No.", IntegrationAction::Update);
    end;

    procedure CheckCustomer(var pContactRec: Record Contact; pWebshopValidate: Boolean): Code[20]
    var
        CustomerRec: Record Customer;
        ContactRec: Record Contact;
        ContactCompany: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        WebshopValidate: Boolean;
        Text000: Label 'Customer %1 is not recognized as webshope user. Please check the value of Webshop field on Customer Card';

    begin
        WebshopValidate := pWebshopValidate;
        ContactRec := pContactRec;
        if ContactCompany.get(ContactRec."Company No.") then begin
            ContactBusinessRelation.SetRange("Contact No.", ContactCompany."No.");
            ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
            if ContactBusinessRelation.FindFirst() then begin
                if CustomerRec.get(ContactBusinessRelation."No.") then begin
                    if CustomerRec.Webshop = false then begin
                        if WebshopValidate then
                            error(StrSubstNo(Text000, CustomerRec."No."))
                    end;
                end;
            end;
        end;
        exit(CustomerRec."No.");
    End;

    procedure GetCustomer(var pContactRec: Record Contact): Code[20]
    var
        CustomerRec: Record Customer;
        ContactRec: Record Contact;
        ContactCompany: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        customerNo: code[20];
    begin
        ContactRec := pContactRec;
        if ContactCompany.get(ContactRec."Company No.") then begin
            ContactBusinessRelation.SetRange("Contact No.", ContactCompany."No.");
            ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
            if ContactBusinessRelation.FindFirst() then begin
                if CustomerRec.get(ContactBusinessRelation."No.") then begin
                    customerNo := CustomerRec."No.";
                end;
            End;
        End;
        exit(customerNo);
    end;

    var
        HBRIntegrationManagment: Codeunit "HBR Integration Managment";
        IntegrationTable: Option Customer,Contact,UserGroup,Item,WebOrder;
        IntegrationAction: option Create,Update,Delete,FullyInvoiced;

}