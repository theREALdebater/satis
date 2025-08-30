## Categories

Each scenario can be put into one or more _categories_, to provide a way to select which
scenarios to run and which to skip. 

The `Category` keyword is used within a scenario block to put the scenario into a specific
category. 

For example: 

    ## Scenario: Fundamental Data Sanity

    Fundamental data are things that many other parts of the system depend upon. If one of 
    these things is wrong, it is likely to have a serious effect on the correctness or 
    operability of the rest of the system. 

     * Category: Basics

     * Category: Smoke Tests
    
This will put the scenario `Fundamental Data Sanity` into the categories `Basics` and
`Smoke Tests`. 


### Categorising Scenarios in Feature Files

Categories can, alternatively, be applied to scenarios in a feature file using 
[tags](features.md#tags). The tag is treated by SATIS as a category name. A tag applied to a 
feature or a rule applies to all the scenarios of that feature or rule. 


### Selecting Categories

Categories can be passed, as normal arguments, to a unit test program. Only the tests of
scenarios which are in at least one of the given categories are run. Other tests are skipped.
This applies to all [batteries](batteries.md). If no categories are specified, all tests in all
scenarios (in all batteries) are run. 

When comparing any two category names, they _match_ according to the following rules: 

 * leading and trailing non-alphanumeric characters are trimmed (removed); 

 * a Roman letter matches another letter regardless of upper or lower case; 
 
 * a digit matches itself; 
 
 * any contiguous sequence of non-alphanumeric characters matches any other contiguous sequence 
   of non-alphanumeric characters; 

For example, the following names match:

| Given Name      | Category Name   |
| --------------- | --------------- |
| `Curious`       | `curious`       |
| `some-other`    | `SOME::OTHER`   |
| `yes  or   no`  | `Yes_Or_No`     |
| `Sec = 25`      | `SEC/25`        |

When a given category name is specified on the command-line, it matches a category according 
to the following:
   
 * if the given name matches the beginning of exactly one category name, it matches that 
   category; 
   
 * if the given name matches more than one category name, it is deemed to have failed to match 
   any category; 
   
 * if the given name does not match any category name, the last character of the given name is 
   (temporarily) removed until there is a match or the given name has been reduced to nothing; 
   
 * if the given name has been reduced to nothing, it is deemed to have failed to match any 
   category. 

For example, the given name `e` would match the category with name `Extras` if there were 
no other category whose name began with `e` or `E`. 

On the command line, an argument with spaces in it, or any other character that would be
interpreted by the shell language, needs to be quoted or to have the special characters
escaped. 



