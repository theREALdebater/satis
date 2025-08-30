# Text Files

SATIS is itself written in Ada, and the standard package `Ada.Text_IO` is used to read the 
SATIS files. 

In practice, it is recommended that SATIS files should contain only ASCII characters (codes 0 
to 127). It should contain only the characters HT (code 9), LF (code 10), FF (code 12), CR 
(code 13), SPACE (code 32), and the visible characters (codes 33 to 126). 

Several things will depend on the implementation of the Ada compiler used to compile SATIS 
itself:

 * how lines and pages are separated or terminated

 * whether a line and/or a page terminator is required at the end of the file

 * how control characters are interpreted

.....



-----------------------------------------------------------------------------------------------
## General Syntax

The syntax of [SATIS files](syntax.md) and [feature files](features.md) is essentially very 
simple. 

The whole file comprises a series of _sections_. Each section is:

 * started by a _section header_, 

and is followed by:

 * optionally, one or more _declarations_ (SATIS files) or _steps_ (feature files);

 * text which can contain one or more _payload areas_. 
 
The end of a section is demarcated by either the start of another section or the end of the 
file. 

Every section header begins with one or more `#` hash symbols followed by a _section keyword_ 
which is then, for some kinds of section, followed by (optionally, a colon `:` character 
and then) a _section title_. The section header is ended by a blank line. 

Each different section keyword indicates what kind of section the header begins.






Within a section, immediately following the section header, one or more _declarations_ can be
added. Each declaration must be in the form of a list item which begins with a
_declaration keyword_

..........

The declarations apply to the section they are in.



A blank line is considered to be a line that contains no characters or that only contains 
whitespace characters. A whitespace character is considered to be either an HT (code 9) or a 
SPACE (code 32).

The significant characters of a keyword are: 

 * the roman letters A-Z, upper or lower case does not matter; 
 
 * digits 0-9.
 
All other punctuation is ignored. 

Each declaration keyword and the text following it---which may comprise multiple lines without any blank 
line---forms the declaration. 

Each section keyword and the text following it---which may comprise multiple lines without any blank 
line---forms the section header 

A section keyword can be followed by (optionally, a `:` colon character and then) a _title_. If the 
title 
includes text between `{` braces `}`, the text between the braces

.....

 is ignored by SATIS. 



A type word .........


For Ada source text it is permitted for the leader line to comprise three backticks immediately 
followed by the word `ada` in lower case; this is recommended but not required. 



Text outside of section headers, declarations, and payload areas are ignored by SATIS. This can 
be, and should be, 
used to put in documentation.

..........




The purpose of all this is to make it possible for a SATIS or MDG file to be understood by a 
Markdown 
processor.

See [The Markdown Guide](https://www.markdownguide.org) for information about Markdown.
Also, see the [CommonMark Specification v0.29](https://spec.commonmark.org/0.29/). 

Specifically, we aim at [GitHub Flavored Markdown](https://github.github.com/gfm/) as our 
primary standard to be compatible with. 



Documentation lines may be 
marked up using Markdown syntax. 

.......

The correctness, in terms of Markdown syntax, of any of the documentation lines is 
not checked by SATIS.




-----------------------------------------------------------------------------------------------
## Payload Areas

A _payload area_ contains data or Ada source text, whose meaning depends on the kind of 
section. The _payload_ of a section comprises all of the contents of its payload areas 
concatenated in the same order that they appear in the file. Some kinds of section do not have 
(or allow) a payload. 

A payload area is: 

 1. three back-tick (or grave) `` ``` `` characters on a line, possibly followed by a
    _type word_; 
 
 2. lines that are the _content_ of the payload area; 
 
 3. another three back-tick (or grave) `` ``` `` characters on a line alone. 









