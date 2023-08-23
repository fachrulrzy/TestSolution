page 50606 "Lines"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No. Item"; Rec."No. Item")
                {
                    ApplicationArea = All;
                    TableRelation = Item;

                    trigger OnValidate()
                    var
                        itemRec: Record Item;
                        itemPage: Page "Item List";
                    begin
                        if itemRec.Get(Rec."No. Item") then begin
                            Rec.Desc := itemRec.Description;
                        end;

                    end;
                }
                field(Desc; Rec.Desc)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Rec."Line Amount" := Rec."Direct Unit Cost" * Rec.Quantity;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Rec."Line Amount" := Rec."Direct Unit Cost" * Rec.Quantity;
                    end;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        // addfirst(factboxes)
        // {
        //     part(ItemPicture; item)
        // }
    }

    actions
    {
        area(Processing)
        {
            action("Delete Record")
            {
                ApplicationArea = All;
                Image = DeleteRow;
                ToolTip = 'Delete selected row';

                trigger OnAction()
                var
                    Lines: Record "Purchase Requsition Line";
                    SelectionFilterManagement: Codeunit SelectionFilterManagement;
                    RecRef: RecordRef;
                begin
                    Lines.Reset();
                    CurrPage.SetSelectionFilter(Lines);
                    RecRef.GetTable(Lines);
                    // Message(SelectionFilterManagement.GetSelectionFilter(RecRef, Lines.FieldNo("Line No.")));
                    SelectionFilterManagement.GetSelectionFilter(RecRef, Lines.FieldNo("Line No."));
                    if Lines.FindSet() then begin
                        repeat begin
                            Lines.Delete();
                        end until Lines.Next() = 0;
                    end;

                    // FieldId := Lines.FieldNo("Line No.");
                    // while FieldId <> 0 do begin
                    //     Message(SelectionFilterManagement.GetSelectionFilter(RecRef, FieldId));
                    // end;

                    // SalesHeader.Reset();
                    // CurrPage.SetSelectionFilter(SalesHeader);
                    // RecRef.GetTable(SalesHeader);

                    // FieldId := SalesHeader.FIELDINDEX("YourField1");
                    // WHILE FieldId <> 0 DO BEGIN
                    //     SelectionFilterManagement.RemoveSelectionFilter(RecRef, FieldId);
                    //     FieldId := SalesHeader.FIELDINDEX("YourField2");
                    // END;

                    // SalesHeader.MODIFY;


                    // Message('%1', Rec."Line No.");
                    // Rec.Delete();
                    // Rec.Modify();
                end;
            }
        }
    }

    var
        myInt: Integer;

}