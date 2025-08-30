# Data Driven Testing

.....

If there is no test parameter section applied to a test and it has no placeholder declaration,
it is a _single test_, otherwise it is a _data-driven test_. 

A data-driven test must also have at least one test data section or test data file section
applied to it, or it must have at least one placeholder declaration. 

A data-driven test may optionally have one test setup section applied to it, and it may 
optionally have one test tear-down section applied to it. 

..........


### Test Parameter Section

A _test parameter section_ defines the _parameters_ of a test. The section applies to the most 
recently defined test. 

The section heading is followed by one or more Ada declarations which will be the components of 
a record type used to hold the data for each iteration of the test. 

The format of .....

For example:

    ### Test Parameters

    ```ada
    Number_Of_Bookings:    Natural;
    Seats_Per_Booking:     Float;
    ```

It is permitted for two or more test parameter sections to apply to the same test, in which
case the declarations in each test parameter section are concatenated, as if they were all
specified, in the same order, within one test parameter section. 


### Test Data Section

A _test data section_ declares the actual data for a data-driven test. 

........

Each line, after the section heading, must contain the values that will be assigned (inside an
aggregate) to the test parameters for an iteration of the test. The number of lines of data
will determine the number of times the test is iterated. 

For example: 

    ### Test Data

    ```ada
    "Airbus A320", 100
    "....", ...
    "....", ...
    ```

It is permitted for two or more test data sections to apply to the same test, in which case the
data lines in each test data section are concatenated, as if they were all specified, in the
same order, within one test data section. 

Inside the test declarations and procedure, the parameters can be accessed as components of the 
`Test` representative.

For example, within a test procedure, we might have:

    ```ada
    ...
    Total_Seats_Booked := Float (Test.Number_of_Bookings) * Test.Seats_Per_Booking;
    Seats_Booked := Natural (Ada.Numerics.Float_Random(RNG) * Test.Seats_Per_Booking);
    ...
    ```


### Multi-Line Test Data

If the lines of data are getting overly long, an alternative syntax can be used, whereby the 
data for each iteration can be placed on multiple lines, with a blank line separating 
iterations. 

The test data section must have the declaration `format multi-line` to enable this 
alternative syntax. 

For example: 

    ### Test Data
    
    * Format: Multi-line

    ```ada
    "Airbus A320", 100, "A very long piece of text which threatens to make the data line " &
    "extremely long, but which can be easily accommodated using the multi-line syntax."
    
    "....", ...
    
    "....", ...
    ```


### Test Data Files

A _test data file_ section specifies one or more files from which the data for a test is to be 
read. 

.....

Several files can be specified, but they will all be expected to have the same structure: 

 * the files must either all have a header row or they must must all have no header row; 

 * if they all have a header row, they must all have the named columns expected by the test; 
 
 * if they all have no header row, they must all have the same (number and meaning of) columns. 

.....

For example: 

     ### Test Data File
     
     * Format: With Headers
     
     ```
     sample-aircraft-all.csv
     sample-aircraft-012.csv
     ```

This example reads data from two CSV files (`sample-aircraft-all.csv` and 
`sample-aircraft-012.csv`). Both files have a header row. These files are in the same 
directory as the SATIS file. 

As another example: 

     ### Test Data File
     
     ```
     //stats/report-alpha/final/seating-stats-*.csv
     ```
     
This example reads data from all the CSV files in the directory `//stats/report-alpha/final` 
whose names begin with `seating-stats-` and end with `.csv` --- These files all have no header 
row. 

It is permitted for two or more test data files sections to apply to the same test, in which
case the files in each test data files section are concatenated, as if they were all specified,
in the same order, within one test data files section. 


### Parameter Mapping Section

A _parameter mapping section_ defines how the parameters of a data-driven test are set with 
the values read from a row of a CSV file. 

This section can only be applied to a data-driven test that has a test data file section. 

