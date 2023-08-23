page 50607 "Subform Bio"
{
    PageType = CardPart;
    // ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Lines Bio";

    layout
    {
        area(Content)
        {
            repeater(Pendidikan)
            {
                field(tipeSekolah; Rec.tipeSekolah)
                {
                    ApplicationArea = All;
                    Caption = 'Tipe Sekolah';
                }
                field(namaSekolah; Rec.namaSekolah)
                {
                    ApplicationArea = All;
                    Caption = 'Nama Sekolah';
                }
                field(startDate; Rec.startDate)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(endDate; Rec.endDate)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                field(lineNumber;Rec.lineNumber)
                {
                    ApplicationArea = All;
                    Caption = 'Line Number';
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