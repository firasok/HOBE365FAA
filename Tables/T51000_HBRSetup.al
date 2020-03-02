table 51000 "HBR Setup"
//<NCO>
// Table used for setup related to HBR specific changes
//</NCO>
{
  Caption = 'Label Printer 1';
  DataClassification = ToBeClassified;

  fields
  {
    field(1;"Primary Key";Code[10])
    {
      DataClassification = ToBeClassified;
    }
    field(300;"Budget Responsible";code[50])
    {
      Caption = 'Budget Responsible';
      DataClassification = EndUserIdentifiableInformation;
      NotBlank = true;
      TableRelation = user."User Name";
      ValidateTableRelation = false;
    }
    field(200;"Vehicle No. Series";Code[20])
    {
      Caption = 'Vehicle No. Series';
      DataClassification = EndUserIdentifiableInformation;
      NotBlank = true;
      TableRelation = "No. Series";
      ValidateTableRelation = false;
    }
    field(400;"File Name";Text[1024])
    {
      Caption = 'File Name';
      DataClassification = EndUserIdentifiableInformation;

      trigger OnLookup()var FileManagement: Codeunit "File Management";
      begin
        "File Name":=FileManagement.OpenFileDialog('File Name', "File Name", '');
      end;
    }
    field(410;"Label Printer 1";Text[1024])
    {
      Caption = 'Label Printer 1';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(420;"Label Printer 2";Text[1024])
    {
      Caption = 'Label Printer 2';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(430;"Label Printer 3";Text[1024])
    {
      Caption = 'Label Printer 3';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(440;"Label Printer 4";Text[1024])
    {
      Caption = 'Label Printer 4';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(450;"Label Printer 5";Text[1024])
    {
      Caption = 'Label Printer 5';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(460;"Label Printer 6";Text[1024])
    {
      Caption = 'Label Printer 6';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(470;"Label Printer 7";Text[1024])
    {
      Caption = 'Label Printer 7';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(480;"Label Printer 8";Text[1024])
    {
      Caption = 'Label Printer 8';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(490;"Label Printer 9";Text[1024])
    {
      Caption = 'Label Printer 9';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(500;"Label Printer 10";Text[1024])
    {
      Caption = 'Label Printer 10';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(510;"Label Printer 11";Text[1024])
    {
      Caption = 'Label Printer 11';
      DataClassification = EndUserIdentifiableInformation;
    }
    field(520;"Label Printer 12";Text[1024])
    {
      Caption = 'Label Printer 12';
      DataClassification = EndUserIdentifiableInformation;
    }
  }
  keys
  {
    key(PK;"Primary Key")
    {
      Clustered = true;
    }
  }
  var myInt: Integer;
  trigger OnInsert()begin
  end;
  trigger OnModify()begin
  end;
  trigger OnDelete()begin
  end;
  trigger OnRename()begin
  end;
  procedure IsBudgetResponsible(InputUserID: code[50]): Boolean var myInt: Integer;
  begin
    if "Budget Responsible" = '' then GET;
    if "Budget Responsible" = '' then exit(true)
    else
      exit("Budget Responsible" = InputUserID);
  end;
}
