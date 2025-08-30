# Tests

A _test section_ provides the optional title of a unit test, 

.....


A [step pattern declaration](#steps) indicates that a test section is able to match expectation
steps .....

.....





????? A _test section_ establishes a title for a test within the scenario, and this section is the 
best place for documentation that applies to the test as a whole. This kind of section has no 
payload. 


.....




A test section is followed by the following kinds of section that will apply to it:

 * optionally, a [test declaration section](#test-declarations); 

 * optionally, a [test procedure section](#test-procedures); 

 * optionally, a [report section](reports.md); 

 * optionally, a [test parameter section](datadriv.md#test-parameter-section); 

 * optionally, a [test data section](datadriv.md#test-data-section); 

 * optionally, a [test input section](input.md#test-input); 

 * optionally, an [expected output section](expect.md#expected-output). 
 
 
 
If there is a test parameter subsection, then there must also be either:

 * a test data subsection; or 
 
 * at least one [placeholder declaration](#steps). 

If there is no test procedure subsection, then there must be:

 * a test parameter subsection; and 

 * either a test data subsection or a placeholder declaration; and 

 * a report subsection. 

For example: 

    ## Test: Booking Seat ID Length

    Maximum length of booking seat ID must be no smaller than
    the longest seat ID of all aircraft in fleet. 



-----------------------------------------------------------------------------------------------
## Test Declarations

The _test declaration section_ contains declarations to .....

......

For example: 

    ### Test Declarations

    ```ada
    L1 := 0: Integer; -- longest seat ID length of aircraft in fleet
    L2: Integer; -- shortest maximum seat ID length for a particular booking agent
    ```



-----------------------------------------------------------------------------------------------
## Test Procedures

The _test procedure section_ contains .....

......

For example: 

    ### Test Procedure

    ```ada
    for Aircraft of Fleet loop
       for Seat of Aircraft loop
          if Length (Seat.ID) > L1 then
             L1 := Length (Seat.ID);
          end if;
       end loop;
    end loop;
    -- etc.
    ```

Each .....



-----------------------------------------------------------------------------------------------
## The `Test` Representative

Within the declarations and statements of any test, the name `Test` is available. 

......







