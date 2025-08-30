# Time Manipulations

There may be some test subjects (procedures or functions) for which unit testing depends on the 
current time, specifically the result of calling the `Ada.Calendar.Clock` function. 

Using [substitution](substitutions.md) of the package `Ada.Calendar` by the package 
`SATIS.Calendar`, the result of the `Clock` function can be controlled. 

The package `SATIS.Calendar` adds a child package named `Mocking`, with the following
declarations visible, as described below.


-----------------------------------------------------------------------------------------------
## Package `SATIS.Calendar.Mocking`

The package `SATIS.Calendar.Mocking`, has the following declarations visible. 


### Mocking Mode

The enumerated type `Mocking_Mode` has two values: 

 * `Normal`, in which the clock ticks forward in real time; 
 
 * `Frozen`, in which the clock remains at its current time and does not change. 

The package `SATIS.Calendar.Mocking` has four properties, as a part of global state:

 * `Mode`, a mocking mode, of type `Mocking_Mode`; 
 
 * `Offset`, a clock offset, of type `Duration`;
 
 * `Offsets`, an array of clock presets, each of type `Time`; 
 
 * `Step`, a clock preset index, of type `Natural`.



By default, the mode is `Normal`, the clock offset is 0.0, the clock preset array is an 
empty array, and the clock preset index is 0 (indicating presets are not to be returned). 



, but it 
can be changed.

The function `Mode` returns the current clock mode.

The procedure `Set_Mode` can change the current clock mode. 




If the mode is changed from 
`Normal` to `Frozen`, 



The package `SATIS.Calendar.Mocking` also retains a 

.....


-----------------------------------------------------------------------------------------------





