page 51104 "Integration Setup"
{
    Caption = 'Integration Setup';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Setup";
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Application Area"; "Application Area")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = true;
                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("VAT G/L Account"; "VAT G/L Account")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("G/L Account External"; "G/L Account External")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("VAT  G/L Account Ext."; "VAT  G/L Account Ext.")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Owner Entrance Acc."; "Owner Entrance Acc.")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Quantity to invoice"; "Quantity to invoice")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Amount to invoice"; "Amount to invoice")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Int. Cust. Price Grp."; "Int. Cust. Price Grp.")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Ext. Cust. Price Grp."; "Ext. Cust. Price Grp.")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("EK Cust. Price Grp."; "EK Cust. Price Grp.")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Ship to Code"; "Ship to Code")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

                field("Header Text"; "Header Text")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }
                field("Footer Text"; "Footer Text")
                {
                    ApplicationArea = all;
                    Editable = True;
                    Visible = True;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;

            }
        }
    }

    var
        myInt: Integer;
}



