page 50600 "Card Bio"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tabel Bio";
    
    layout
    {
        area(Content)
        {
            group(Biodata)
            {
                field(no;Rec.no)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(nama;Rec.nama)
                {
                    ApplicationArea = All;
                    
                }
                field(jenisKelamin;Rec.jenisKelamin)
                {
                    ApplicationArea = All;
                    
                }
                field(jobTitle;Rec.jobTitle)
                {
                    ApplicationArea = All;
                    
                }
                field(rateGaji;Rec.rateGaji)
                {
                    ApplicationArea = All;
                    
                }
                field(address;Rec.address)
                {
                    ApplicationArea = All;
                    
                }
                field(statusPerkawinan;Rec.statusPerkawinan)
                {
                    ApplicationArea = All;
                    
                }
            }
            group("Pendidikan")
            {
                part("Name"; "Subform Bio")
                {
                    SubPageLink = num = field(no);
                    ApplicationArea = All;
                    UpdatePropagation = SubPart;
                }
            }
            group("Prestasi")
            {
                part("Meine"; "Subform Prestasi")
                {
                    SubPageLink = pk = field(no);
                    ApplicationArea = All;
                    UpdatePropagation = SubPart;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction();
                begin
                    
                end;
            }
        }
    }
}