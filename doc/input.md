# Test Input

A _test input section_ provides text to be read (from `Current_Input`) by a test procedure. 

The section heading is followed by lines of plain text. There will be an end-of-file after the 
last line. 

    ### Test Input

    ```
    23.4 AS100X2
    14.7 AX4365C2
    7.25 S23FG985D
    ```

Each line of text will have any leading and trailing whitespace characters trimmed. 
    
?????If the `Ada.Text_IO` package is substituted by the `SATIS.Text_IO` package (as is usually the 
case), the test need only execute statements such as: 

    Get (X);
    
in order to read things from the given input. Blank lines preceding and following the lines of 
text are removed, but blank lines are otherwise kept and are significant for the input. 

For example:


    ### Test Procedure

    .....

    ```ada
    Get_Line (A1);
    Get_Line (A2);
    Get_Line (A3);
    ```

    ### Test Input

    ```
    Hello

    World
    ```


would result in `A1` containing `Hello`, `A2` containing the empty string, and `A3` containing 
`World`.



