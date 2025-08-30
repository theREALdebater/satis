# Sample Generated Source Text

........







-----------------------------------------------------------------------------------------------
## Package `Unit_Testing`

.....

```ada

with SATIS;

package Kwikair.Unit_Testing
is
   type Category_Number is range 1 .. 3; --- however many categories there are
   
   type Battery_Number is range 1 .. 3; --- however many batteries there are
   
   function Title (Category: in Category_Number) return Wide_String;
   
   function Title (Battery: in Battery_Number) return Wide_String;

   type Scenario_Process is access procedure (Scenario: access SATIS.Scenario_Context'Class);

   procedure Iterate_Scenarios (Battery: in Battery_Number; Process: in Scenario_Process);
   
   package Rig is new SATIS.Testing_Rig (Category_Number, Battery_Number);
end;
```

.....

The corresponding package body .....

```ada

with Kwikair.Unit_Testing.Scenario_1;
...
with Kwikair.Unit_Testing.Scenario_26;

package body Kwikair.Unit_Testing
is
   function Title (Category: in Category_Number) return Wide_String
   is
   begin
      case Category is
         when 1 => return "Basics";
         when 2 => return "Essential constants for booking";
         --- etc for all categories
      end case;
   end;

   function Title (Battery: in Battery_Number) return Wide_String
   is
   begin
      case Battery is
         when 1 => return "Default";
         when 2 => return "Ancillary Functions";
         --- etc for all batteries
      end case;
   end;

   procedure Iterate_Scenarios (Battery: in Battery_Number; Process: in Scenario_Process)
   is
   begin
      case Battery is

         when 1 => -- Default
            Process (Kwikair.Unit_Testing.Scenario_1.Scenario_Context'Access); -- Fundamental data sanity
            Process (Kwikair.Unit_Testing.Scenario_2.Scenario_Context'Access); -- ...
            Process (Kwikair.Unit_Testing.Scenario_3.Scenario_Context'Access); -- ...

         when 2 => -- Ancillary Functions
            Process (Kwikair.Unit_Testing.Scenario_4.Scenario_Context'Access); -- ...
            Process (Kwikair.Unit_Testing.Scenario_5.Scenario_Context'Access); -- ...
            Process (Kwikair.Unit_Testing.Scenario_6.Scenario_Context'Access); -- ...
            Process (Kwikair.Unit_Testing.Scenario_7.Scenario_Context'Access); -- ...

         --- etc for all batteries
      end case;
   end;

end Kwikair.Unit_Testing;
```



-----------------------------------------------------------------------------------------------
## Scenario Packages

.....

```ada
with SATIS;

with Ada.Exceptions;

with Kwikair.Constants;
with Kwikair.Utility;

use Kwikair.Constants;

package Kwikair.Unit_Testing.Scenario_1
is
   type Scenario_Context
   is
      abstract new SATIS.Scenario_Context
   with
      private;
   
   override
   function Title (Scenario: in Scenario_Context) return Wide_String;

   override
   function Tests return SATIS.Test_Set;
end;
```

.....

The corresponding package body .....

```ada

package body Kwikair.Unit_Testing.Scenario_1
is
   type Scenario_Context
   is 
      abstract new SATIS.Scenario_Context
   with
      record
         --- scenario parameters
         Sample_Boeing_737_800: Aircraft_Reference := new Boeing_737_800; --- scenario declaration
         ...
         Aircraft_Spread: constant array (Positive range <>) of Aircraft_Reference :=
            (Sample_Boeing_737_800, ...); --- scenario declaration
      end record;

   override
   function Title (Scenario: in Scenario_Context) return Wide_String is 
      ("Fundamental data sanity");
   
   --- other scenario method declarations
   
   override
   procedure Setup_For_Test (Scenario: in out Scenario_Base_Context)
   is
   begin
   end;

   type Test_Context_1
   is 
      new Scenario_Context
   with
      record
         L1 := 0: Integer; -- longest seat ID length of aircraft in fleet
         L2: Integer; -- shortest maximum seat ID length for a particular booking agent
      end record;

   override
   function Test_Title (Test: in Test_Context) return Wide_String is
      ("Booking Seat ID Length");
   
   override
   function Time_Limit (Test: in Test_Context) return Duration is (5.0);

   override
   procedure Run_Test (Test: in out Test_Context_1)
   is
   begin
      Test.L1 := .....
      Test.L2 := .....
      Run_Test_Instance (Test);
   end;

   override
   procedure Run_Test_Instance (Test: in out Test_Context_1)
   is
   begin
      for Aircraft of Fleet loop
         for Seat of Aircraft loop
            if Length( Seat.ID ) > L1 then
               L1 := Length( Seat.ID );
            end if;
         end loop;
      end loop;

      if L2 >= L1 then
         Test.Pass;
      else
         Test.Fail;
         Test.Put( "Longest seat ID length of aircraft in fleet: " );
         Test.Put( L1 );
         Test.New_Line();
         Test.Put( "Shortest maximum seat ID length for a particular booking agent: " );
         Test.Put( L2 );
         Test.New_Line();
      end if;
   end Run_Test;
   
   --- further test contexts
   
   override
   function Tests (Scenario: in Scenario_Context) return SATIS.Test_Set
   is
      Result: SATIS.Test_Set;
   begin
      Result.Include (new Test_Context_1);
      Result.Include (new Test_Context_2);
      --- etc for all test contexts
      return Result;
   end;

end Kwikair.Unit_Testing.Scenario_1;
```



-----------------------------------------------------------------------------------------------
## Procedure `Run_Tests`

.....

```ada
with SATIS;
with Kwikair.Unit_Testing.Scenario_1;
with Kwikair.Unit_Testing.Scenario_2;
--- etc. for all scenarios

separate (Kwikair.Unit_Testing)
procedure Run_Tests
(
   Categories: in Rig.Category_Sets.Set := Rig.Category_Sets.Full_Set;
   Verbosity:  in Output_Verbosity := Normal_Verbosity
)
is
   Scenarios: Scenario_Set;
begin 
   Scenarios.Include (new Kwikair.Unit_Testing.Scenario_1.Scenario_Context);
   Scenarios.Include (new Kwikair.Unit_Testing.Scenario_2.Scenario_Context);
   --- etc. for all scenarios
   Rig.Run_Tests (Scenarios, Categories, Verbosity);
end Run_Tests;
```







-----------------------------------------------------------------------------------------------
## Main Subprogram

.....

The main subprogram will need to: 

 1. Determine the categories and verbosity required by the user, possibly by parsing the 
    program arguments (including options); 
    
 2. Call the `Run_Tests` procedure generated by SATIS .....
 
.....

For example:

```ada
with Kwikair.Unit_Testing;

procedure Main
is
   Categories: in Rig.Category_Sets.Set := Rig.Category_Sets.Full_Set;
   Verbosity:  in Output_Verbosity := Normal_Verbosity
begin
   --- parse program arguments and options into Categories and Verbosity
   Kwikair.Unit_Testing.Run_Tests (Categories, Verbosity);
end;
```

.....




-----------------------------------------------------------------------------------------------
## 





