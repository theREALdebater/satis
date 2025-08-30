# Scenario Sections

A _scenario section_ establishes a title for the scenario. This section has no payload. 

Within the scenario section, a [battery](#batt), one or more [categories](#scencat), the [time 
limit](#limit), a [priority group](#group), and one or more [dependencies](#dep) can optionally 
be declared. 

For example: 

    # Scenario: Fundamental Data Sanity

    Fundamental data are things that many other parts of the system depend upon. If one of 
    these things is wrong, it is likely to have a serious effect on the correctness or 
    operability of the rest of the system. 

.....

There must be exactly one scenario section in a SATIS file, and it 
must be the first section in the file.




A scenario section will be followed by the following sections, that will apply to it:

 * optionally, a [scenario declaration section](#scenario-declarations); 
 
 * optionally, a [scenario setup section](#scenario-setup-and-tear-down); 
 
 * optionally, a [scenario tear-down section](#scenario-setup-and-tear-down); 
 
 * one or more [test sections](tests.md), each followed by its own sections that will apply to
   it. 






The title of a scenario in a SATIS file must match the title of a scenario in a
[feature file](features.md).

The declaration (if any), setup (if any), tear-down (if any), and tests 
declared ........


There should be a corresponding scenario section in a [feature file](#features.md) with a
matching title. The steps associated with the scenario section in a feature file are the only
steps which can match step declarations (q.v.) in the setup, tear-down, and tests associated
with the corresponding scenario section in the SATIS file. 

It is recommended that documentation specific to the implementation of the steps is placed in 
the SATIS file, but that other documentation (e.g. a description of the scenario, the purpose 
and meaning of the steps, any further information as to how the steps relate to the subject 
under test) are placed in the feature file. 







-----------------------------------------------------------------------------------------------
## Scenario Declarations

A _scenario declaration section_ 

..... by any number of Ada declarations .....

For example: 

    ### Scenario Declarations

    ```ada
    Sample_Boeing_737_800: Aircraft_Reference := new Boeing_737_800;

    Aircraft_Spread: constant array (Positive range <>) of Aircraft_Reference :=
       (Sample_Boeing_737_800, ...);
    ```

.....



-----------------------------------------------------------------------------------------------
## Scenario Setup and Tear-Down

A _scenario setup section_ contains Ada statements that are to be executed prior to the 
execution of every test in the scenario. 

.........

A _scenario tear-down section_ contains Ada statements that are to be executed after the 
execution of every test in the scenario. 

.........

For example: 

    ### Scenario Setup

    ```ada
    if (for some i in Aircraft_Spread => 
          (for some j in Aircraft_Spread => 
             Aircraft_Spread (i) = Aircraft_Spread (j) and i /= j)) then
       raise SATIS.Self_Testing_Error with "Duplicate entry in Aircraft_Spread";
    end if;
    ```

    ### Scenario Tear-Down

    .....

.....


A [step pattern declaration](#steps) indicates that a scenario set-up or tear-down section is 
able to match precondition and keypoint steps .....

.....





