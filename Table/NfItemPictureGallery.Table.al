table 50604 ItemPictureGallery
{
    Caption = 'Item Picture Gallery';
    // Klasifikasi Data
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Item Picture No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        // buat nyimpen gambar. bisa juga nyimpen audio, video dll
        //   yang disimpen itu hanya referensinya ajah, filenya mah
        //   ada di cloud
        field(3; Picture; MediaSet)
        {
            DataClassification = CustomerContent;
        }
        // buat nampilin jumlah gambarnya
        field(4; Sequencing; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        // satu PK satulagi FK
        key(Key1; "Item No.", "Item Picture No.")
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