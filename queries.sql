--1 Retrieve a list of the tenants staying in the co-living in 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', together with their name, surname, national ID.
SELECT t.tenant_name, t.surname, t.national_id
FROM co_living.tenant as t
INNER JOIN co_living.contract as c ON t.tenant_id = c.tenant_ID
WHERE c.co_living_address = 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy';


--2. Retrieve the list of the applicants with their related information that are accepted for the next renting of the co-living 'Via Luigi Cadorna,9,Padova,35123,Padova,Italy'.
SELECT A.applicant_id, A.applicant_name, A.surname, A.email, A.income_info
FROM co_living.applicant AS A
INNER JOIN co_living.standard_queue AS S
ON A.applicant_id=S.applicant_id
WHERE A.accepted=true
AND S.co_living_address='Via Luigi Cadorna,9,Padova,35123,Padova,Italy';


--3. List the managers of the tenants who have rated a co-living higher than 8, alongside with the grade and the review.

Select manager_name, manager_surname, grade, review 
From co_living.Manager AS M 
Inner Join (
	(Select * From co_living.rate Where grade>8) AS R 
	Inner Join co_living.Contract AS C ON R.tenant_id=C.tenant_id) 
As L On M.manager_id=L.manager_id;


--4. Select which tenant invited a guest in the 'Cooking class' event.
SELECT Q.tenant_name
FROM 
(SELECT * FROM co_living.tenant AS T
 INNER JOIN (Select * FROM co_living.guest AS G
  INNER JOIN (select * from co_living.guest_participation  where event_name = 'Cooking class' ) AS P
  ON G.guest_id = P.guest_id) AS S
ON T.tenant_id = S.tenant_id) AS Q;