The payload of this section must be one or a sequence of Ada statements that will set the 
values of the parameters (as local variables) using the function `Test.Get_Datum`. 

The function `Get_Datum` is a primitive operation of the `Test` representative, with two 
overloads. Both overloads take one parameter, which may be either: 

 * of type `Wide_String`, which is the header name of a column of data in a CSV file with a 
   header row; or 
   
 * of type `Positive`, which is the number of the column, starting at one. 
 
Both overloads return the value read in the chosen column of a row of data read from the CSV 
file. 

.....

For example:

    ### Parameter Mapping

    ```ada
    Test.Number_Of_Bookings := Natural'Value (Test.Get_Datum ("Bookings"));
    Test.Seats_Per_Booking: := Float'Value (Test.Get_Datum ("Average Seats"));
    ```

.....     

If a parameter mapping section is not specified for a test that has a test data file section, 
the parameters must all be of type `String` or `Wide_String` or `Wide_Wide_String`, and will be 
set automatically as follows:

 * if the file has a header row (`format with headers` has been specified), a parameter will be
   set to a field of the row corresponding to the header column whose name matches the name of
   the parameter; otherwise 
   
 * the nth parameter will be set to the nth field of the row (for n >= 1 and n <= number of 
   parameters and n <= number of columns). 
 
Matching between a parameter name and a header column name ignores case and equates any 
sequence of space or punctuation characters with the `_` underscore character. For example, the 
column headers `seats-per-booking` and `SEATS PER BOOKING` will match the parameter name 
`Seats_Per_Booking`. 


### Test Data Generator Section

A _test data generator section_ provides .....

.....

The payload of this section is a sequence of Ada statements that will be executed once for all 
the iterations of the test. 

It is expected that these statements will have a loop that will initiate multiple test 
iterations. For each iteration, the statements are likely to: 

 1. Set the values of the test parameters for the iteration; 
 
 2. Call the procedure `Test.Execute_Iteration`. 

The procedure `Test.Execute_Iteration` has no parameters of its own, and calls the test 
procedure generated by SATIS from the test procedure section of the test. 

Any number of test data generator sections can be applied to a test. Each of these sections 
must generate the same parameters, but can generate any number of iterations. 

.....

.....

We will present examples showing how a test generator section could be used to test against: 

 * a range of numeric values, with a specific stepping; 

 * a series of strings that conform to a fixed pattern; 

 * values read from a CSV file; 

 * values generated by a function written in Ada.
 
However, the possibilities are endless. 

For a range of numeric values, consider the following example:

    ### Test Data Generator
    
    ```ada
    for N in 1 .. 10
    loop
       Test.Seats_Per_Booking: := Ada.Numerics.Float_Random(RNG) * Float(N);
       Test.Number_Of_Bookings := Natural (230 / Test.Seats_Per_Booking);
       Test.Execute_Iteration;
    end loop;
    ```

This example shows the parameter values being set to calculated random values for ten
iterations of the test. The random values are calculated based on an iteration variable (`N` in
this example). 

For a series of strings conforming to a pattern, consider the following example:

    ### Test Data Generator
    
    A customer booking code is always in the format `KAnnnnnCBnn` where `nnnnn` is a five-
    digit decimal serial number, and `nn` is a two-digit decimal number giving the number of 
    seats booked. 

    ```ada
    declare
       Code_0: constant Integer := Character'Pos('0');
       Code_9: constant Integer := Character'Pos('9');

       function Random_Digit return Character is
          (Character'Val (Ada.Numerics.Random (Code_0, Code_9, RNG)));

       function Random_Digits (Length: Natural) return String is
          Result: String (1 .. Length);
       begin
          for i in Result'Range loop Result(i) := Random_Digit; end loop;
          return Result;
       end;

    begin
       for N in 1 .. 10
       loop
          Test.Customer_Code := "KA" & Random_Digits(5) & "CB" & Random_Digits(2);
          Test.Execute_Iteration;
       end loop;
    ```

This example .....

.....



