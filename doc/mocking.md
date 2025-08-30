# Mocking and Substitution

When performing unit tests, it is often a problem that other units invoked (called) by the
subject (function or procedure) do things that are inappropriate for the testing.



.....






For the purposes of making unit testing easier, SATIS provides (the source text of) a set of
mockable packages that can conveniently stand-in for a variety of standard Ada packages. 

For example, suppose the subject is a procedure that formats and outputs a report. It may be
appropriate to test that the formatting is done correctly, but actually outputting the report
is not. It may be that the subject procedure calls procedures in the standard Ada package
`Ada.Text_IO` to perform the output. By substituting that package with one that has exactly the
same visible part but whose procedure implementations actually do nothing, the subject can be
prevented from actually trying to output anything without needing to be modified or augmented. 

As another example, suppose the subject is a function that looks up data in an external
database as part of its calculation. It may be inappropriate to look up data from a database
during testing, but appropriate to test all other aspects of the calculation. In this case, a
package that is used to access the database could be substituted by a package that simply
returns a fixed set of data chosen to suit the purposes of the testing.





You may wish to add mocking functionality to your own packages, ....

SATIS comes with a command-line tool, named `ithax`, which can generate a mockable package by
reading the specification (Ada source text) of a package and generating (the Ada source text
of) a mockable version of that package. Just compile the mockable version into the appropriate
library as normal. 

