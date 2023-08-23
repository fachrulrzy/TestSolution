report 50606 "Posted Sales Invoice Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = SalesReport;

    dataset
    {
        dataitem(salesInvoiceHeader; "Sales Invoice Header")
        {
            DataItemTableView = Sorting("No.");
            PrintOnlyIfDetail = true;
            column(Picture; companyInfo.Picture)
            {
            }
            column(CompanyName; companyInfo.Name)
            {
            }
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(billToName; "Bill-to Name")
            {
                IncludeCaption = true;
            }
            column(Amount_Including_VAT; "Amount Including VAT")
            {
                IncludeCaption = true;
            }
            dataitem(custLedger; "Cust. Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                column(postingDate; "Posting Date")
                {
                    IncludeCaption = true;
                }
                column(Document_Type; "Document Type")
                {
                    IncludeCaption = true;
                }
                column(paymentAmount; Amount)
                {
                    IncludeCaption = true;
                }
                trigger OnPreDataItem()
                var
                begin
                    custLedger.SetRange(custLedger."Document Type", custLedger."Document Type"::Payment);
                    custLedger.SetRange(custLedger."Document No.", salesInvoiceHeader."No.");
                    if (startDate = 0D) and (endDate = 0D) then begin
                    end else begin
                        custLedger.SetRange(custLedger."Posting Date", startDate, endDate);
                    end;

                    if endDate = 0D then begin
                        endDate := System.Today;
                    end;

                    myInt:=custLedger.Amount*2;
                    // 20/05/2022 - 20/06/2022
                end;
                // field posting date
            }
            column(start_date; startDate)
            {
            }
            column(end_date; endDate)
            {
            }
        }
    }

    requestpage
    {
        // SaveValues = true;
        // PopulateAllFields = true;
        layout
        {
            area(Content)
            {
                group("Date Filter")
                {
                    field(TestActionLbl; TestActionLbl)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(TestActionLb2; TestActionLb2)
                    {
                        ApplicationArea = All;
                        ShowCaption = false;
                        Editable = false;
                    }
                    field(start_date; startDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter value';
                        Caption = 'Start Date';

                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (startDate > endDate) and (endDate > 0D) then begin
                                Error('Tanggal "endDate" tidak boleh kurang dari tanggal "startDate".');
                            end;
                        end;
                    }
                    field(end_date; endDate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter value';
                        Caption = 'End Date';

                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if (startDate > endDate) and (endDate > 0D) then begin
                                Error('Tanggal "endDate" tidak boleh kurang dari tanggal "startDate".');
                            end;
                        end;
                    }
                    // trigger OnDrillDown()
                    // begin
                    //     Message('This is a test action!');
                    // end;
                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(actionName)
                {
                    ApplicationArea = All;
                }
            }
        }

        trigger OnOpenPage()
        var
        begin
            if custLedger.Find('-') then begin
                startDate := custLedger."Posting Date";
            end;

            if custLedger.Find('+') then begin
                endDate := custLedger."Posting Date";
            end;
        end;
    }

    rendering
    {
        layout(SalesReport)
        {
            Type = RDLC;
            LayoutFile = 'postedSalesInvoice.rdl';
        }
    }

    trigger OnInitReport()
    begin
        companyInfo.get();
        companyInfo.CalcFields(Picture);
    end;

    var
        myInt: Decimal;
        psi: Record "Sales Invoice Header";
        cle: Record "Cust. Ledger Entry";
        companyInfo: Record "Company Information";
        TestActionLbl: Label 'Empty fields = View All Data';
        TestActionLb2: Label 'Empty "End Date" = Today Date';
        startDate: Date;
        endDate: Date;
}