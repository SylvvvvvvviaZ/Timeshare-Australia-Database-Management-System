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
  -- Resort 1 (with 3 cabins)
INSERT INTO cabin VALUES
  (1, 1, 2, 4, 'I', 100, 'Spacious cabin with a beautiful view');
INSERT INTO cabin VALUES
  (1, 2, 2, 4, 'C', 80, 'Cozy cabin near the lake');
INSERT INTO cabin VALUES
  (1, 3, 3, 6, 'I', 120, 'Rustic cabin surrounded by nature');
  
  -- Resort 2 (with 2 cabin)
INSERT INTO cabin VALUES
  (2, 1, 3, 6, 'I', 120, 'Rustic cabin surrounded by nature');
INSERT INTO cabin VALUES
  (2, 2, 4, 8, 'I', 200, 'Luxurious cabin with modern amenities');

  -- Resort 3 (with 3 cabins)
INSERT INTO cabin VALUES
  (3, 1, 1, 2, 'I', 90, 'Quaint cabin in a peaceful location');
INSERT INTO cabin VALUES
  (3, 2, 2, 4, 'I', 140, 'Charming cabin with a fireplace');
INSERT INTO cabin VALUES
  (3, 3, 1, 2, 'I', 120, 'Secluded cabin surrounded by forests');

  -- Resort 4 (with 2 cabin)
INSERT INTO cabin VALUES
  (4, 1, 1, 2, 'I', 110, 'Secluded cabin surrounded by forests');
INSERT INTO cabin VALUES
  (4, 2, 2, 4, 'C', 70, 'Affordable cabin for budget travelers');

  -- Resort 5 (with 4 cabins)
INSERT INTO cabin VALUES
  (5, 1, 2, 4, 'I', 120, 'Modern cabin with stunning mountain views');
INSERT INTO cabin VALUES
  (5, 2, 3, 6, 'C', 90, 'Cozy cabin with access to outdoor activities');
INSERT INTO cabin VALUES
  (5, 3, 2, 4, 'I', 120, 'Nice cabin with good mountain views');
INSERT INTO cabin VALUES
  (5, 4, 2, 4, 'C', 100, 'Rustic cabin with a fireplace');

 -- Resort 6 (with 4 cabins)
INSERT INTO cabin VALUES
  (6, 1, 2, 4, 'I', 100, 'Cozy cabin in a secluded forest');
INSERT INTO cabin VALUES
  (6, 2, 1, 2, 'C', 100, 'Cabin with private beach access');
INSERT INTO cabin VALUES
  (6, 3, 2, 4, 'I', 120, 'Spacious cabin with outdoor activities');
INSERT INTO cabin VALUES
  (6, 4, 3, 6, 'I', 120, 'Family cabin with game room');
  
-- Resort 7 (with 2 cabins)
INSERT INTO cabin VALUES
  (7, 1, 2, 4, 'C', 50, 'Cabin with lake access and BBQ area');
INSERT INTO cabin VALUES
  (7, 2, 1, 2, 'C', 100, 'Modern cabin with a hot tub');
  
--------------------------------------
--INSERT INTO booking
--(booking_id, resort_id, cabin_no, booking_from, booking_to, booking_noadults, booking_nochildren, booking_total_points_cost, member_id, staff_id)
--------------------------------------
  -- Booking 1
INSERT INTO booking VALUES
  (1, 1, 1, TO_DATE('2023-03-05', 'YYYY-MM-DD'), TO_DATE('2023-03-12', 'YYYY-MM-DD'), 2, 1, 700, 1, 1);
  
