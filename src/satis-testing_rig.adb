package body SATIS.Testing_Rig
is
   package Category_Sets is new package Tenet.Bit_Sets (Category_Set);
   
   type Test_Access is access SATIS.Test_Context'Class;
   
   type Test_Queue_Count is 0 .. 100;
   subtype Test_Queue_Index is 1 .. Test_Queue_Count'Last;   
   
   protected type Test_Controller
   is
      function Count return Test_Queue_Count;
      procedure Insert (Test: in  Test_Access);
      procedure Remove (Test: out Test_Access);
      procedure Set_All_Done; -- signals that there will be no more insertions
      procedure All_Done; -- simply blocks until 'all done' has been set
   private
      Queue:     array (Test_Queue_Index) of Test_Access;
      Filled:    Test_Queue_Count := 0;
      Next_Free: Test_Queue_Index := 1;
      Next_Take: Test_Queue_Index := 1;
      No_More:   Boolean := False;
   end;

   task type Worker_Task (Controller: access Test_Controller) is end;

   procedure Run_Tests (Scenarios:  in Scenario_Set; 
                        Categories: in Rig.Category_Sets.Set;
                        Verbosity:  in Output_Verbosity)
   is
      Controller: aliased Test_Controller;
      Workers: array (Worker_Index) of Worker_Task (Queue'Access);
      S_Num: Scenario_Number := 0;
      T_Num: Test_Number;
   begin
      for S in Scenarios
      loop
         if (for some C in S.Categories => Is_In (C, Categories))
         then
            S_Num := S_Num + 1;
            Scenario.Number := S_Num;
            T_Num := 0;
            for T in S.Tests
            loop
               T_Num := T_Num + 1;
               T.Number := T_Num;
               T.Verbosity := Verbosity;
               Queue.Insert (T);
            end loop;      
         end if;
      end loop;
      Queue.Set_All_Done;
   end Run_Tests;



   procedure Test_Starting (Test: access Test_Context'Class)
   is
   begin
   
   
   end;

   procedure Test_Completed (Test: access Test_Context'Class)
   is
   begin
   
      ..... Test.Scenario.Number, Test.Number, Test.Title .....

   
   end;

   procedure Test_Errored (Test:  access Test_Context'Class;
                           Error: in     Exception_Instance)
   is
   begin
   
      ..... Test.Scenario.Number, Test.Number, Test.Title, Ada.Exceptions.Wide_Exception_Information (Error) .....
   
   end;

   procedure Test_Timed_Out (Test: access Test_Context'Class)
   is
   begin
   
      ..... Test.Scenario.Number, Test.Number, Test.Title .....
   
   end;




   
   
   
   
   protected body Test_Controller
   is
      function Count return Test_Queue_Count
      is
         (Filled);

      function Next (N: in Test_Queue_Count) return Test_Queue_Count
      is
         (if N = Test_Queue_Count'Last then 1 else N + 1);

      when Filled < Test_Queue_Count'Last
      =>
      procedure Insert (Test: in  Test_Access)
      is
      begin
         if No_More then raise Program_Error; end if;
         Queue (Next_Free) := Test;
         Next_Free := Next (Next_Free);
         Filled := @ + 1;
      end;

      when Filled > 0
      =>
      procedure Remove (Test: out Test_Access)
      is
      begin
         Test := Queue (Next_Taken);
         Next_Taken := Next (Next_Taken);
         Filled := @ - 1;
      end;
      
      procedure Set_All_Done
      is
      begin
         No_More := True;
      end;

      when No_More and Filled = 0
      =>
      procedure All_Done is null;
   end;
   


   
   
   task body Worker_Task (Controller: access Test_Controller)
   is
      Test: Test_Access;
   begin
      loop
         select
            Controller.All_Done;
            exit;
         else
            Controller.Remove (Test);
            Test_Starting (Test);
            select
               delay Test.Timeout;
               Test_Timed_Out (Test);
            then abort
               begin
                  Test.Run_Test;
               exception
                  when E: Testing_Error =>
                     Test.Fail (Ada.Exceptions.Wide_Exception_Message (E)); -- test fail
                  when E: others =>
                     goto Test_Error;
               end Run_Test;
            end select;
            Test_Completed (Test);
            goto Next_Test;
         <<Test_Error>>
            Test_Errored (Test, E); -- error during test
         <<Next_Test>>
         end select;
      end loop;
   end;
   
   


end SATIS.Testing_Rig;

