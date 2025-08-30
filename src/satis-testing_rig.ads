





generic
   type Category_Set is (<>);

package SATIS.Testing_Rig
is
   package Category_Sets is new package Tenet.Bit_Sets (Category_Set);

   procedure Run_Tests (Scenarios:  in Scenario_Set; 
                        Categories: in Rig.Category_Sets.Set;
                        Verbosity:  in Output_Verbosity);
end;


