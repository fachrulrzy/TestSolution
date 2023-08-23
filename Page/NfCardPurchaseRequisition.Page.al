page 50603 "Card Purchase Requsition"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = HeaderPurchaseRequisition;

    layout
    {
        area(Content)
        {
            group("Purchase Requsition")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Purpose/Reasoning"; Rec."Purpose/Reasoning")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Publisher: Codeunit PurchaseRequisitionCodeunit;
                    begin
                        Publisher.OnPurposeLineChanged(Rec."Purpose/Reasoning");
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;

                    trigger OnValidate()
                    var
                    begin
                        StyleExprTxt := PQCodeUnit.ColorStatus(Rec);
                    end;
                }
                field(Note; Rec.Note)
                {
                    ApplicationArea = All;
                }
            }

            part("line"; Lines)
            {
                SubPageLink = "Document No." = field("No.");
                ApplicationArea = All;
                UpdatePropagation = SubPart;
            }
        }
        area(FactBoxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = All;
                Caption = 'Picture';
                Provider = line;
                SubPageLink = "No." = field("No. Item");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachements';
                Provider = line;
                SubPageLink = "Table ID" = const(Database::Item),
                              "No." = field("No. Item");
            }
            part(NFItemPicture; "NF Item Picture Gallery")
            {
                ApplicationArea = All;
                Provider = line;
                SubPageLink = "Item No." = field("No. Item");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("U&pdate Status")
            {
                ApplicationArea = All;
                Caption = 'U&pdate Status';
                Image = UpdateDescription;

                trigger OnAction();
                begin
                    PQCodeUnit.ChangeStatusToRelease(Rec);
                    CurrPage.Close();
                end;
            }
            action("U&ndo Status")
            {
                ApplicationArea = All;
                Caption = 'U&ndo Status';
                Image = Undo;

                trigger OnAction();
                begin
                    PQCodeUnit.ChangeStatusToOpen(Rec);
                    CurrPage.Close();
                end;
            }
            action("Clear Data")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    lines: Record "Purchase Requsition Line";
                begin
                    lines.DeleteAll();
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
        myInt: Integer;
        StyleExprTxt: Text[50];
        PQCodeUnit: Codeunit PurchaseRequisitionCodeunit;
}