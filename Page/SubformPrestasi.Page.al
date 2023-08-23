page 50608 "Subform Prestasi"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Lines Prestasi";
    
    layout
    {
        area(Content)
        {
            repeater(Prestasi)
            {
                field(nama_prestasi;Rec.nama_prestasi)
                {
                    ApplicationArea = All;
                    Caption = 'Nama Prestasi';
                }
                field(tingkat;Rec.tingkat)
                {
                    ApplicationArea = All;
                    Caption = 'Tingkat';
                }
                field(penyelenggara;Rec.penyelenggara)
                {
                    ApplicationArea = All;
                    Caption = 'Penyelenggara';
                    TableRelation = Vendor;

                    trigger OnValidate()
                    var
                        vendorRec: Record Vendor;
                    begin
                        if vendorRec.Get(Rec.penyelenggara) then 
                            Rec.desc := vendorRec.Name;
                    end;
                }
                field(desc;Rec.desc)
                {
                    ApplicationArea = All;
                    Caption = 'Deskripsi';
                    Editable = false;
                }
                field(juara;Rec.juara)
                {
                    ApplicationArea = All;
                    Caption = 'Juara';
                }
                field(lineNumberP;Rec.lineNumberP)
                {
                    ApplicationArea = All;
                    Caption = 'lineNumber';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action("Delete Penyelenggara")
            {
                ApplicationArea = All;
                Image = Delete;
                
                trigger OnAction()
                begin
                    Rec.penyelenggara := '';
                    Rec.desc := '';
                    Rec.Modify();
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}