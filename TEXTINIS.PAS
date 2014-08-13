(**
 * This unit contains a class ~TTextIniFile~ that implements
 * textual initialization files. The files are fully interface
 * compatible with those in the (Delphi) IniFiles unit, but they
 * provide some additional methods for reading and writing data
 * other than String, Integer, and Boolean.
 *
 * @author Joerg Pleumann &lt;pleumann&#64;uni-duisburg.de&gt;
 *
 * @version 15-May-98
 *)
unit TextInis;

{$H+,R-}

interface

uses
  SysUtils, Classes, Consts;

type

  (**
   * The TTextIniFile class implements textual initialization
   * files. The files are fully interface compatible with the ones
   * in the (Delphi) IniFiles unit, but provide some additional
   * methods for reading and writing data other than String,
   * Integer, and Boolean. The files do not use any operating
   * system stuff, so they works alike in OS/2 and Windows.
   * <p>
   * The files are divided into sections and identifiers, as
   * usual, but there is one exception: If a file contains a
   * section whose name is the empty string, it is written
   * without a section heading when the file is created. This
   * allows to use the class for 'flat' initialization files,
   * just specify the empty string as section identifier.
   * <p>
   * The class does not change data that is not affected by
   * a writing call, nor does it sort anything. That should
   * allow you to use it for most existing text-based
   * initialization files, since commentc etc. will not get
   * lost.
   *)
  TTextIniFile = class(TObject)
  private
    (**
     * Holds the fully qualified name of the file.
     *)
    FFileName: string;

    (**
     * Holds a string list of sections contained in
     * the file. The Objects[] array property holds
     * references to the string lists that hold the
     * identifiers and values of a section.
     *)
    FSections: TStringList;

    (**
     * Is True if the file has been changed since
     * is was last loaded, otherwiese False.
     *)
    FModified: Boolean;
  public

    (**
     * Loads the contents of an initialization file. If
     * the file does not exist, the object is empty.
     *
     * @see ~Destroy~
     *)
    constructor Create(const FileName: string);

    (**
     * Checks, whether the file has been ~modified~. If so,
     * the new contents are written. Afterwards, the object
     * is destroyed.
     *
     * @see ~Create~
     *)
    destructor Destroy; override;

    (**
     * Reads a string from the file. If either the given section
     * or the given identifier does not exist, the default value
     * is returned instead.
     *
     * @see ~WriteString~
     *)
    function ReadString(const Section, Ident, Default: string): string;

    (**
     * Writes a string value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadString~
     *)
    procedure WriteString(const Section, Ident, Value: String);

    (**
     * Reads an Integer value from the file. If either the given section
     * or the given identifier does not exist, or the value cannot be
     * converted to Integer, the default value is returned instead.
     *
     * @see ~WriteInteger~
     *)
    function ReadInteger(const Section, Ident: string; Default: LongInt): LongInt;

    (**
     * Writes an Integer value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadInteger~
     *)
    procedure WriteInteger(const Section, Ident: string; Value: LongInt);

    (**
     * Reads a Boolean value from the file. If either the given section
     * or the given identifier does not exist, or the value cannot be
     * converted to Boolean, the default value is returned instead.
     *
     * @see ~WriteBool~
     *)
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;

    (**
     * Writes a Boolean value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadBool~
     *)
    procedure WriteBool(const Section, Ident: string; Value: Boolean);

    (**
     * Reads an character value from the file. If either the given section
     * or the given identifier does not exist, or the value cannot be
     * converted to Char, the default value is returned instead.
     *
     * @see ~WriteChar~
     *)
    function ReadChar(const Section, Ident: string; Default: Char): Char;

    (**
     * Writes a character value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadChar~
     *)
    procedure WriteChar(const Section, Ident: string; Value: Char);

    (**
     * Reads an Currency value from the file. If either the given section
     * or the given identifier does not exist, or the value cannot be
     * converted to Currency, the default value is returned instead.
     *
     * @see ~WriteCurrency~
     *)
    function ReadCurrency(const Section, Ident: string; const Default: Currency): Currency;

    (**
     * Writes a Currency value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadCurrency~
     *)
    procedure WriteCurrency(const Section, Ident: string; Value: Currency);

    (**
     * Reads an floating point value from the file. If either the
     * given section or the given identifier does not exist, or the
     * value cannot be converted to Extended, the default value is
     * returned instead.
     *
     * @see ~WriteFloat~
     *)
    function ReadFloat(const Section, Ident: string; const Default: Extended): Extended;

    (**
     * Writes a floating point value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadFloat~
     *)
    procedure WriteFloat(const Section, Ident: string; Value: Extended);

    (**
     * Reads an date-and-time value from the file. If either the
     * given section or the given identifier does not exist, or
     * the value cannot be converted to TDateTime, the default
     * value is returned instead.
     *
     * @see ~WriteDateTime~
     *)
    function ReadDateTime(const Section, Ident: string; const Default: TDateTime): TDateTime;

    (**
     * Writes a date-and-time value to the file. If the destination
     * section does not exist, it is created. If a value with
     * the given identifier already exists, it is overwritten.
     *
     * @see ~ReadDateTime~
     *)
    procedure WriteDateTime(const Section, Ident: string; Value: TDateTime);

    (**
     * Reads binary data from the file. A maximum of Count bytes is read and
     * written to the given buffer. The function returns the number of
     * bytes actually contained in the desired identifier, that is, the
     * buffer size needed for reading all data. If either the given section
     * or the given identifier does not exist, 0 is returned. If a
     * conversion error occurs (since the function expects hex-coded,
     * comma-separated values), -1 is returned.
     *
     * @see ~WriteBinary~
     *)
    function ReadBinary(const Section, Ident: string; Buffer: Pointer; Count: LongInt): LongInt;

    (**
     * Writes binary data to the file. The data is taken from the given
     * Buffer, with Count specifying the number of bytes to write. The
     * bytes are written as a hex-coded, comma-separated list of values.
     * If the destination section does not exist, it is created. If a
     * value with the given identifier already exists, it is overwritten.
     *
     * @see ~ReadBinary~
     *)
    procedure WriteBinary(const Section, Ident: string; Buffer: Pointer; Count: LongInt);

    (**
     * Queries a list of all identifiers in the given section.
     * The identifiers are written to the given string object.
     *
     * @see ~ReadSections~, ~ReadSectionValues~, ~WriteSectionValues~
     *)
    procedure ReadSection(const Section: string; Strings: TStrings);

    (**
     * Queries a list of all sections in the initialization file.
     * The section names are written to the given string object.
     *
     * @see ~ReadSection~, ~ReadSectionValues~, ~WriteSectionValues~
     *)
    procedure ReadSections(Strings: TStrings);

    (**
     * Queries a list of all identifiers and values of a given section.
     * The identifiers and values are written to the given string object.
     * They are accessible via the Names[] and Values[] array
     * properties.
     *
     * @see ~ReadSection~, ~ReadSections~, ~WriteSectionValues~
     *)
    procedure ReadSectionValues(const Section: string; Strings: TStrings);

    (**
     * Writes a series of names and values to a given section.
     * The method takes all names contained in the string object
     * and writes their values to the given section. Old values
     * are overwritten.
     *
     * @see ~ReadSection~, ~ReadSections~, ~ReadSectionValues~
     *)
    procedure WriteSectionValues(const Section: string; Strings: TStrings);

    (**
     * Erases a section. If the given section does not exist,
     * nothing happens.
     *
     * @see ~DeleteKey~
     *)
    procedure EraseSection(const Section: string);

    (**
     * Erases an identifier from a section. If the given identifer
     * does not exist, nothing happens.
     *
     * @see ~EraseSection~
     *)
    procedure DeleteKey(const Section, Ident: String);

    (**
     * Holds the fully qualified name of the file.
     *)
    property FileName: string read FFileName;

    (**
     * Is True if the file has been changed since
     * is was last loaded, otherwiese False.
     *)
    property Modified: Boolean read FModified;
  end;

