# Batteries

Since many tests are likely to have certain things in common---variables that have been
initialised to a particular state, for example---a parameter that encapsulates all these
things, called a _scenario_, is passed into each test for it to use and update.

For convenience, the scenario also represents the state of the test, and the overall testing 
infrastructure. For example, it can be updated with the results of the test.

Source text can be added that _sets up_ and _tears down_ a scenario. This scenario setting up
and tearing down will be executed once for every test in the scenario that is run. 

A set of scenarios can be grouped into a _battery_. Source text can be added that sets up and 
tears down a whole battery. The setting up and tearing down of a battery is in addition to the 
setup and tear-down of scenarios. The setup of a battery is executed only once, before any of 
the tests of (the scenarios of) the battery are executed. The tear-down of a battery is 
executed only once, after all the tests of (the scenarios of) the battery have completed. 

A scenario can only be in one battery. There is always a _default battery_, named `Default`; a
scenario that is not explicitly put into a different battery is implicitly put into the default
battery. The default battery has no setup nor tear-down actions. 



-----------------------------------------------------------------------------------------------
## Scenarios and Batteries

A scenario can be put into a specific battery by using the `Battery` keyword in a scenario
block. 

A scenario can only be in one battery. If it is not explicitly put into a battery, it is
implicitly put into the default battery. 

A battery exists only if it has at least one scenario in it. 

.....

For example: 

    ## Scenario: Food Quality

    Food quality is monitored by recording the batch number and 'use by' date on every package, 
    and regularly checking every package. 

    A package is checked by scanning its batch number, with a bar-code scanner. The batch number 
    is used to look up the use-by date of the package. The person doing the check is alerted by 
    a bleep if the package is past its use-by date. 

    The database must be able to produce a use-by date for any batch number. 

     * Battery: Ancillary Functions

This will put the scenario `Food Quality` into the battery `Ancillary Functions`. 



-----------------------------------------------------------------------------------------------
## Setup and Tear-Down of a Battery

The setting up and tearing down of a battery is in addition to the setup and tear-down of
scenarios. The setup of a battery is executed only once, before any of the tests of (the
scenarios of) the battery are executed. The tear-down of a battery is executed only once, after
all the tests of (the scenarios of) the battery have completed. 

.....



-----------------------------------------------------------------------------------------------
## Priority Groups

.....

In addition to being able to explicitly state dependencies between tests, the tests of a
battery can be explicitly associated with _priority groups_. 

Each priority group, within a battery, is identified by a whole number between 1 and 9 
(inclusive). 

Within a battery, the tests in priority group N are all completed before any of the tests in 
any of the remaining priority groups (those whose number is greater than N) are started. If any 
of the tests in the group fails, then none of the tests in any of the remaining groups are 
executed. The first priority group to be tested is priority group 1. 

Batteries always execute independently and in parallel with one another. It is not allowed for 
a test to have a dependency on a test in another battery. The priority groupings in one battery 
have no effect on any other battery. 




-----------------------------------------------------------------------------------------------
## 




