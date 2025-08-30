# Reporting Success or Failure

Within the statements of a test procedure, various procedures can be called to signal
that the test has failed or succeeded, and to output further information in the case of 
failure. 

It is a strict convention that a test remains silent if it passes; since a run might execute
thousands of tests, having any of them routinely output messages is likely to become utterly
unwieldy, so they must simply output nothing unless they fail. 

There are ways to output things when [debugging](debug.md) SATIS tests. 



-----------------------------------------------------------------------------------------------
## Passing and Failing

The procedure `Test.Pass` can be called to signal that the test has succeeded. The procedure 
`Test.Fail` can be called to signify that test has failed. 

Calling `Test.Pass` multiple times in the same procedure has no different effect to calling it 
once. Similarly, calling `Test.Fail` multiple times has no different effect to calling it once. 
Calling both procedures (any number of times) has the same effect as calling `Test.Fail` once.

The Boolean functions `Test.Passed` and `Test.Failed` are available for procedure logic to
determine if the test has already been signalled as having passed or failed. The function 
`Test.Undecided` returns `True` only when both `Test.Passed` and `Test.Failed` return `False`. 
This is the initial state at the beginning of every test. 




-----------------------------------------------------------------------------------------------
## Failure Output

The test procedure can call subprograms of the standard `Ada.Text_IO` package to output
information regarding a failure of the test by specifying the `Test.Output` file . Doing so
also has the effect of implicitly calling `Test.Fail`. 

For example:

    ```ada
    if L2 >= L1 then
       Test.Pass;
    else
       Test.Fail;
       Test.Put (Test.Output, "Longest seat ID length of aircraft in fleet: ");
       Test.Put (Test.Output, L1);
       Test.New_Line (Test.Output);
       Test.Put (Test.Output, "Shortest maximum seat ID length for a particular booking agent: ");
       Test.Put (Test.Output, L2);
       Test.New_Line (Test.Output);
    end if;
    ```



-----------------------------------------------------------------------------------------------
## Assertions

The procedure `Test.Assert` can be called to evaluate a condition; the test has passed if the 
result is `True`, and the test has failed if the result is `False`. For example:

```ada
Test.Assert (L2 >= L1);
```

This is the exact equivalent of:

```ada
if L2 >= L1 then
   Test.Pass;
else
   Test.Fail;
end if;
```

A message can be added as a second parameter, in which case the message is output if the
assertion fails. For example: 

```ada
Test.Assert (L2 >= L1, 
   "Longest seat ID length of aircraft in fleet: " & 
   Integer'Image (L1) &
   Test.Line_Terminator &
   "Shortest maximum seat ID length for a particular booking agent: " &
   Integer'Image (L2) &
   Test.Line_Terminator);
```

This is the exact equivalent of:

```ada
if L2 >= L1 then
   Test.Pass;
else
   Test.Put (Test.Output, 
      "Longest seat ID length of aircraft in fleet: " & 
      Integer'Image (L1) &
      Test.Line_Terminator &
      "Shortest maximum seat ID length for a particular booking agent: " &
      Integer'Image (L2) &
      Test.Line_Terminator);
end if;
```


-----------------------------------------------------------------------------------------------
## Failure Report Section

A _report section_ is simply a convenience for formatting the output relating to a failure.

Its payload must be one or more lines that are to be output if (and only if) the test procedure 
fails. Each line can contain one or more 'interpolations' between `{` braces `}`. Each 
interpolation must contain a legal Ada expression; the value of the expression is output in 
place of the interpolation (including the braces, so the braces are not output). 

The function `Failure_Report` of the `Test` representative returns the payload of the report
section with its interpolations already replaced. 

So, for example: 

    Test.Assert (L2 >= L1, Test.Failure_Report);

    ### Failure Report

    ```
    Longest seat ID length of aircraft in fleet: {L1}
    Shortest maximum seat ID length for a particular booking agent: {L2}
    ```

The above will have exactly the same effect as the first example in
[Reporting Success or Failure](#reporting-success-or-failure).