implementation

const
  DecToHex: array[0  .. 15] of Char = '0123456789ABCDEF';

  HexToDec: array['0'..'F'] of Byte = ( 0,  1,  2,  3,  4,  5,  6,  7,
                                        8,  9,  0,  0,  0,  0,  0,  0,
                                        0, 10, 11, 12, 13, 14, 15      );

constructor TTextIniFile.Create(const FileName: string);
var
  Strings, Section: TStringList;
  Line: string;
  I: Integer;
begin
  inherited Create;

  FFileName := ExpandFileName(FileName);
  FSections := TStringList.Create;

  Strings := TStringList.Create;

  if FileExists(FFileName) then
    Strings.LoadFromFile(FileName);

  Section := nil;

  try

    for I := 0 to Strings.Count - 1 do
    begin
      Line := Strings[I];
      if Line <> '' then
      begin
        if Line[1] = '[' then
        begin
          Line := Copy(Line, 2, Length(Line) - 2);
          Section := TStringList.Create;
          FSections.AddObject(Line, Section);
        end
        else
        begin
          if Section = nil then
          begin
            Section := TStringList.Create;
            FSections.AddObject('', Section);
          end;

          Section.Add(Line);
        end;
      end;
    end;

  finally
    Strings.Free;
  end;
end;

