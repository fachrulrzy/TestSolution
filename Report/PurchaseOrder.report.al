report 50605 "Purchase Order Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = purchaseOrderReport;

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            PrintOnlyIfDetail = true;
            column(Picture; companyInfo.Picture)
            {
            }
            column(CompanyName; companyInfo.Name)
            {
            }
            column(CompanyPhone; companyInfo."Phone No.")
            {
            }
            column(CompanyCity; companyInfo.City)
            {
            }
            column(Num; "No.")
            {
                IncludeCaption = true;
            }
            column(Pay_to_Name; "Pay-to Name")
            {
                IncludeCaption = true;
            }
            column(Pay_to_City; "Pay-to City")
            {
                IncludeCaption = true;
            }
            dataitem(PurchaseLine; "Purchase Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(numberItem; "No.")
                {
                    IncludeCaption = true;
                }
                column(desc; Description)
                {
                    IncludeCaption = true;
                }
                column(quan; Quantity)
                {
                    IncludeCaption = true;
                }
                column(Direct_Unit_Cost; "Direct Unit Cost")
                {
                    IncludeCaption = true;
                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {
                    IncludeCaption = true;
                }
                column(Line_Discount__; "Line Discount %")
                {
                    IncludeCaption = true;
                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {
                    IncludeCaption = true;
                }
                column(Job_Total_Price; "Job Total Price")
                {
                    IncludeCaption = true;
                }
                column(VAT__;"VAT %")
                {
                    IncludeCaption = true;
                }
                dataitem(dimensionValue; "Dimension Value")
                {
                    DataItemLink = Code = field("Shortcut Dimension 1 Code");
                    column(kode; Code)
                    {
                        IncludeCaption = true;
                    }
                    column(Name; Name)
                    {
                        IncludeCaption = true;
                    }
                }

                trigger OnPreDataItem()
                var
                begin
                    PurchaseHeader.SetRange("No.", No_);
                    PurchaseHeader."No." := No_;
                    PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                    // PurchaseLine.CalcFields("Amount Including VAT");
                end;
            }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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

    rendering
    {
        layout(purchaseOrderReport)
        {
            Type = RDLC;
            LayoutFile = 'purchaseOrderReport.rdl';
        }
    }

    procedure setparm(_No: Code[20])
    var
    begin
        No_ := _No;
    end;

    trigger OnInitReport()
    begin
        companyInfo.get();
        companyInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        companyInfo: Record "Company Information";
        No_: Code[20];
}