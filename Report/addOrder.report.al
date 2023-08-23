report 50600 "Add Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Auto Add Sales Order';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Customer)
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
        addOrderPage: Page "Sales Order";
        so: Record "Sales Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        nextNumber: Code[20];
        nextNumberMsg: Label 'The next number is ''%1''.';
    begin
        so.Get();
        // so.TestField("No.");
        nextNumber := NoSeriesMgt.GetNextNo('S-ORD', 0D, true);
        // Message(nextNumberMsg, nextNumber);

        so.Init();
        so."No." := nextNumber;
        so."Document Type" := so."Document Type"::Order;
        so.Validate("Sell-to Customer No.", salesNo);
        // so."Sell-to Customer No." := salesNo;
        so.Insert();
        addOrderPage.SetRecord(so);
        addOrderPage.SetTableView(so);
        addOrderPage.Run();
    end;


    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    // procedure GetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date; ModifySeries: Boolean) Result: Code[20]
    // var
    //     IsHandled: Boolean;
    // begin
    //     IsHandled := false;
    //     OnBeforeGetNextNo(NoSeriesCode, SeriesDate, ModifySeries, Result, IsHandled);
    //     if IsHandled then
    //         exit(Result);
    //     exit(DoGetNextNo(NoSeriesCode, SeriesDate, ModifySeries, false))
    // end;

    var
        myInt: Integer;
        salesNo: Code[20];
        sales: Record "Sales Header";
        customer: Record Customer;
}