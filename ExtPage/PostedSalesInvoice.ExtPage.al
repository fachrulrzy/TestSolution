pageextension 50600 ExtPagePSI extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
    }
    
    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action("Report Preview Fachrul")
            {
                Caption = 'Report Preview Fachrul';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Category6;
                Image = PreviewChecks;
                Visible = not IsOfficeAddin;

                trigger OnAction()
                var
                
                    po: Report "Ext Report Fachrul";
                    IsHandled: Boolean;
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    Report.RunModal(50205, true, false, SalesInvHeader);
                    // IsHandled := false;
                    // OnBeforeSalesInvHeaderPrintRecords(SalesInvHeader, IsHandled);
                    // if not IsHandled then
                        // SalesInvHeader.PrintRecords(true);
                    // CurrPage.SetSelectionFilter(SalesInvHeader);
                    // po.setparm(Rec."No.");
                end;
            }
        }
    }
    
    var
        myInt: Integer;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSalesInvHeaderPrintRecords(var SalesInvHeader: Record "Sales Invoice Header"; var IsHandled: Boolean)
    begin
    end;
}