page 50601 xpressionCarddd
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Open Sales Order';
    SourceTable = "Sales Order Table";
    
    layout
    {
        area(Content)
        {
            group(Input)
            {
                Caption = 'Input';
                field(Sales;Rec.Sales)
                {
                    ApplicationArea = All;
                    Caption = 'Sales';
                    TableRelation = "Sales Header";
                    
                    trigger OnValidate()
                    var
                        salesRec: Record "Sales Header";
                    begin
                        if salesRec.Get(Rec.Sales) then 
                            Rec.Sales := salesRec."Sell-to Customer Name";
                    end;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                Caption = 'Execute';
                ToolTip = 'Click to calculate';
                Image = ExecuteBatch;
                
                trigger OnAction()
                begin
                end;
            }
        }
    }
    
    var
        Value1 : Text[100];
}