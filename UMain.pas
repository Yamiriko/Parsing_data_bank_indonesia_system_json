unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, System.Net.HttpClientComponent,
  System.Net.URLClient, System.Net.HttpClient, System.NetConsts,
  System.JSON, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure tampil_data;
    procedure DesainTabel;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DesainTabel;
  tampil_data;
end;

procedure TForm1.DesainTabel;
var
  i : Integer;
begin
  with StringGrid1 do begin
    for i := 0 to RowCount - 1 do
    Rows[i].Clear;
    RowCount := 2;
    ColCount := 3;
    FixedCols := 1;
    FixedRows := 1;
    ScrollBars := ssBoth;

    Cells[0,0]:='No.';
    Cells[1,0]:='Kode Bank';
    Cells[2,0]:='Nama Bank';

    ColWidths[0]:=50;
    ColWidths[1]:=120;
    ColWidths[2]:=300;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  DesainTabel;
  tampil_data;
end;

procedure TForm1.tampil_data;
var
  HTTPClient: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONString: string;
  JSONObject: TJSONObject;
  DataArray: TJSONArray;
  Item: TJSONValue;
  Status, MessageText: string;
  Kode, Uraian: string;
  i : Integer;
  DataObject: TJSONObject;
begin
  HTTPClient := TNetHTTPClient.Create(nil);
  try
    try
      // Lakukan permintaan GET ke endpoint
      Response := HTTPClient.
      Get('https://bios.kemenkeu.go.id/api/ws/ref/bank');

      // Periksa apakah permintaan berhasil
      if Response.StatusCode = 200 then
      begin
        // Dapatkan JSON string dari respons
        JSONString := Response.ContentAsString;

        // Mengurai JSON string menjadi objek JSON
        JSONObject := TJSONObject.ParseJSONValue(JSONString) as TJSONObject;

        try
          // Proses atau tampilkan hasilnya sesuai kebutuhan Anda
          // Misalnya, tampilkan daftar bank
          if Assigned(JSONObject) then
          begin
            // Lakukan sesuatu dengan JSONObject di sini
            Status := JSONObject.GetValue('status').Value;
            MessageText := JSONObject.GetValue('message').Value;

            // Ambil array data
            DataArray := JSONObject.GetValue('data') as TJSONArray;
            StringGrid1.RowCount:=DataArray.Count + 1;
            for i := 0 to DataArray.Count - 1 do begin
              // Ambil objek data
              DataObject := DataArray.Items[i] as TJSONObject;

              // Ambil nilai properti objek data
              Kode := DataObject.GetValue('kode').Value;
              Uraian := DataObject.GetValue('uraian').Value;

              with StringGrid1 do begin
                Cells[0,i + 1] := IntToStr(i + 1)+'.';
                Cells[1, i + 1] := Kode;
                Cells[2, i + 1] := Uraian;
              end;
            end;
            StatusBar1.Panels[0].Text:='Pesan Sistem : ' +
            Status + ', ' + MessageText + ', jumlah data : ' +
            IntToStr(DataArray.Count) + ' baris';
          end;
        finally
          JSONObject.Free;
        end;
      end
      else
      begin
        ShowMessage('Failed to retrieve data. Status Code: ' + IntToStr(Response.StatusCode));
      end;
    except
      on E: Exception do
      begin
        ShowMessage('Error: ' + E.Message);
      end;
    end;
  finally
    HTTPClient.Free;
  end;
end;

end.
