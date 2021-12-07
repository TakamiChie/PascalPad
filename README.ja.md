# PascalPad

Pascalコードのテストを目的ストした簡易テキストパッドです。

## Using

1. Pascalコードを書く
2. F5キーまたはツールバーのRunボタンで実行。

なお、テスト実行を目的としているため、以下のコードが内部的に挿入されています。

```pascal
program test;

begin
{ [The program you write will be inserted here.] }
end.
```

なお、結果の出力のため以下の関数があらかじめ定義されています。文字列や数値、Bool値など様々な値をログに出力可能です。

```pascal
procedure Write(AData: Variable);
```

## サンプルコード

一番短いサンプル。

```pascal
Write(1+2);
Write('abc');
Write(True);

{
  -> 3
  -> abc
  -> True
}
```

`begin ... end.`を自分で書いた場合は、begin句は自動的に付加されません。

```pascal
var i: Integer;
begin
  i:= 1+2;
  Write(i);
  Write('abc');
  Write(True);
end.

{
  -> 3
  -> abc
  -> True
}
```

もちろんfor文なども使用可能。

```pascal
var i: Integer;
begin
  for i:= 0 to 10 do
    Write(i);
  Write('abc');
  Write(True);
end.

{
  -> 0
  -> 1
  -> 2
  -> 3
  -> 4
  -> 5
  -> 6
  -> 7
  -> 8
  -> 9
  -> 10
  -> abc
  -> True
}
```