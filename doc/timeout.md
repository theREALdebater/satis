## Time Limit

When the tests of a scenario are run, the overall time taken to run all the tests in the 
scenario has a limit. 

The [test rig](?????) enforces the limit. 

If the time limit is reached and the scenario's tests have not yet all completed, testing of 
the scenario is stopped and all its tests are failed. 

The default time limit is 10 seconds. However, this can be changed by adding in a line, within
the [scenario header](scenarios.md), that begins with `Time limit:` then has a positive decimal
integer value (with no spaces or punctuation within it), and ends with one of: `second`,
`seconds`, `minute`, `minutes`, `hour`, or `hours`. 

For example:

    ## Scenario: Fundamental data sanity

     * Category: Basics

     * Category: Smoke Tests

     * Time limit: 3 minutes

    Fundamental data are things that many other parts of the system depend upon. If one of 
    these things is wrong, it is likely to have a serious effect on the correctness or 
    operability of the rest of the system. 