destructor TTextIniFile.Destroy;
var
  Strings: TStringList;
  I: Integer;
begin
  if FSections <> nil then
  begin
    if FModified then
    begin
      Strings := TStringList.Create;

      try
        for I := 0 to FSections.Count - 1 do
        begin
          if (I <> 0) or (FSections[I] <> '') then
            Strings.Add('[' + FSections[I] + ']');

          Strings.AddStrings(TStringList(FSections.Objects[I]));
          Strings.Add('');
        end;

        Strings.SaveToFile(FileName);

      finally
        Strings.Free;
      end;
    end;

    for I := 0 to FSections.Count - 1 do
      FSections.Objects[I].Free;

    FSections.Free;
  end;

  inherited Destroy;
end;

function TTextIniFile.ReadString(const Section, Ident, Default: string): string;
var
  I: Integer;
begin
  if Ident <> '' then
  begin
    I := FSections.IndexOf(Section);
    if I <> -1 then
    begin
      Result := TStrings(FSections.Objects[I]).Values[Ident];
      if Result <> '' then Exit;
    end;

    Result := Default;
  end
  else
    Result := '';
end;

procedure TTextIniFile.WriteString(const Section, Ident, Value: String);
var
  I: Integer;
begin
  if Ident <> '' then
  begin
    I := FSections.IndexOf(Section);
    if I = -1 then
    begin
      if Section = '' then
      begin
        FSections.InsertObject(0, Section, TStringList.Create);
        I := 0;
      end
      else
        I := FSections.AddObject(Section, TStringList.Create);
    end;

    TStringList(FSections.Objects[I]).Values[Ident] := Value;

    FModified := True;
  end;
end;

function TTextIniFile.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
begin
  Result := StrToIntDef(ReadString(Section, Ident, ''), Default);
end;

procedure TTextIniFile.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  WriteString(Section, Ident, IntToStr(Value));
end;

function TTextIniFile.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  Result := (ReadInteger(Section, Ident, Ord(Default)) <> 0);
end;

procedure TTextIniFile.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  if Value then
    WriteInteger(Section, Ident, 1)
  else
    WriteInteger(Section, Ident, 0);
end;

function TTextIniFile.ReadChar(const Section, Ident: string; Default: Char): Char;
var
  S: string;
begin
  S := ReadString(Section, Ident, Default);
  if (S <> '') then
    Result := S[1]
  else
    S := Default;
end;

procedure TTextIniFile.WriteChar(const Section, Ident: string; Value: Char);
begin
  WriteString(Section, Ident, Value);
end;

function TTextIniFile.ReadCurrency(const Section, Ident: string; const Default: Currency): Currency;
var
  S: string;
  E: LongInt;
begin
  S := ReadString(Section, Ident, '');
  Val(S, Result, E);
  if E <> 0 then Result := Default;
end;

procedure TTextIniFile.WriteCurrency(const Section, Ident: string; Value: Currency);
var
 S: string;
begin
  Str(Value, S);
  WriteString(Section, Ident, Trim(S));
end;

function TTextIniFile.ReadFloat(const Section, Ident: string; const Default: Extended): Extended;
var
  S: string;
  E: LongInt;
begin
  S := ReadString(Section, Ident, '');
  Val(S, Result, E);
  if E <> 0 then Result := Default;
end;

procedure TTextIniFile.WriteFloat(const Section, Ident: string; Value: Extended);
var
 S: string;
begin
  Str(Value, S);
  WriteString(Section, Ident, Trim(S));
end;

function TTextIniFile.ReadDateTime(const Section, Ident: string; const Default: TDateTime): TDateTime;
var
  Temp: string;
  Y, M, D, H, N, S: LongInt;
