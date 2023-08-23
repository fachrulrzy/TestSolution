page 50602 "List Bio"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Tabel Bio";
    CardPageId = "Card Bio";
    Caption = 'List Bio';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(no; Rec.no)
                {
                    ApplicationArea = All;
                    Caption = 'No';
                    ShowMandatory = true;
                }
                field(nama; Rec.nama)
                {
                    ApplicationArea = All;
                    Caption = 'Nama';
                }
                field(jenisKelamin; Rec.jenisKelamin)
                {
                    ApplicationArea = All;
                    Caption = 'Jenis Kelamin';
                }
                field(jobTitle; Rec.jobTitle)
                {
                    ApplicationArea = All;
                    Caption = 'Job Title';
                }
                field(rateGaji; Rec.rateGaji)
                {
                    ApplicationArea = All;
                    Caption = 'Rate Gaji';
                }
                field(address; Rec.address)
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                
                field(statusPerkawinan; Rec.statusPerkawinan)
                {
                    ApplicationArea = All;
                    Caption = 'Status Perkawinan';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Report Preview")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                    bioReport: Report "Report Bio";
                begin
                    bioReport.run();
                end;
            }
            action("Auto Insert")
            {
                ApplicationArea = All;

                trigger OnAction();
                var

                begin
                    autoinsert(Rec.no);
                end;
            }
            action("View All")
            {
                ApplicationArea = All;

                trigger OnAction();
                var
                begin
                    rec.reset();
                end;
            }
        }
    }

    local procedure autoinsert(var no: Code[20])
    var
        linebio: Record "Lines Bio";
        bank: Record "Bank Account";
    begin
        bank.SetFilter("No.", 'C*');
        if bank.FindSet() then begin
            linebio.Init();
            linebio.num := no;
            linebio.tipeSekolah := linebio.tipeSekolah::SD;
            linebio.namaSekolah := bank."No.";
            linebio.Insert();
        end
    end;

    trigger OnOpenPage()
    var
    begin
        Rec.SetRange(jobTitle,Rec.jobTitle::PNS);
    end;
}