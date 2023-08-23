codeunit 50600 MySubscribers
{
    EventSubscriberInstance = StaticAutomatic;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::PurchaseRequisitionCodeunit, OnPurposeLineChanged, '', true, true)]
    procedure CheckPurposeLine(line: Text[100])
    begin
        if (StrPos(line, '+') > 0) then begin
            Message('gabole elobag');
        end;
    end;
}