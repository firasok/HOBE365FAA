
table 51112 "Webshop Integration Log"
{
    DataClassification = ToBeClassified;
    Caption = 'Webshop Integration Log';

    fields
    {
        field(10; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }

        field(20; "Integration Table"; Option)

        {
            Caption = 'Integration Table';
            OptionMembers = Customer,Contact,UserGroup,Item,WebOrder;
            OptionCaption = 'Customer,Contact,UserGroup,Item,WebOrder';
            DataClassification = ToBeClassified;

        }

        field(30; "Integration No."; code[20])
        {
            Caption = 'Integration No.';
            TableRelation = IF ("Integration Table" = CONST(Customer)) "Customer"
            ELSE
            IF ("Integration Table" = CONST(Contact)) "Contact"
            ELSE
            IF ("Integration Table" = CONST(UserGroup)) "Webshop User Group"
            ELSE
            IF ("Integration Table" = CONST(Item)) "Item"            
            ELSE
            IF ("Integration Table" = CONST(WebOrder)) "Sales header"."No." where("Document Type" = const(Order));

            ValidateTableRelation = false;
        }

        field(40; "Integration No.2"; code[20])
        {
            Caption = 'Integration No.2';
            DataClassification = ToBeClassified;

           
            TableRelation = IF ("Integration Table" = CONST(UserGroup)) "Item User Group"."Item No."           
            ELSE
            IF ("Integration Table" = CONST(WebOrder)) "Sales header"."No." where("Document Type" = const(Order));
        }

        field(50; "Integration Action"; option)
        {
            Caption = 'Integration Action';
            OptionMembers = Create,Update,Delete,FullyInvoiced;
            OptionCaption = 'Create,Update,Delete,FullyInvoiced';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}

