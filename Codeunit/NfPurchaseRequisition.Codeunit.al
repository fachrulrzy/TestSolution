codeunit 50601 PurchaseRequisitionCodeunit
{
    procedure ColorStatus(head: Record HeaderPurchaseRequisition): Text[50]
    var
        myInt: Integer;
    begin
        if head.Status = head.Status::Open then begin
            exit('favorable');
        end else begin
            exit('strong');
        end;
        // with head do
        //     case Status of
        //         Status::Open:
        //             exit('favorable');
        //         Status::Released:
        //             exit('strong');
        //     end;
    end;

    procedure ChangeStatusToRelease(head: Record HeaderPurchaseRequisition)
    var
        line: Record "Purchase Requsition Line";
    begin
        line.SetRange("Document No.", head."No.");
        line.SetFilter("Line Amount", '<>%1', 0);
        if line.FindSet() then begin
            if (head.Status = head.Status::Open) then begin
                head.Status := head.Status::Released;
                head.Modify();
            end;
        end else 
        Error('line amount empty!');
    end;

    procedure ChangeStatusToOpen(head: Record "HeaderPurchaseRequisition")
    var
        myInt: Integer;
    begin
        if (head.Status = head.Status::Released) then begin
            head.Status := head.Status::Open;
            head.Modify();
        end;
    end;

    procedure DeleteSelectedRows(var Recs: Record "Purchase Requsition Line")
    var
        Rec: Record "Purchase Requsition Line";
    begin
        Recs.CopyFilters(Rec);
        if Recs.FindSet() then begin
            repeat begin
                Recs.Delete();
            end until Recs.Next() = 0;
        end;
    end;

    [IntegrationEvent(false, false)]
    procedure OnPurposeLineChanged(line: Text[100])
    begin
    end;


    // lines: Record "Purchase Requsition Line";
}