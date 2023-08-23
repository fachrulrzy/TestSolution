page 50605 "List Purchase Requisition"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = HeaderPurchaseRequisition;
    CardPageId = "Card Purchase Requsition";
    Caption = 'List Purchase Requisition';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Purpose/Reasoning"; Rec."Purpose/Reasoning")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                    // trigger OnValidate()
                    // var
                    // begin
                    //     StyleExprTxt := PQCodeUnit.ColorStatus(Rec);
                    // end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        // area(Factboxes)
        // {

        // }
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

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := PQCodeUnit.ColorStatus(Rec);
    end;

    var
        PQCodeUnit: Codeunit PurchaseRequisitionCodeunit;
        StyleExprTxt: Text[50];
}