See [Custom Mockables](#custom) for more.



A slightly different approach is provided by [substition](#subst), which is simply a technique
for easily substituting one library unit for another for the purposes of unit testing. 





-----------------------------------------------------------------------------------------------
## Substitution

_Substitution_ is the broad term for techniques that enable one library unit to be used instead
of another, to help facilitate particular unit tests. 

In your source text root directory, add a file, named `config-testing.ada` perhaps,  
containing renamings of all the packages you may wish to substitute. 

For example, supposing the project or company is named 'KwikAir', we have to define some base
packages, such as: 

```ada
package KwikAir is end; -- just a namespace

package KwikAir.Mockables 
is 
   -- any global entities to help with KwikAir's mocking
end;

package KwikAir.Production 
is 
   -- any globals to do with KwikAir's production (for-real) library units
end;
```

Then, for our unit testing, we declare some renamings:

```ada
with SATIS;

package KwikAir.Text_IO          renames SATIS.Mockables.Text_IO;
package KwikAir.Calendar         renames SATIS.Mockables.Calendar;
package KwikAir.Flight_Planning  renames KwikAir.Mockables.Flight_Planning;
...
```

Add files to rename `Ada.Sequential_IO`, `Ada.Direct_IO`, and all the other standard mockable 
packages in the same way. 

Now make another file, named `config-production.ada` maybe, that renames the exact same set of 
packages to their corresponding production (or standard) counterparts, for example: 

```ada

with Ada;

package KwikAir is end; -- just a namespace

package KwikAir.Text_IO          renames Ada.Text_IO;
package KwikAir.Calendar         renames Ada.Calendar;
package KwikAir.Flight_Planning  renames KwikAir.Production.Flight_Planning;
...
```

Change the remainder of your source text to refer to `KwikAir.Text_IO` instead of `Ada.Text_IO`
(including in `with` and `use` clauses), and to refer to `KwikAir.Calendar` instead of
`Ada.Calendar`, and so on for all the other substitute packages. 

All the generic packages, such as `Ada.Text_IO.Integer_IO` for example, have SATIS substitute 
packages, which should be used instead. 

Use whatever build control tools suite you prefer (or is suited to your Ada compiler or your 
build environment) to include either: 

 * `config-production.ada`, when you are building a live (production) deployment; or 
 
 * `config-testing.ada`, when you are building unit tests. 

Internally, all the SATIS source text refers to the standard packages (`Ada.Text_IO` and so
forth), so it will not be affected. 

This technique has the advantage that it can be introduced into a large body of software
gradually, in stages, which may be the only practicable way to do so. 



-----------------------------------------------------------------------------------------------
## Mockable Packages

A _mockable package_ is any library package that has a child package named `Mocking` and which
has special behaviour, known as _mocking behaviour_ when mocking is enabled. 

There some things that will be common to all `Mocking` packages, but there will also be some
things that are specific to each different `Mocking` package and its parent mockable package.

The specific things are termed _specialised_. 

There are a number of mockable packages provided along with SATIS for you to immediately use.

You may wish to add mocking functionality to your own packages, ....

SATIS comes with a command-line tool, named `ithax`, which can generate a mockable package by
reading the specification (Ada source text) of a package and generating (the Ada source text
of) a mockable version of that package. Just compile the mockable version into the appropriate
library as normal. See [Custom Mockables](#custom-mockables) for more.


.....



-----------------------------------------------------------------------------------------------
## Mocking Mode

The `Mocking` child package always declares an enumeration type named `Mocking_Mode`. 

This type will always have two values, but may have more. The first value will always be named
`Normal`. Any other values are specialised, but often there will be only one other value, named
`Bypass`. 

There is always a property named `Mode` of type `Mocking_Mode`. There will be a parameterless
function `Mode` which returns a `Mocking_Mode`, and a procedure named `Set_Mode` which takes
one `Mocking_Mode` parameter named `Mode`. There may also be convenience functions or
procedures associated with the mode, but these are specialised. 

As a convenience, for every mode `M`, there is a parameterless procedure named `Set_Mode_M`,
which is the equivalent of `Set_Mode(M)`. 

The values of `Mocking_Mode` are the different kinds of _mocking mode_ of the mockable package.
At any one time, the package is (globally) in one mocking mode, and this will control the
behaviour of the package, especially most or all of its subprograms. The default mode is
`Normal`. 

When the mockable package's mocking mode is `Normal`, the package does what it is intended to
do normally. Its state is normal, is updated normally, and all of its subprograms act normally. 

When the mockable package's mocking behaviour is not `Normal`, however, the package behaves
differently. In any mode other than normal, the package has mocking behaviour. 

When in the often available `Bypass` mode, the package's subprograms, in essence, do nothing.
In `Bypass` mode, functions will typically return some empty, null, dummy, or default value. 

.....



-----------------------------------------------------------------------------------------------
## Call Interception

If a mockable package has a subprogram named `P`, the mocking functionality might add a variety
of facilities regarding `P`.

One of them---generally, the principal one---is _interception_. This calls a specific
procedure, called the _interceptor_ of `P`, every time that `P` is called. 

The type `Interceptor_P` .....

```ada
type Call_Sequence_Count is range 0 .. <implementation-defined>;

type Call_Sequence_Index is Call_Sequence_Count range 1 .. Call_Sequence_Count'Last;

type Call_Information_P is private;



type Interceptor_P is access 
   procedure (Seq:  in  Call_Sequence_Index;
              Info: out Call_Information_P);

```

The `Mockable` child package will contain a procedure named `Intercept_P`, with a parameter named `Interceptor` 
of the type `Interceptor_P`
of the type `Call_Mocker`. 

The `params` are all the parameters of `P`, in the same order, without any defaults. The
`Returns` parameter is only present if `P` is a function, in which case `returntype` is its
return type. 

Calling `Mock_P` sets the mocker of `P`. It is valid to set the mocker to null,
which is its default value. 

The mocker of `P` is called every time `P` is called, unless the mocker is null. The parameter
`N` is set to the _call sequence number_ of the call to `P`. 

The call sequence number of `P` starts at 0 and is incremented once for every call to `P`
(before the mocker is called). So, for the first call of `P`, `N` will be 1. 

The procedure `Reset_Call_Sequence_P` causes the call sequence number of `P` to be set to 0. 

When `P` is called when its mocker is null, and mocking is enabled: 

 * if `P` is an (effectively) pure function or procedure, it does the same as normal (when
   mocking is disabled), and therefore returns the same return value or out-mode parameter
   values, but only if this doesn't require a very large amount of compute resource; 

 * otherwise, the call essentially does nothing, except any out-mode parameters are set to
   'reasonable' values, that are representative of what they might be set to normally (when
   mocking is disabled), and which are not likely to upset the execution of tests. 



-----------------------------------------------------------------------------------------------
## Call Counting

One of the facilities relating to subprogram `P` is _call counting_. This simply counts the
number of times that `P` is called.

The `Mockable` child package will contain a procedure named `Reset_Call_Count_P`, which sets
the call count for `P` to 0. Obviously, this count is initially 0 anyway. 

The `Mockable` child package will also contain a function named `Call_Count_P`, which returns
the number of times `P` has been called (since it was last reset). It returns a `Natural`, so
if `P` is called a very large number of times, the call count may go out of range. This will
simply cause a call to `P`, after it has been called n times, to propagate the exception
`Call_Count_Range_Error`, where n is `Natural'Last`.

The exception `Call_Count_Range_Error` is declared in the `Mockable` child package.


-----------------------------------------------------------------------------------------------
## Call Verification

Another facility for a subprogram `P` is _call verification_. 

The `Mockable` package will contain a procedure named `Verify_Call_P`, with a parameter
`Verify` of the type `Call_Verifier_P`. 

The type `Call_Verifier_P` is declared in the 
`Mockable` child package
as:

```ada

type Call_Verifier_P is access function (N: in Positive; params) return Boolean;
```

The `params` are the in-mode parameters of `P`, in the same order, without any defaults.
Remember that `access` and `in out` parameters are considered to be in-mode. 

Calling `Verify_Call_P` sets the verifier of `P`. It is valid to set the verifier to null,
which is its default value. 

The verifier of `P` is called every time `P` is called, unless the verifier is null.

If the verifier is called and returns `False`, .....












-----------------------------------------------------------------------------------------------
## Standard Mockable Packages

SATIS comes with a set of mockable versions of all the standard Ada packages, called the
_standard mockable packages_. 


.....




| Package               | Substitute                        |
| -------               | ----------                        |
| `Ada.Text_IO`         | `SATIS.Mockables.Text_IO`         | 
| `Ada.Calendar`        | `SATIS.Mockables.Calendar`        | 
| `Ada.Sequential_IO`   | `SATIS.Mockables.Sequential_IO`   |
| `Ada.Direct_IO`       | `SATIS.Mockables.Direct_IO`       |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `Ada.` | `SATIS.Mockables.` |
| `` | `` |
| `` | `` |
| `` | `` |
| `` | `` |
| `` | `` |
| `` | `` |
| `` | `` |

The variations of packages prefixed with `Wide_` or `Wide_Wide` also all have mockable
versions. 



-----------------------------------------------------------------------------------------------
## SATIS Mockables

.....

As well as providing the usual facilities ([interception](#call-interception),
[counting](#call-counting), [verification](#call-verification)]), the standard mockables
packages provide a variety of extra facilities related to their function, and aimed at
supporting unit testing. 

.....


### `SATIS.Mockables.Text_IO`

The package `SATIS.Mockables.Text_IO` has an extra mocking mode `Capture`. 

In the mocking mode `Capture`, the sequence of characters written into standard output are
recorded in a memory buffer, which can be retrieved for analysis. For example, in a unit test,
the test may put the `Text_IO` package into the mocking mode `Capture`, then call the SUT, then
retrieve the captured text, and compare it with an expected value. 

The following procedures are declared in the `Mocking` child package: 

```ada
procedure Clear_Captured_Data;

procedure Extract_Captured_Data (Target: out [Wide_][Wide_]Unbounded_String);
```

The  procedure `Clear_Captured_Data` erases the buffer (so it contains no characters). 

The  procedure `Extract_Captured_Data` copies the character sequence in its buffer into
`Target`, and then erases the buffer. 

In the mocking mode `Bypass`, no characters are captured into the buffer. 


### `SATIS.Mockables.Calendar`

The package `SATIS.Mockables.Calendar` has mocking modes `Normal` and `Controlled`. 

In the mocking mode `Controlled`, ..... allows clock to be pre-set

```ada
procedure Set_Clock


```



### `SATIS.Mockables.Sequential_IO`




### `SATIS.Mockables.Direct_IO`




### `SATIS.Mockables.`




### `SATIS.Mockables.`




### `SATIS.Mockables.`




### `SATIS.Mockables.`




### `SATIS.Mockables.`




-----------------------------------------------------------------------------------------------
## Custom Mockables

You may wish to add mocking functionality to your own packages, .....

The easiest way is to use the [Ithax](#ithax) utility, but you could write your own .....




### Hand-Written Mockable

You can create your own mockable package by just writing by hand. This might be a rather .....

For a package of your own named `x`.

Modify the implementation (primarily its private part and body) of package `x` so that it 
has internal flags and functionality to support whatever mocking functionality you require, as 
well normal operation. 

Create a new package `x.Mockable` which declares the `Mocking_Mode` enumeration type, with the
value `Normal`, and values for whatever other mocking modes you require. In this package's
specification, declare everything to support controlling the mocking functionality you require,
and providing the means to obtain information regarding that functionality. 



-----------------------------------------------------------------------------------------------
## Ithax

SATIS comes with a command-line tool, named `ithax`, which can generate a mockable package by
reading the specification (Ada source text) of a package and generating (the Ada source text
of) a mockable version of that package. Just compile the mockable version into the appropriate
library as normal. 

[Picat](picat.md) is needed to run Ithax. 




For example, the command:

```
picat ithax kwikair-booking-enquiries.ads
```

Will cause Ithax to read and search the given file `kwikair-booking-enquiries.ads` for package
specifications. 

Supposing Ithax finds a package specification named `KwikAir.Booking.Enquiries`, it will generate:

????? * a mockable version of package `KwikAir` named `Mockables.KwikAir`;
 
????? * a mockable version of package `KwikAir.Booking` named `Mockables.KwikAir.Booking`;
 
 * a mockable version of package `KwikAir.Booking.Enquiries` named `Mockables.KwikAir.Booking.Enquiries`;

Each of these three generated mockable packages will have an inner package named `Mocking`.

Every package named `Mocking` will have a declaration of the enumeration type `Mocking_Mode`
with two values: `Normal` and `Bypass`. 





.....











-----------------------------------------------------------------------------------------------
##






-----------------------------------------------------------------------------------------------
##






-----------------------------------------------------------------------------------------------
##






-----------------------------------------------------------------------------------------------
##






-----------------------------------------------------------------------------------------------
##






-----------------------------------------------------------------------------------------------
##






