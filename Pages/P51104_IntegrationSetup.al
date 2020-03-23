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

                }
                field("G/L Account"; "G/L Account")
                {
                    ApplicationArea = all;

                }
                field("VAT G/L Account"; "VAT G/L Account")
                {
                    ApplicationArea = all;

                }
                field("G/L Account External"; "G/L Account External")
                {
                    Visible = false;
                    ApplicationArea = all;

                }
                field("VAT  G/L Account Ext."; "VAT  G/L Account Ext.")
                {
                    Visible = false;
                    ApplicationArea = all;

                }
                field("Owner Entrance Acc."; "Owner Entrance Acc.")
                {
                    ApplicationArea = all;

                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;

                }

                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;

                }

                field(Description; Description)
                {
                    ApplicationArea = all;

                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = all;

                }
                field("Quantity to invoice"; "Quantity to invoice")
                {
                    ApplicationArea = all;

                }
                field("Amount to invoice"; "Amount to invoice")
                {
                    ApplicationArea = all;

                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;

                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    Visible = false;
                    ApplicationArea = all;

                }

                field("Int. Cust. Price Grp."; "Int. Cust. Price Grp.")
                {
                    Visible = false;
                    ApplicationArea = all;

                }

                field("Ext. Cust. Price Grp."; "Ext. Cust. Price Grp.")
                {
                    Visible = false;
                    ApplicationArea = all;

                }

                field("EK Cust. Price Grp."; "EK Cust. Price Grp.")
                {
                    Visible = false;
                    ApplicationArea = all;

                }

                field("Ship to Code"; "Ship to Code")
                {
                    ApplicationArea = all;

                }

                field("Header Text"; "Header Text")
                {
                    ApplicationArea = all;

                }
                field("Footer Text"; "Footer Text")
                {
                    ApplicationArea = all;

                }

                field("Text G/L Acc."; "Text G/L Acc.")
                {
                    ApplicationArea = all;

                }

                field("Unit Of Measure"; "Unit Of Measure")
                {
                    ApplicationArea = all;

                }

                field("External Deb. Posting Grp."; "External Deb. Posting Grp.")
                {
                    ApplicationArea = all;

                }

                field("External EK Deb. Posting Grp."; "External EK Deb. Posting Grp.")
                {
                    ApplicationArea = all;

                }

                field("Domistic Deb. Posting Grp."; "Domistic Deb. Posting Grp.")
                {
                    ApplicationArea = all;

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



