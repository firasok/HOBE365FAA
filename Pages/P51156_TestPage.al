page 51156 Test

{
    caption = 'TEST PAGE';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Integration Header";


    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TEST)
            {
                Caption = 'Test Me';
                ApplicationArea = All;
                Image = ApprovalSetup;

                trigger OnAction()
                begin

                    //PaymentJurnal.Run();
                    // PrintLabel.Run();
                    KMDJournal.Run();
                    Clear(KMDJournal);

                end;
            }
        }
    }

    var
        myInt: Integer;

        SKFJournal: XmlPort "SKF Payment journal";
        KMDJournal: XmlPort "File Integration KMD";
}