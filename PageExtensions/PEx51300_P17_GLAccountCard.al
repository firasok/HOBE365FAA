pageextension 51300 HBRGLAccountCardExt extends "G/L Account Card"
    //<NCO>
    // Pageextension for Page 17, add field Budget Regulation Types
    //</NCO>
{
    layout
    {
        // Add changes to page layout here
        addafter("Cost Accounting")
        {
            group("Budget")

            {
                Caption = 'Budget Regulation Type';
                field("Budget Regulation Type"; "Budget Regulation Type")
                {

                }


            }

        }


    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}