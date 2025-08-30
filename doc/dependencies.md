# Dependencies and Priority Groups

At least in theory, all tests are executed in parallel with one another. That means the tests 
must, by default, have no dependencies on one another. 

If a test has a dependency on another test, that can be explicitly stated, provided both tests
are in the same [battery](batteries.md). 

If test A depends on test B, then A will not be started (including its scenario setup) until B
has completed (including its scenario tear-down). 

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

A scenario can be declared as having a _dependency_ on one or more other scenarios ..... 





-----------------------------------------------------------------------------------------------
##





-----------------------------------------------------------------------------------------------
##





-----------------------------------------------------------------------------------------------
##










