pageextension 50601 extPurchaseOrder extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("P&osting")
        {
            action("Report Preview Fachrul")
            {
                Caption = 'Report Preview Fachrul';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Image = PreviewChecks;

                trigger OnAction()
                var
                    po: Report "Purchase Order Report";
                begin
                    po.setparm(Rec."No.");
                    po.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}