tableextension 51300 HBR_GLAccountExt extends "G/L Account"
//<NCO>
//Tableextension of table 15, used for handling Budget Regulation types
//</NCO>
{
    fields
    {
        // Add changes to table fields here
        field(50100; "Budget Regulation Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","P","L","PL";
            Caption = 'Budget Regulation Type';
            OptionCaption = ' ,P,L,PL';
        }
    }

    var
        myInt: Integer;
}