begin
  Temp := ReadString(Section, Ident, '');
  Y := StrToIntDef(Copy(Temp,  1, 4), 0);
  M := StrToIntDef(Copy(Temp,  6, 2), 0);
  D := StrToIntDef(Copy(Temp,  9, 2), 0);
  H := StrToIntDef(Copy(Temp, 12, 2), 0);
  N := StrToIntDef(Copy(Temp, 15, 2), 0);
  S := StrToIntDef(Copy(Temp, 18, 2), 0);

  try
    Result := EncodeDate(Y, M, D) + EncodeTime(H, N, S, 0);
  except
    Result := Default;
  end;
end;

procedure TTextIniFile.WriteDateTime(const Section, Ident: string; Value: TDateTime);
begin
  WriteString(Section, Ident, FormatDateTime('yyyy"/"mm"/"dd hh":"nn":"ss', Value));
end;

function TTextIniFile.ReadBinary(const Section, Ident: string; Buffer: Pointer; Count: LongInt): LongInt;
var
  Value: string;
  Bytes: PByteArray absolute Buffer;
  I: Integer;
  C: Char;
begin
  Value := ReadString(Section, Ident, '');

  Result := (Length(Value) + 1) div 3;

  if Count > Result then Count := Result;

  for I := 0 to Count - 1 do
  begin
    C := UpCase(Value[1 + 3 * I + 0]);
    if C in ['0'..'9', 'A'..'F'] then
      Bytes^[I] := HexToDec[C] shl 4
    else
    begin
      Result := -1;
      Exit;
    end;

    C := UpCase(Value[1 + 3 * I + 1]);
    if C in ['0'..'9', 'A'..'F'] then
      Bytes^[I] := Bytes^[I] or HexToDec[C]
    else
    begin
      Result := -1;
      Exit;
    end;
  end;
end;

procedure TTextIniFile.WriteBinary(const Section, Ident: string; Buffer: Pointer; Count: LongInt);
var
  Value: string;
  Bytes: PByteArray absolute Buffer;
  I: Integer;
begin
  Value := StringOfChar(',', Count * 3 - 1);

  for I := 0 to Count - 1 do
  begin
    Value[1 + 3 * I + 0] := DecToHex[Bytes^[I] shr  4];
    Value[1 + 3 * I + 1] := DecToHex[Bytes^[I] and 15];
  end;

  WriteString(Section, Ident, Value);
end;

procedure TTextIniFile.ReadSection(const Section: string; Strings: TStrings);
var
  I, J: Integer;
  Idents: TStringList;
  S: string;
begin
  I := FSections.IndexOf(Section);
  if I <> -1 then
  begin
    Idents := TStringList(FSections.Objects[I]);
    Strings.BeginUpdate;
    try
      for J := 0 to Idents.Count - 1 do
      begin
        S := Idents.Names[J];
        if (S <> '') and (S[1] <> ';') then
          Strings.Add(S);
      end;
    finally
      Strings.EndUpdate;
    end;
  end;
end;

procedure TTextIniFile.ReadSections(Strings: TStrings);
begin
  Strings.Assign(FSections);
end;

procedure TTextIniFile.ReadSectionValues(const Section: string; Strings: TStrings);
var
  I: Integer;
begin
  I := FSections.IndexOf(Section);
  if I <> -1 then
    Strings.Assign(TStringList(FSections.Objects[I]));
end;

procedure TTextIniFile.WriteSectionValues(const Section: string; Strings: TStrings);
var
  I: Integer;
begin
  for I := 0 to Strings.Count - 1 do
  begin
    WriteString(Section, Strings.Names[I], Strings.Values[Strings.Names[I]]);
  end;
end;

procedure TTextIniFile.EraseSection(const Section: string);
var
  I: Integer;
begin
  if (Section <> '') then
    with FSections do
    begin
      I := IndexOf(Section);
      if I <> -1 then
      begin
        Objects[I].Free;
        Delete(I);
        FModified := True;
      end;
    end;
end;

procedure TTextIniFile.DeleteKey(const Section, Ident: string);
var
  I, J: Integer;
begin
  if (Section <> '') and (Ident <> '') and (Ident[1] <> ';') then
  begin
    I := FSections.IndexOf(Section);
    if I <> -1 then
      with TStringList(FSections[I]) do
      begin
        J := IndexOfName(Ident);
        if J <> -1 then
        begin
          Delete(J);
          FModified := True;
        end;
      end;
  end;
end;

end.

