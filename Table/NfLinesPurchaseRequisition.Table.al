table 50605 "Purchase Requsition Line"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }
        field(2; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Items;
        }
        field(4; "No. Item"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Desc; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(6; "Direct Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Quantity; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Item';
        }
        field(8; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Line No.", "Document No.")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
        line: Record "Purchase Requsition Line";
        lineNo: integer;
    
    trigger OnInsert()
    var
        lastNo: integer;
    begin
        line.SetRange("Document No.", Rec."Document No.");
        if line.FindLast() then begin
            // Rec.Init();
            Rec."Line No." := line."Line No." + 10000;
        end else begin
            Rec."Line No." := 10000;
        end;
        "Line Amount" := "Direct Unit Cost" * Quantity;

        // if not line.IsEmpty() then
        // begin
        //     LastNo := line."Line No.";
        //     if LastNo = 0 then
        //         LastNo := 1
        //     else
        //         LastNo := LastNo + 10000;
            
        //     line."Line No." := LastNo;
        // end;
    end;
    
    trigger OnModify()
    begin
        "Line Amount" := "Direct Unit Cost" * Quantity;
    end;
    
    trigger OnDelete()
    begin

    end;
    
    trigger OnRename()
    begin
        
    end;

}