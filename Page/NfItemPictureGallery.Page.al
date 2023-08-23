page 50604 "NF Item Picture Gallery"
{
    Caption = 'Item Picture Gallery';
    PageType = CardPart;
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    SourceTable = ItemPictureGallery;
    
    layout
    {
        area(Content)
        {
            // Menampilkan jumlah gambar
            field(ImageCount; ImageCount)
            {
                ApplicationArea = All;
                ShowCaption = false;
                Editable = false;
            }
            // Menampilkan Gambar
            field(Picture;Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            // Untuk import gambar
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                begin
                    // menggunakan local procedure
                    ImportFromDevice();
                end;
            }
            // Tombol pindah gambar selanjutnya
            action(Next)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Image = NextRecord;
                
                trigger OnAction()
                begin
                    // geser pointer ke Rec selanjutnya
                    //   1 : pointer next
                    Rec.Next(1);
                end;
            }
            // Tombol pindah sebelumnya
            action(Previous)
            {
                ApplicationArea = All;
                Caption = 'Previous';
                Image = PreviousRecord;
                
                trigger OnAction()
                begin
                    // Geser pointer ke rec sebelumya
                    //   -1 : pointer previous
                    Rec.Next(-1);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                ToolTip = 'Delete the record.';
                
                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }

    // jalan setelah rec saat ini diperolah dari sumber data dan sebelum
    //   rec ditampilkan
    trigger OnAfterGetCurrRecord()
    // fungsinya untuk menghitung jml gambar terkait dan ditampilkan melalui
    //   variabel 'ImageCount'
    var
        ItemPictureGallery: Record ItemPictureGallery;
    begin
        // reset menjadi string kosong
        ImageCount := '';
        // reset itu menghpaus filter dan curr key position to normal
        ItemPictureGallery.Reset();
        // Mengatur kisaran record yang akan diambil dari tabel 'ItemPictureGallery' berdasarkan
        //   nomor item yang sedang ditampilkan dalam halaman saat ini (Rec."Item No.")
        ItemPictureGallery.SetRange("Item No.", Rec."Item No.");
        if ItemPictureGallery.Count > 0 then
        // format fungsinya untuk merubah jenis data menjadi string
        //   biar masuk tuh datanya
            ImageCount := Format(Rec.Sequencing) + ' / ' + Format(ItemPictureGallery.Count)
        else
            ImageCount := '0 / 0';
    end;
    
    var
        DeleteImageQst: Label 'Are you sure want to delete the picture?';
        NothingDel: Label 'Nothing to delete';
        ImageCount: Text[50];

    local procedure DeleteItemPicture()
    begin
        if not Confirm(DeleteImageQst) then
            exit;
        if Rec.Get(Rec."Item No.", Rec."Item Picture No.") then begin
            // Clears the value of a single variable. Also, it clears all the filters that were set if the variable 
            //   is a record and resets the key to the primary key and the company on a record variable.
            Clear(Rec.Picture);
            // Delete record variabel
            Rec.Delete();
            // Reset atau benerin sequence
            ResetOrdering();
            //  penambahan 1 pada "Item Picture No." dimaksudkan untuk mengambil record gambar berikutnya 
            //   setelah record yang akan dihapus, sehingga proses penghapusan gambar-gambar dapat dilakukan 
            //   secara berurutan.
            if Rec.Get(Rec."Item No.", Rec."Item Picture No." - 1) then
                exit
            else
                ImageCount := '0 / 0'
        end else begin
            Message(NothingDel);
        end;
    end;

    local procedure ImportFromDevice()
    var
        Item: Record Item;
        ItemPictureGallery: Record ItemPictureGallery;
        // Instream : bagaikan pipa, misal alirkan file dari A -> B
        //   InStream harus dibuat jika mau up atau down load
        PictureInStream: InStream;
        // ini itu nama file yang didapet dari UploadIntoStream()
        FromFileName: Text;
        UploadFileMsg: Label 'Please select the image to upload';
    begin
        if Item.get(Rec."Item No.") then begin
            // upload dari local ke bc
            //  param : 1(DialogTitle, Title bar when open dialog), 
            //          2(FromFolder, path folder when open dialog)
            //          3(FromFilter, type of file)
            //          4(FromFile, file to uplaod to BC)
            //          5(NVInStream, InStream that's used to send file)
            if UploadIntoStream('UploadFileMsg', '', 'All FIles (*.*)|*.*', FromFileName, PictureInStream) then begin
                ItemPictureGallery.Init();
                ItemPictureGallery."Item No." := Item."No.";
                // buat nyari last item picture no, ntar ditambah 1
                //   ditambah satu karena dicari dulu gambar terakhir(ada atau ga) makanya diatmbah 1
                ItemPictureGallery."Item Picture No." := FindLastItemPictureNo(ItemPictureGallery."Item No.") + 1;
                ItemPictureGallery.Sequencing := ItemPictureGallery."Item Picture No.";
                // ini lebih spesifik tempat uploadnya
                //   ImportStream(stremnya, namafilenyah)
                ItemPictureGallery.Picture.ImportStream(PictureInStream, FromFileName);
                ItemPictureGallery.Insert();
                // Jika jumlah gambar dalam record ItemPictureGallery tidak sesuai dengan nilai Sequencing, 
                //   maka memanggil prosedur ResetOrdering() untuk merapikan ulang urutan gambar.
                if ItemPictureGallery.Count <> ItemPictureGallery.Sequencing then
                    ResetOrdering();
                // Pengambilan Gambar Berikutnya (Opsional):
                //   keknya cuma pindain pointer aja gasii
                // Mencoba mengambil record gambar berikutnya berdasarkan nomor item dan nomor urutan gambar 
                //   yang baru saja dimasukkan. Jika berhasil, prosedur dihentikan menggunakan exit.
                if Rec.Get(ItemPictureGallery."Item No.", ItemPictureGallery."Item Picture No.") then
                    exit;
            end;
        end;
    end;

    // mengatur ulang urutan gambar-gambar, kalo misal terjadi delete
    local procedure ResetOrdering()
    var
        ItemPictureGallery: Record ItemPictureGallery;
        Ordering: Integer;
    begin
        Ordering := 1;
        // clear all filter and all nav
        ItemPictureGallery.Reset();
        // Rec.ItemNo yang sedang aktip atau sedang diakses
        ItemPictureGallery.SetRange("Item No.", Rec."Item No.");
        // findFirst sesuai data yang di setrange
        if ItemPictureGallery.FindFirst() then
            repeat
                // sequencing = ordering = 1
                ItemPictureGallery.Sequencing := Ordering;
                // Ordering = Ordering + 1
                Ordering += 1;
                // Modify() untuk mengubah perubahannya
                ItemPictureGallery.Modify();
            // ulang terus sampe recordnya abiz
            until ItemPictureGallery.Next() = 0;
    end;

    local procedure FindLastItemPictureNo(ItemNo: Code[20]): Integer
    var
        ItemPictureGallery: Record ItemPictureGallery;
    begin
        // biasa direset filter dan pointernya
        ItemPictureGallery.Reset();
        // seperti filter, data yang dicari berdasarkan key ini
        ItemPictureGallery.SetCurrentKey("Item No.", "Item Picture No.");
        // diurutin dari yang terkecil
        ItemPictureGallery.Ascending(true);
        // filter kolom "item No." sesuai dengan ItemNo
        ItemPictureGallery.SetRange("Item No.", ItemNo);
        // cari record terakhir sesuai current key and filter
        //   kalo ada maka :
        if ItemPictureGallery.FindLast() then begin
            // kalo ada maka yaa bakal return "Item Picture No." paling akhir
            exit(ItemPictureGallery."Item Picture No.");
        end;
    end;
}