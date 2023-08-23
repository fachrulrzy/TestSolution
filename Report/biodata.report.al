report 50601 "Report Bio"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;
    
    dataset
    {
        dataitem(dataBio; "Tabel Bio")
        {
            column(Picture; companyInfo.Picture)
            {
            }
            column(CompanyName; companyInfo.Name)
            {
            }
            column(no; no)
            {
            }
            column(nama; nama)
            {
            }
            column(jobTitle; jobTitle)
            {
            }
            column(statusPerkawinan; statusPerkawinan)
            {
            }
            dataitem(DataLines; "Lines Bio"){
                DataItemLink = num = field(no);
                column(startDate;startDate)
                {
                }
                column(endDate;endDate)
                {
                }
            }
            trigger OnPreDataItem()
            begin
                dataBio.SetRange(jobTitle,jobTitle::PNS);
            end;
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {
                //         ApplicationArea = All;
                        
                //     }
                // }
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
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'report-biodata.rdl';
        }
    }
    
    trigger OnInitReport()
    begin
        companyInfo.get();
        companyInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        companyInfo: Record "Company Information";
    
}