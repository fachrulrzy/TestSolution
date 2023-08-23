table 50607 "Tabel Bio"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; no; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nomor';
        }
        field(2; nama; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Nama';
        }
        field(3; jenisKelamin; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "laki-laki",perempuan;
            Caption = 'Kelamin';
        }
        field(4; jobTitle; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Wiraswasta,PNS,"karyawan swasta",dll;
            Caption = 'Job Title';
        }
        field(5; rateGaji; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Rate Gaji';
        }
        field(6; address; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address';
        }
        field(7; statusPerkawinan; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Status Perkawinan';
        }
    }

    keys
    {
        key(Key1; no)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        noValid: Boolean;
        jobValid: Option;
    begin
        noValid := no <> '';
        if not noValid then
        begin
            Error('Field "no" harus diisi.');
        end
        else
        begin
            // logika lainnya saat insert
        end;
    end;

    trigger OnModify()
    var
        noValid: Boolean;
    begin
        noValid := no <> '';
        if not noValid then
        begin
            Error('Field "no" harus diisi.');
        end
        else
        begin
            // logika lainnya saat modify
        end;
    end;

    // end;

    // trigger OnDelete()
    // begin

    // end;

    // trigger OnRename()
    // begin

    // end;

}