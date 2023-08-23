report 50603 "Input Sales"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Select Sales';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Sales)
                {
                    field("Customer No."; salesNo)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        // TableRelation = "Sales Header";

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            salesList: Page "Customer List";
                        // salesRec: Record "Sales Header";
                        begin
                            Clear(salesList);
                            Clear(customer."No.");
                            salesList.SetRecord(customer);
                            salesList.SetTableView(customer);
                            salesList.LookupMode(true);

                            if salesList.RunModal = Action::LookupOK then begin
                                salesList.GetRecord(customer);
                                salesNo := customer."No.";
                            end;
                        end;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPostReport()
    var
        salesList: Page "Sales Order List";
    begin
        sales.SetRange(sales."Sell-to Customer No.",salesNo);
        salesList.SetRecord(sales);
        salesList.SetTableView(sales);
        salesList.Run();
    end;


    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        salesNo: Code[20];
        sales: Record "Sales Header";
        customer: Record Customer;
}