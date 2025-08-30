# SATIS Concepts

You will need to understand the concepts outlined in this file before you will be able to 
understand the remaining SATIS documentation. 



-----------------------------------------------------------------------------------------------
## Levels of Testing

SATIS provides support for _unit testing_. 

Unit testing can operate at many different levels, from the lowest (e.g. a small isolated 
function) to quite high (e.g. the API calls into an internet service). 

However, unit testing is only one piece of the overall testing picture.



.....







-----------------------------------------------------------------------------------------------
## Purpose of Unit Testing

The purpose of a unit test is to test one executional unit, within a larger a body of software,
isolated as much as possible from all the other units.

In the context of the Ada programming language, a 'body of software' is likely to be a library,
and an 'executional unit' is typically a subprogram (function or procedure).

The unit being tested is technically termed the 'subject under test', but for brevity we will
use the term _subject_.

Taking this approach has some advantages: localisation; relevance; statement of intent. These 
are discussed briefly here. 


### Localisation

The body of software will have a set of unit tests to test the units within it. It is possible
for a large program to have thousands of these tests. The ideal is for all the units to be
tested; sometimes this is not feasible, due to constraints of time and resources; sometimes
there are some units for which testing would be pointless or impossible.

Each test should test one very specific thing, about one subject (function or procedure).
Generally, each test should be as small as possible. Typically, each subject will have many
tests; sometimes one subject will have dozens or possibly hundreds of tests.

The reason for this is to pinpoint, as narrowly as possible, what is going wrong, where it is 
going wrong, and why it is going wrong, whenever a test fails. The more specific the test, the 
more precisely it pinpoints the cause or mechanism of the failure.

If a defect (bug) is found, it can be deduced that the cause of the fault probably lies within 
the subject, making it easier to find and correct the fault. Better still, if it is a certain 
kind of test, or a certain set of test data, that fails, the problem may be even easier to nail 
down. 

In some programs, determining the location of the source text causing a particular defect can
be a nightmare. Good software design---for example, avoiding global variables---can mitigate
this problem, but unit testing is often the best approach available.


### Relevance

When executing unit tests, it is possible to execute only a specific subset of the tests, so 
testing only specific parts of the overall body of software.

This may be advantageous, in that it is possible to avoid the time and distraction caused by
testing parts of the software that are not relevant to changes (or additions) currently at 
hand, or that are not relevant for some other reason.

It may also be necessary to be able to test some parts of the software whilst other parts are
incomplete or in the middle of being written or undergoing changes.


### Statement of Intent

A unit test can serve the purpose of communicating, to humans, what the subject is supposed to
do, as well as its intentional limitations, compromises, design decisions and background. 

Although other means of documentation can serve this purpose, unit tests can neatly combine the
two objectives of (precisely) stating the intended behaviour of the unit and actually testing 
it. 

Almost always, it is necessary for the tests themselves to be accompanied by comments or other
documentation explaining the subject and the tests in a human-readable form. Good source text 
can explain things, but good documentation can explain it better and often it can explain 
things that the source text cannot. Documentation also adds a redundancy to the explanation: it 
can approach matters from different angles, and it can confirm that the source text---even the 
tests themselves---actually does what it is supposed to. 

In SATIS unit test files, the [Syntax](Syntax.md) is designed to be as compatible as possible 
with the Markdown documentation language, and commentary can be very conveniently interspersed 
with the test code and data. 



-----------------------------------------------------------------------------------------------
## Scenarios and Batteries

Since many tests are likely to have certain things in common---variables that have been
initialised to a particular state, for example---a parameter that encapsulates all these
things, called a _scenario_, is passed into each test for it to use and update.

For convenience, the scenario also represents the state of the test, and the overall testing 
infrastructure. For example, it can be updated with the results of the test.

Source text can be added that _sets up_ and _tears down_ a scenario. This scenario setting up
and tearing down will be executed once for every test in the scenario that is run. 

A set of scenarios can be grouped into a [battery](batteries.md). Source text can be added that
sets up and tears down a whole battery. The setting up and tearing down of a battery is in
addition to the setup and tear-down of scenarios. The setup of a battery is executed only once,
before any of the tests of (the scenarios of) the battery are executed. The tear-down of a
battery is executed only once, after all the tests of (the scenarios of) the battery have
completed. 

A scenario can only be in one battery. There is a _default battery_; a scenario that is not
explicitly put into a different battery is implicitly put into the default battery. The default
battery has no setup nor tear-down actions. 

A scenario can be put into one or more _scenario categories_. This forms a means by which the 
user can select only a subset of all available tests to be run. 



-----------------------------------------------------------------------------------------------
## Dependencies and Priorities

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
## Parametrisation

A unit test can have _parameters_ declared for it (besides the implicit scenario parameter). 
The parameters can be used in the source text for the test. Multiple corresponding sets of 
values can then be specified, and the test will be performed once for each set of values, with 
the parameters in the source text taking the corresponding value in each instance.

SATIS also has the ability to generate parameter values semi-automatically, in a variety of
ways:

 * a range of numeric values, with a specific stepping

 * values read from a CSV file, either all rows or a specific range of rows

 * values generated by a function written in Ada



-----------------------------------------------------------------------------------------------
## Source Text Files and Root Directories

The Ada source text files that make up a single software product is assumed to be gathered, 
probably in a tree of directories, under a single _root directory_ that is the root of the 
tree (or maybe just directly contains all the source text files). 

If there are two or more root directories, you will (currently) have to process each root 
directory separately. Please let me know if this is a problem for you; SATIS can always be 
changed. 

.....





-----------------------------------------------------------------------------------------------
## Feature Testing: BDD and MDG

Behaviour-Driven Development, or _BDD_, is a software development and maintenance technique 
that aims to make the development and testing of software be driven by a user-friendly 
specification of what the software is required to do. 

More can be found on this topic in Wikipedia: 

[Behavior-driven_development](https://en.wikipedia.org/wiki/Behavior-driven_development)

and also on the Agile Alliance website:

[BDD](https://www.agilealliance.org/glossary/bdd)

A commonly used (domain-specific) language used to write a formal specification is __Gherkin__.
In essence, Gherkin can be used to specify a set of acceptance tests for a unit of
functionality (a _feature_) in something nearer to plain English (or any natural language).

The nearest thing to an official definition of Gherkin can be found on the Cucumber (a company) 
website:

[Gherkin Reference](https://cucumber.io/docs/gherkin/reference/)

There is a variant, called _MDG_, of the Gherkin syntax which accords with the Markdown syntax:

[MDG](https://github.com/cucumber/common/blob/main/gherkin/MARKDOWN_WITH_GHERKIN.md)

MDG files (normally with the `.feature.md` file extension) are read and interpreted by SATIS as
the primary means of defining unit tests. 

Much more on MDG is described [here](features.md). 



-----------------------------------------------------------------------------------------------
## How SATIS Works

.......

When the SATIS tool is run, it

.....

The SATIS tool then generates .....

..... Ada source text files which contain:

 * ?????

 * ?????

 * for each battery, a procedure that runs the selected tests in (all the scenarios of) that
   battery; 

 * a single procedure named `SATIS.Tests.Run` which runs all the batteries (in parallel); 
 
 * a CSV file named `satis-history.txt` which relates every SATIS file to its last-processed
   date. 




.......


