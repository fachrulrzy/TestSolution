table 50603 HeaderPurchaseRequisition
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2;"Purpose/Reasoning"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, Released;
        }
        field(5; Note; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "No.")
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
    var
        HeaderRec: Record HeaderPurchaseRequisition;
        LineRec: Record "Purchase Requsition Line";
    begin
        LineRec.SetRange("Document No.", Rec."No.");
        LineRec.DeleteAll();
    end;
    
    trigger OnRename()
    begin
        
    end;
}