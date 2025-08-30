# Step Patterns

A _step pattern declaration_ associates a scenario setup or tear-down section, or a test 
section, with [steps in a feature file](features.md#steps) .......

.....


### Example: Scenario Setup

.....

    ## Scenario Declarations
    
    ```ada
    Flights: Flight_Roster;
    ```

.....

    ## Scenario Setup
    
     * Step: We try to book a party of <n> passengers onto flight <f>.

     * Placeholder: <n> name `Seats_To_Book` type `Seat_Count`
     * Placeholder: <f> name `Flight_Id` type `String`

    ```ada
    declare
       Flight: Flight_Record;
    begin
       Flight.Id := Flight_Id;
       Flights.Insert (Flight);
    end;
    ```

.....

    ## Scenario Setup
    
     * Step: Flight <f> has <n1> spare seats.

     * Placeholder: <f>   name `Flight_Id`       type `String`
     * Placeholder: <n1>  name `Unbooked_Seats`  type `Seat_Count`

    ```ada
    Flights(Flight_Id).Seats_Available := Unbooked_Seats;
    ```


### Example: Test

.....

    ## Test: Booking a seat should reduce the number of available seats by one

     * Step: Flight <f> should have <n2> spare seats. 

     * Placeholder: <f>   name `Flight_Id`       type `String`
     * Placeholder: <n2>  name `Unbooked_Seats`  type `Seat_Count`

    ```ada
    Test.Assert (Flights(Flight_Id).Seats_Available = Unbooked_Seats);
    ```

.....





