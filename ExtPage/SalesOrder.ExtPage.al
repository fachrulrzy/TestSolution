pageextension 50602 extSalesOrder extends "Sales Order List"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        addafter("Create &Warehouse Shipment")
        {
        action(openSalesOrder)
            {
                Caption = 'Open Sales Order';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    card: Report "Input Sales";
                begin
                    card.Run();
                    // CurrPage.Close();
                end;
            }
        action(autoAdd)
        {
            Caption = 'Add Sales Order';
            ApplicationArea = All;
            Promoted = true;
            PromotedCategory = Process;

            trigger OnAction()
            var
                autoAdd: Report "Add Order";
            begin
                autoAdd.Run();
            end;
        }
        }
        // Add changes to page actions here
    }
    

    
    var
        myInt: Integer;
}