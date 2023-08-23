table 50600 "Sales Order Table"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;nomor; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'nomor';
        }
        field(2;Sales; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales';
        }
    }
    
    keys
    {
        key(Key1; nomor)
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