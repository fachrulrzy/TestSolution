table 50606 "Lines Prestasi"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;nama_prestasi; text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2;tingkat; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Kota,Kabupaten,Nasional,Internasionil;
        }
        field(3;penyelenggara; Code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(4;desc; text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5;juara; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6;lineNumberP; integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(7;pk; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        
    }
    
    keys
    {
        key(Key1; pk, lineNumberP)
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}