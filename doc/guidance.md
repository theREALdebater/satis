# Guidance on the Use of SATIS

Since in many cases the use of SATIS is going to come a long time after the beginning of an Ada 
software project, SATIS is intended to be adaptable to a variety of existing directory 
structures, file naming conventions, and so on. 

To this end, ......

Nevertheless, we propose a suggested directory structure here, which we believe is likely to 
serve well. If you are unsure what structure to use, or if you can easily adapt your existing 
structure to it, we suggest you adopt the following.


### Localise

Locate all your unit testing files – for example SATIS source files and those Ada source files
which are only needed to support the tests in the SATIS files – near to the code that they
relate to. 

Ideally, in each source directory in your project tree, make a new directory directly within it 
named `testing`, and put all the related unit testing files into it. In doing this, start at 
the leaf directories and work towards the root. 

If you can, configure your non-testing builds to exclude all the `testing` directories. Of
course, for the unit testing builds, they need to be included (but we'll discuss that more 
below). 


### Separate

Designate a separate directory tree for the `satis` program to target. You do this by passing 
the `--directory` flag (as one argument) followed by the full path (as the next argument). 

### 



