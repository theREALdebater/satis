# SATIS

__SATIS__ (Simple Ada Testing Integrated Suite) is a unit testing facility for software written
in the Ada programming language.

Currently, SATIS is still in initial development, and incomplete. Please be patient and wait
for version 1.0 to be published. 



-----------------------------------------------------------------------------------------------
## Intro

Unit test code is written in what is essentially the Ada language, but with a few differences
aimed at making it easier to create and maintain the unit tests. SATIS therefore defines a
very simple ‘meta-language’ that includes the Ada language.

SATIS unit tests are stored in files that conventionally have the `.satis` type (file
extension) and are conventionally located in the same directories as the source text they 
relate to. 

The SATIS code generator program - a command-line tool - reads the unit test files and
generates Ada source text from them. That Ada source text is compiled and run, to perform the
unit tests and report on the results.



-----------------------------------------------------------------------------------------------
## Version 1.0

The initial version of SATIS, version 1.0, provides fairly minimal functionality. This 
functionality will be expanded upon in the future, generally without the need for the unit test 
files to be changed.

Currently:

 * the Ada source text generated compiles to become a command-line program
 * the only way that the results can be reported is in plain text onto the console
 * all the unit tests that have been generated are run

The generator program use a simple text macro expansion technique, so any errors in the Ada
source text within the unit test files are not found by SATIS; instead whichever Ada compiler 
is being used will detect and report such errors. It should not be too difficult to work out, 
from a location in the generated Ada source, the corresponding location of the error in the 
unit test files.



-----------------------------------------------------------------------------------------------
## Future Versions

It is hoped that in the future the following functionality can be added:

 * being able to run a subset of tests
 * the option of having an interactive GUI program to run the tests and analyse the results
 * being able to generate results in the form of an XML file and possibly other formats



-----------------------------------------------------------------------------------------------
## Further Information

See [Concepts.md](doc/concepts.md) for an introductory discussion of how to use SATIS.

See [Installation](doc/installation.md) for instructions on how to install SATIS so you can use
it. 

See [Syntax.md](doc/syntax.md) for details of the syntax used in the SATIS files.

See [Running.md](doc/running.md) for more on how to use SATIS. 



-----------------------------------------------------------------------------------------------
## Pros and Cons

The disadvantages of the way SATIS works probably include:

 * Every time any change is made to the source text or any unit test, the entire set of tests
   rooted in a common subtree will need to be regenerated, recompiled, and executed to verify 
   the change.

 * Existing editing and programmer assistance tools will not (at this time) directly work with
   unit test files.

 * Compiler analysis and debugging of unit tests themselves will be in terms of the generated
   Ada source text, rather than the text as it occurs in the unit test files.

The advantages might be:

 * Unit tests are simpler to express in the SATIS meta-language, making them (arguably)
   easier to create and maintain, especially in a team context.

 * The unit test files developed are likely to have longevity; future enhancements to SATIS are
   not likely to require changes to the SATIS files.

 * SATIS is completely agnostic of the implementation of the Ada compiler.

 * SATIS is open-source and available free of charge.

Further (reasonable) comments and criticisms are welcome and will be published here.

In particular, the SATIS project could at this stage be considered a stalking horse. Its 
design might need to be radically changed in order to make it fit many people’s needs. 
Therefore, you should not feel inhibited from suggesting radical changes, if you believe they 
are necessary. 



-----------------------------------------------------------------------------------------------
## Alternatives

By all means try out SATIS and see whether you like it. 

However, do not make a hasty commitment to any particular unit testing technology. Unit testing 
is extremely important for the ongoing quality, maintainability, and value of your software. It
will be worthwhile spending a lot of time and effort to choose the right one for you. 

In particular, you should investigate [AUnit][1], and decide carefully whether it is likely to 
suit your needs better.



-----------------------------------------------------------------------------------------------
## Links

[1](https://www.adacore.com/documentation/aunit-cookbook)