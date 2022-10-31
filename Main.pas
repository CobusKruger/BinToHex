unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Math;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    lblDesimaal: TLabel;
    Label4: TLabel;
    lblHexadesimaal: TLabel;
    edtBinary: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ///  Om van binêr na hex te gaan, gaan ons eers van binêr na desimaal, en dan
  ///  van desimaal na hex. Ons gebruik hierdie veranderlikes vir die drie waardes
  sBinary: string;       // Die invoer waarde
  iDesimaal: Integer;    // Desimale waarde
  sHex: string;          // Die uitvoer waarde
  ///  Vir ons for loops
  iCounter: Integer;
  ///  Vir elke bit in ons binary, wil ons drie dinge hê:
  ///  Die Integer waarde vir daardie bit (want ons moet somme doen)
  ///  Die mag van twee waarmee ons maal (sien onder)
  ///  En die desimale waarde van daardie bit. As ons al die bits se waardes
  ///  bymekaartel, het ons die waarde van die hele binêre getal
  iBit: Integer;
  iMagVanTwee: Integer;
  iBitWaardeInDesimaal: Integer;
  ///  Vir elke hex digit wat ons probeer uitwerk, benodig ons die volgende:
  ///  Die antwoord van ons deelsom (sien onder)
  ///  Die res-waarde van die deelsom
  ///  Die Hex-waarde van daardie digit.
  iDeelsomAntwoord: Integer;
  iResWaarde: Integer;
  sHexDigit: string;
