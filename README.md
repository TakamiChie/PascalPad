# PascalPad

Text pad for Pascal test execution.

## Using

1. Write Pascal code.
2. Press F5 or Run Button.

Since the main purpose is to test the code, the following code is automatically entered.

```pascal
program test;

begin
{ [The program you write will be inserted here.] }
end.
```

The following functions are predefined for output the result. Various values ​​such as character strings, numbers, and Bool values ​​can be output to the log.

```pascal
procedure Write(AData: Variable);
```


## Sample code

The shortest sample.

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

If you write `begin ... end.` yourself, the begin clause will not be added automatically.

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

Of course, for statements can also be used.

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