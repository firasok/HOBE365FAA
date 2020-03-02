
 dotnet
{
     assembly(System)
    {
        type(System.Diagnostics.Process; processDLL) { }
    }
} 


codeunit 51102 "Label Printer Managment"
{
  trigger OnRun();
  var begin
  end;
  procedure LabelItemBarcode(pItemNo: code[20];
  pDescription: Text[50];
  pVarientCode: code[20];
  pLabelCount: Integer;
  PrinterNo: Option SVNAVLA3, SVNAVLA4, SVNAVLA6, SVNAVLA9, SVNAVLA10, SVNAVLA11, SVNAVLA12)var labelCount: Integer;
  itemRec: Record item;
  itemVariant: Record "Item Variant";
  ItemNo: code[20];
  VarientCode: code[20];
  i: Integer;
  Text001: Label 'Item No.: ';
  Text002: Label 'placeringnr.: ';
  Test003: Label 'Size: ';
  begin
    ItemNo:=pItemNo;
    VarientCode:=pVarientCode;
    labelCount:=pLabelCount;
    if pItemNo <> '' then begin
      itemRec.get(ItemNo);
      if VarientCode <> '' then begin
        if itemVariant.get(itemRec."No.", VarientCode)then variantText:=Test003 + itemVariant.Code
        ELSE
          CLEAR(VariantText);
      end;
    end
    else
      exit;
    PrintLabel(PrinterNo);
    if not HBRsetup.get then HBRsetup.init;
    if(labelCount = 0)then labelCount:=1;
    FOR i:=1 TO labelCount DO BEGIN
      LabelCreated:=TRUE;
      clientFileName:=HBRsetup."File Name" + 'label.prn';
      servierFileName:=fileManagment.ServerTempFileName('label.prn');
      tmpBlob.CreateOutStream(OutStr);
      OutStr.WriteText(Special2 + 'm' + CR + LF);
      OutStr.WriteText(Special2 + 'L' + CR + LF);
      OutStr.WriteText('H20' + CR + LF);
      OutStr.WriteText('D11' + CR + LF);
      OutStr.WriteText('191100302000100' + Text001 + itemRec."No." + ' ' + variantText + CR + LF);
      OutStr.WriteText('191100201600100' + Text002 + ' ' + itemRec."Shelf No." + ' ' + CR + LF);
      OutStr.WriteText('191100401200100' + itemRec.Description + CR + LF);
      OutStr.WriteText('1A6209000100100' + itemRec."No." + CR + LF);
      OutStr.WriteText('' + CR + LF);
      OutStr.WriteText('E' + CR + LF);
      fileManagment.BLOBExportToServerFile(tmpBlob, servierFileName);
      fileManagment.CopyServerFile(servierFileName, clientFileName, true);
    End;
    //Process
    PrintDocument(clientFileName, labelCount);
    LabelFileClose();
  end;
  procedure LabelFileClose()var begin
    fileManagment.DeleteServerFile(servierFileName);
    fileManagment.DeleteClientFile(clientFileName);
  end;
  procedure PrintLabel(PrinterNo: Option SVNAVLA3, SVNAVLA4, SVNAVLA6, SVNAVLA9, SVNAVLA10, SVNAVLA11, SVNAVLA12)var begin
    if not HBRsetup.get then HBRsetup.Init;
    CASE PrinterNo OF //PrinterNo::SVNAVLA3:
    1: BEGIN
      HBRsetup.TESTFIELD("Label Printer 3");
      selectedPrinter:=HBRsetup."Label Printer 3";
    END;
    //PrinterNo::SVNAVLA4:
    2: BEGIN
      HBRsetup.TESTFIELD("Label Printer 4");
      selectedPrinter:=HBRsetup."Label Printer 4";
    END;
    //PrinterNo::SVNAVLA6:
    3: BEGIN
      HBRsetup.TESTFIELD("Label Printer 6");
      selectedPrinter:=HBRsetup."Label Printer 6";
    END;
    //PrinterNo::SVNAVLA9:
    4: BEGIN
      HBRsetup.TESTFIELD("Label Printer 9");
      selectedPrinter:=HBRsetup."Label Printer 9";
    END;
    //PrinterNo::SVNAVLA10:
    5: BEGIN
      HBRsetup.TESTFIELD("Label Printer 10");
      selectedPrinter:=HBRsetup."Label Printer 10";
    END;
    //PrinterNo::SVNAVLA11:
    6: BEGIN
      HBRsetup.TESTFIELD("Label Printer 11");
      selectedPrinter:=HBRsetup."Label Printer 11";
    END;
    //PrinterNo::SVNAVLA12:
    7: BEGIN
      HBRsetup.TESTFIELD("Label Printer 12");
      selectedPrinter:=HBRsetup."Label Printer 12";
    END;
    //PrinterNo::SVNAVLA6:
    8: BEGIN
      HBRsetup.TESTFIELD("Label Printer 6");
      selectedPrinter:=HBRsetup."Label Printer 6";
    END;
    //PrinterNo::SVNAVLA9:
    9: BEGIN
      HBRsetup.TESTFIELD("Label Printer 9");
      selectedPrinter:=HBRsetup."Label Printer 9";
    END;
    //PrinterNo::SVNAVLA10:
    10: BEGIN
      HBRsetup.TESTFIELD("Label Printer 10");
      selectedPrinter:=HBRsetup."Label Printer 10";
    END;
    //PrinterNo::SVNAVLA11:
    11: BEGIN
      HBRsetup.TESTFIELD("Label Printer 11");
      selectedPrinter:=HBRsetup."Label Printer 11";
    END;
    //PrinterNo::SVNAVLA12:
    12: BEGIN
      HBRsetup.TESTFIELD("Label Printer 12");
      selectedPrinter:=HBRsetup."Label Printer 12";
    END;
    END;
  end;
  procedure LabelInitializer()var begin
    Special2[1]:=2;
    Special66[1]:=66;
    CR[1]:=13;
    clientFileName:='label.prn';
    labelCounter:=1;
    labelCreated:=FALSE;
  end;
  LOCAL procedure PrintDocument(Path: Text;
  pNoOfLabels: integer)var NoOfLabels: Integer;
  i: Integer;
  begin
    NoOfLabels:=pNoOfLabels;
    Process:=Process.Process;
    Process.StartInfo.UseShellExecute:=FALSE;
    Process.StartInfo.FileName:='cmd.exe';
    Process.StartInfo.Arguments:=STRSUBSTNO('/c type %1 > ' + selectedPrinter, Path);
    Process.StartInfo.CreateNoWindow:=TRUE;
    for i:=1 to NoOfLabels do Process.Start();
    CLEAR(Process);
  end;
  var HBRsetup: Record "HBR Setup";
  fileManagment: Codeunit "File Management";
  process: DotNet ProcessDLL;
  Special2: Text[1];
  Special66: Text[1];
  CR: Text[1];
  LF: Text[1];
  variantText: text[30];
  itemVendorText: text[30];
  printFileName: Text[250];
  selectedPrinter: text[250];
  labelCounter: Integer;
  labelCreated: Boolean;
  InStr: InStream;
  OutStr: OutStream;
  tmpBlob: Codeunit "Temp Blob";
  clientFileName: Text;
  servierFileName: Text;
  BoolVar: Boolean;
}
