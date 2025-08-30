## Expected Output

An _Expected Output subsection_ specifies the output expected to be written by a test into the
`Standard_Output` of the `SATIS.Text_IO` package. 

The section payload contains the text expected.

If the `Ada.Text_IO` package is [substituted](substitutions.md) by the `SATIS.Text_IO` package
(as is usually the case), the test need only execute statements such as: 

    Put (X);
    
in order to ..... 

The text actually written by the test is compared to the expected data given.

Each line of expected data will have any leading and trailing whitespace characters trimmed 
before being compared.

Any differences cause the test to fail, and the actual and expected lines of text are output. 

If there are no mismatching lines, the test will pass. 

?????Pass or fail of the test with an expected output clause will be overridden by executing `Pass` 
or `Fail` in the test procedure. 