begin
  ///  Ons stel die drie aanvanklike waardes. Die binêr kry ons by die edit box,
  ///  en die ander twee is leeg
  sBinary := edtBinary.Text;
  iDesimaal := 0;
  sHex := '';

  //////////////////////
  ///  Binêr na desimaal
  //////////////////////
  ///  Ek wil 'n binêre getal omskakel na desimaal, bv. 1011
  ///  Om dit reg te kry, moet ek elke bit maal met 'n mag van 2
  ///  en daardie mag word bepaal deur ons posisie in die string.
  ///  Vir 1011 is my digits 1, 0, 1, en 1. Ons maal hulle so:
  ///  (1 × 2^3) + (0 × 2^2) + (1 × 2^1) + (1 × 2^0)
  ///  waar 2^3 beteken "2 tot die mag 3", ens.
  ///
  ///  Let op na die magte van twee. Dit lyk rof, maar eintlik tel
  ///  ons maar net terug van 3 na 0.
  ///  Vir enige binêre getal kan ons aanvaar die grootste mag van
  ///  twee wat ons gaan nodig hê is een kleiner as die lengte van
  ///  die string.
  ///  So vir 1011 het ons 4 bits, en 'n maksimum mag van 3.
  iMagVanTwee := Length(sBinary) - 1;

  ///  Nou stap ons deur die karakters van sBinary. Elke karakter
  ///  stel 'n bit voor.
  for iCounter := 1 to Length(sBinary) do
    begin
      ///  Kry eers die Integer weergawe van daardie bit
      iBit := StrToInt(sBinary[iCounter]);
      ///  Werk die desimale waarde van die bit uit. Ons gebruik Power
      ///  om 2 te verhef tot 'n mag, en Round omdat die Power funksie
      ///  net met Real werk. Ook, onthou dat Power in die Math unit is,
      ///  en ek het dit bygesit in my uses clause.
      iBitWaardeInDesimaal := iBit * Round(Power(2, iMagVanTwee));
      ///  Nou tel ons die bit waarde by ons totaal
      iDesimaal := iDesimaal + iBitWaardeInDesimaal;
      ///  Laastens, trek 1 af van iMagVanTwee, want elke bit moet met
      ///  'n kleiner mag van twee gemaal word.
      Dec(iMagVanTwee);
    end;

    /// Nou weet ons wat die desimale waarde van ons binêre getal is.
    lblDesimaal.Caption := IntToStr(iDesimaal);

    /////////////////////////////
    ///  Desimaal na hexadesimaal
    /////////////////////////////
    ///  Hier moet ons deel deur 16, en die res hou
    ///  Onthou dat Integer nie / gebruik om te deel nie, maar div
    ///  Om die res te kry, gebruik ons mod.
    ///
    ///  Gestel my desimale waarde is 8250. Die hex waarde is 203A
    ///  Hier is hoe ons dit kry:
    ///
    ///  8250 mod 16 = 10, en 8250 div 16 = 515
    ///  Onthou die res (10). In hex is dit A, so ons sit A voor-aan
    ///  sHex by. Nou is sHex = 'A'
    ///
    ///  Doen die som weer, met 515:
    ///  515 mod 16 = 3, en 515 div 16 = 32
    ///  Onthou die res (3). In hex is dit 3, so ons sit 3 voor-aan
    ///  sHex by. Nou is sHex = '3A'
    ///
    ///  Doen die som weer, met 32:
    ///  32 mod 16 = 0, en 32 div 16 = 2
    ///  Onthou die res (0). In hex is dit 0, so ons sit 0 voor-aan
    ///  sHex by. Nou is sHex = '03A'.
    ///
    ///  Doen die som weer, met 2:
    ///  2 mod 16 = 0, en 2 div 16 = 0
    ///  Onthou die res (2). In hex is dit 2, so ons sit 2 voor-aan
    ///  sHex by. Nou is sHex = '203A'.
    ///  Omdat ons by nul uitgekom het, stop ons nou hier.
    ///
    ///  Die beste om te gebruik is 'n while-loop, want ons wil stop
    ///  wanneer ons nie meer deur 16 kan deel nie.
    ///  Binne-in die loop wil ons veranderlikes hê vir die volgende:
    ///  1. Die res, wat ons hex-digit gaan bepaal.
    ///  2. Die hex-digit self. Vir waardes <= 9, is dit net IntToStr
    ///     van die res. 'n Res van 10 word 'A', 'n res van 11 word 'B',
    ///     ensovoorts. Ek gaan 'n case-statement hiervoor gebruik.
    ///  3. Die antwoord van ons deelsom, wat ons gaan gebruik om weer
    ///     die som te doen in die volgende keer wat die while uitvoer.

    ///  Soos met elke while-loop, moet ek my control variable 'n waarde
    ///  gee voor die loop, en verander binne die loop. Ek gebruik
    ///  iDeelsomAntwoord as control variable, en gaan vir hom as
    ///  aanvanklike waarde gelyk maak aan iDesimaal, want dis die waarde
    ///  wat ek wil omskakel.
    iDeelsomAntwoord := iDesimaal;

    ///  Onthou, ons wil aanhou met die berekening totdat ons by 0 uitkom
    while iDeelsomAntwoord <> 0 do
    begin
      iResWaarde := iDeelsomAntwoord mod 16;
      case iResWaarde of
        15: sHexDigit := 'F';
        14: sHexDigit := 'E';
        13: sHexDigit := 'D';
        12: sHexDigit := 'C';
        11: sHexDigit := 'B';
        10: sHexDigit := 'A';
      else
        /// Vir kleiner waardes, gebruik net IntToStr
        sHexDigit := IntToStr(iResWaarde);
      end;

      /// Nou sit ons die nuwe sHexDigit waarde voor-aan sHex by
      sHex := sHexDigit + sHex;

      ///  Deel iDeelsomAntwoord deur 16 en begin die berekening weer.
      ///  Hierdie is ook waar ek my control variable verander om
      ///  seker te maak die while loop hou nie vir ewig aan nie.
      iDeelsomAntwoord := iDeelsomAntwoord div 16;
    end;

    ///  Uiteindelik weet ons wat die hex-waarde is van die binêre getal
    ///  wat ons in sBinary gehad het.
    lblHexadesimaal.Caption := sHex;
end;

end.
