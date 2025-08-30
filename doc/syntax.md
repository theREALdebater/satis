# SATIS Syntax

It is recommended that the unit test source code is stored in files with the `,satis.md` type
(file extension), and that one such file is created to contain the unit tests for a scenario
(q.v.) in the same directory. These files, the _SATIS files_, will then be part of the
canonical source code, and should be committed into the same source control repository as the
Ada source text they are testing.

It is assumed that the reader is familiar with SATIS's basic [concepts](concepts.md).



-----------------------------------------------------------------------------------------------
## Context Section

A _context section_ declares library units that should be 'withed' by Ada source text in the 
SATIS file, and also any such 'withed' units that should also be 'used'. This section has no title. 

Within the payload, the fully qualified name of each library unit must be given. Multiple names can be given, each on its
own line with the word `with` before it, and a `;` semicolon on the end. 

Use clauses may also be put here, each unit name on its
own line with the word `use` before it, and a `;` semicolon on the end.

A context section applies to all Ada source text in the remainder of the SATIS file until 
the end of the file. Only one context section is allowed in a file, but it may be omitted. 

It is not necessary to include the `SATIS` package in the context clause, because that is added 
automatically. 

For example: 

    ## Context

    ```ada
    with Kwikair.Constants;
    with Kwikair.Utility;

    use Kwikair.Constants;
    ```

There should be at most one context section in a SATIS file, and if it is not omitted it should
come before any other section in the file. 



