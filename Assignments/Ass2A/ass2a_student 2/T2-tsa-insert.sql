/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-tsa-insert.sql

--Student ID: 33049246
--Student Name: Xiaowen Zhou
--Unit Code: FIT2094
--Applied Class No: Applied 01, Melbourne Wed 18:00

/* Comments for your marker:

*/

---**This command shows the outputs of triggers**---
---**Run the command before running the insert statements.**---
---**Do not remove**---
SET SERVEROUTPUT ON
---**end**---

--------------------------------------
--INSERT INTO cabin
--(resort_id, cabin_no, cabin_nobedrooms, cabin_sleeping_capacity, cabin_bathroom_type, cabin_points_cost_day, cabin_description)
--------------------------------------
  -- Resort 1 (with 2 cabins)
INSERT INTO cabin VALUES
  (1, 1, 2, 4, 'I', 100, 'Cosy cabin with two bedrooms');
INSERT INTO cabin VALUES
  (1, 2, 3, 6, 'C', 120, 'Huge cabin with common bathroom');
  
  -- Resort 2 (with 1 cabin)
INSERT INTO cabin VALUES
  (2, 1, 2, 4, 'I', 80, 'Rustic cabin with two bedrooms');

  -- Resort 3 (with 3 cabins)
INSERT INTO cabin VALUES
  (3, 1, 1, 2, 'I', 60, 'Small cabin with one bedroom');
INSERT INTO cabin VALUES
  (3, 2, 2, 4, 'I', 80, 'Comfortable cabin with two bedrooms');
INSERT INTO cabin VALUES
  (3, 3, 4, 8, 'C', 150, 'Luxurious cabin with common bathroom');

  -- Resort 4 (with 1 cabin)
INSERT INTO cabin VALUES
  (4, 1, 3, 6, 'C', 100, 'Large cabin with common bathroom');
  

  -- Resort 5 (with 2 cabins)
INSERT INTO cabin VALUES
  (5, 1, 2, 4, 'I', 90, 'Modern cabin with two bedrooms');
INSERT INTO cabin VALUES
  (5, 2, 1, 2, 'I', 70, 'Beautiful cabin with one bedroom');

--------------------------------------
--INSERT INTO booking
--(booking_id, resort_id, cabin_no, booking_from, booking_to, booking_noadults, booking_nochildren, booking_total_points_cost, member_id, staff_id)
--------------------------------------
  -- Booking 1
INSERT INTO booking VALUES
  (1, 1, 1, TO_DATE('2023-03-05', 'YYYY-MM-DD'), TO_DATE('2023-03-12', 'YYYY-MM-DD'), 2, 1, 700, 1, 1);

  -- Booking 2
INSERT INTO booking VALUES
  (2, 1, 2, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-03-17', 'YYYY-MM-DD'), 3, 0, 840, 2, 1);

  -- Booking 3
INSERT INTO booking VALUES
  (3, 2, 1, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2023-03-22', 'YYYY-MM-DD'), 1, 0, 560, 3, 2);
  
  -- Booking 4
INSERT INTO booking VALUES
  (4, 3, 1, TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('2023-03-27', 'YYYY-MM-DD'), 4, 1, 840, 4, 2);

  -- Booking 5
INSERT INTO booking VALUES
  (5, 3, 2, TO_DATE('2023-03-25', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 2, 2, 720, 5, 3);
  
  -- Booking 6
INSERT INTO booking VALUES
  (6, 3, 2, TO_DATE('2023-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-08', 'YYYY-MM-DD'), 3, 1, 960, 6, 4);
    
-- Booking 7
INSERT INTO booking VALUES
  (7, 4, 1, TO_DATE('2023-04-05', 'YYYY-MM-DD'), TO_DATE('2023-04-12', 'YYYY-MM-DD'), 2, 0, 700, 7, 4);

  -- Booking 8
INSERT INTO booking VALUES
  (8, 5, 1, TO_DATE('2023-04-10', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'), 2, 1, 630, 8, 5);

  -- Booking 9
INSERT INTO booking VALUES
  (9, 5, 2, TO_DATE('2023-04-15', 'YYYY-MM-DD'), TO_DATE('2023-04-22', 'YYYY-MM-DD'), 3, 2, 810, 9, 5);

  -- Booking 10
INSERT INTO booking VALUES
  (10, 1, 1, TO_DATE('2023-04-20', 'YYYY-MM-DD'), TO_DATE('2023-04-27', 'YYYY-MM-DD'), 2, 0, 700, 10, 6);

  -- Booking 11
INSERT INTO booking VALUES
  (11, 2, 1, TO_DATE('2023-03-08', 'YYYY-MM-DD'), TO_DATE('2023-03-15', 'YYYY-MM-DD'), 2, 2, 800, 11, 7);

  -- Booking 12
INSERT INTO booking VALUES
  (12, 2, 1, TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2023-03-17', 'YYYY-MM-DD'), 3, 1, 840, 12, 7);

  -- Booking 13
INSERT INTO booking VALUES
  (13, 3, 3, TO_DATE('2023-03-12', 'YYYY-MM-DD'), TO_DATE('2023-03-19', 'YYYY-MM-DD'), 4, 0, 1200, 13, 8);

  -- Booking 14
INSERT INTO booking VALUES
  (14, 3, 3, TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2023-03-22', 'YYYY-MM-DD'), 3, 2, 1500, 14, 8);

  -- Booking 15
INSERT INTO booking VALUES
  (15, 4, 1, TO_DATE('2023-03-18', 'YYYY-MM-DD'), TO_DATE('2023-03-25', 'YYYY-MM-DD'), 2, 0, 700, 15, 9);

  -- Booking 16
INSERT INTO booking VALUES
  (16, 4, 1, TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('2023-03-27', 'YYYY-MM-DD'), 2, 1, 800, 16, 9);

  -- Booking 17
INSERT INTO booking VALUES
  (17, 4, 1, TO_DATE('2023-03-25', 'YYYY-MM-DD'), TO_DATE('2023-04-01', 'YYYY-MM-DD'), 3, 2, 900, 17, 10);

  -- Booking 18
INSERT INTO booking VALUES
  (18, 5, 2, TO_DATE('2023-03-28', 'YYYY-MM-DD'), TO_DATE('2023-04-04', 'YYYY-MM-DD'), 4, 0, 720, 18, 11);
  
-- Booking 19
INSERT INTO booking VALUES
  (19, 5, 2, TO_DATE('2023-03-30', 'YYYY-MM-DD'), TO_DATE('2023-04-06', 'YYYY-MM-DD'), 2, 1, 630, 19, 11);

  -- Booking 20
INSERT INTO booking VALUES
  (20, 5, 2, TO_DATE('2023-04-02', 'YYYY-MM-DD'), TO_DATE('2023-04-09', 'YYYY-MM-DD'), 3, 0, 810, 20, 12);