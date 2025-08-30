# SATIS

__SATIS__ (Simple Ada Testing Integrated Suite) is a unit testing facility for software written
in the Ada programming language.

Currently, SATIS is still in initial development, and incomplete. Please be patient and wait
for version 1.0 to be published. 



-----------------------------------------------------------------------------------------------
## Intro

Unit test code is written in what is essentially the Ada language, but with a few differences
aimed at making it easier to create and maintain the unit tests. SATIS therefore defines a
very simple 'meta-language' that includes the Ada language.

In addition, [Gherkin](doc/features.md) based feature files are used to structurally organise
the unit testing. 

SATIS and feature files conventionally have the `.satis.md` type (file extension. Each file is
are conventionally located in a directory named `testing`, which is located in the directory
containing the Ada source text the SATIS and feature files relate to. 

The SATIS code generator program---a command-line tool named `satis`---reads the feature and
unit test files and generates Ada source text from them. That Ada source text is compiled,
built, and run, to perform the tests and report on the results. 

Typically, batch or shell command script files are used to automate the compilation, building,
and running of these test programs. We show examples of such scripts throughout the SATIS
documentation. You may need to cusomise these scripts. 

In our examples, we will consider: the `CMD.exe` shell; Microsoft PowerShell; the Linux/GNU
`bash` shell. There are many other scripting languages that could be used. 



-----------------------------------------------------------------------------------------------
## Licence

The SATIS code, both Ada and Picat, is hereby published under the terms of the GNU GENERAL
PUBLIC LICENSE Version 3, 29 June 2007. See the [Licence](LICENCE.txt) file for details. 



-----------------------------------------------------------------------------------------------
## Version 1.0

The initial version of SATIS, version 1.0, provides fairly minimal functionality. This
functionality will be expanded upon in the future, generally without the need for the feature
or unit test files to be changed.

Currently:

 * The only way that the results can be reported is in plain text onto the console.

 * The [Ithax](doc/mocking.md) program has not yet been developed. 

 * There is a certain amount of manual work involved in setting up the configuration and
   accoutrements for a particular usage of SATIS, but we aim to give good guidance in this
   documentation. 

The `satis` program uses a simple text macro expansion technique, so any errors in the Ada
source text within the unit test files are not found by SATIS; instead whichever Ada compiler
is being used will detect and report such errors. It should not be too difficult to work out,
from a location in the generated Ada source, the corresponding location of the error in the
unit test files. 



-----------------------------------------------------------------------------------------------
## Future Versions

It is hoped that in the future the following functionality can be added:

 * The option of having an interactive GUI program to run the tests and analyse the results. 

 * Being able to generate results in the form of an XML file and possibly other formats.

 * Easy generation of mockable versions of packages using the Ithax tool. 



-----------------------------------------------------------------------------------------------
## Further Information

Hopefully the documentation accompanying SATIS here will be useful.

See [Concepts.md](doc/concepts.md) for an introductory discussion of how to use SATIS.

See [Installation](doc/installation.md) for instructions on how to install SATIS so you can use
it. 

See [Syntax.md](doc/syntax.md) for details of the syntax used in the SATIS files.

See [Running.md](doc/running.md) for more on how to use SATIS. 

Do please email me <mailto:nick.roberts@acm.org> to report any problems or deficiencies, or to
contribute suggestions or ideas. 



-----------------------------------------------------------------------------------------------
## Pros and Cons

The disadvantages of the way SATIS works probably include:

 * Every time any change is made to the source text or any unit test, the entire set of tests
   rooted in a common subtree will need to be regenerated, recompiled, and executed to perform
   the testing needed to validate the change. 

 * Existing editing and programmer assistance tools will not (at this time) directly work with
   unit test files. There might be some that work with the feature files, but I'm not currently
   aware of any. Many tools work with Markdown itself. 

 * Compiler analysis and debugging of unit tests themselves will be in terms of the generated
   Ada source text, rather than the text as it occurs in the unit test files.

The advantages might be:

 * Unit tests are a bit simpler to express in the SATIS meta-language, making them (arguably)
   easier to create and maintain, especially in a team context. The feature files and the unit
   test files, because they are based on the Markdown syntax, do provide a handy place for
   documentation related to the code. 

 * The unit test files developed are likely to have longevity; future enhancements to SATIS are
   not likely to require changes to the SATIS files.

 * SATIS is completely agnostic of the implementation of the Ada compiler.

 * SATIS is open-source and available free of charge.

Further (reasonable) comments and criticisms are welcome and will be published here.

In particular, the SATIS project could at this stage be considered a stalking horse. Its design
might need to be changed, perhaps quite radically, in order to make it fit many people’s needs.
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