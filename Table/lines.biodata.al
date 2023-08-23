table 50602 "Lines Bio"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; num; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; tipeSekolah; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = SMA,SMP,SD;
        }
        field(3; namaSekolah; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; startDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; endDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; lineNumber; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }


    keys
    {
        key(Key1; num, lineNumber)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        if startDate > endDate then
        begin
            Error('Tanggal "endDate" tidak boleh kurang dari tanggal "startDate".');
        end;
    end;


    trigger OnModify()
    begin
        if startDate > endDate then
        begin
            Error('Tanggal "endDate" tidak boleh kurang dari tanggal "startDate".');
        end;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}