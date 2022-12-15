--MANAGEMENT TEAM MEMBER
INSERT INTO co_living.manager (manager_id, manager_name, manager_surname, manager_phone, manager_email) VALUES 
('id card,18672692', 'Jones', 'Benjamin', '+39316098433','jones.benjamin@gmail.com'),
('id card,28391821', 'Kingsley', 'Marina', '+39396081418', 'kingsley.marina@gmail.com'),
('passport,FE83726153', 'Alan', 'Peter', '+39372033508', 'alan.peter@gmail.com');

--COLIVING
INSERT INTO co_living.co_living (co_living_address, emergency_contacts, amenities, facilities, manager_id) VALUES 
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', '{"+39316098433", "+39396081418"}','{"dishwasher", "washing machine","microwave" ,"oven", "dryer", "wifi", "air conditioning", "heating", "elevator"}', '{"library", "games room", "sauna", "jacuzzi"}', 'id card,18672692'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', '{"+39372033508"}','{"washing machine", "iron", "microwave", "oven", "drying rack", "wifi", "tv", "heating", "parking", "balcony"}', '{"gym", "games room", "terrace", "parking"}', 'passport,FE83726153');

--ROOM
INSERT INTO co_living.room (co_living_address, room_number, room_type) VALUES
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 1,  'premium'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 2, 'premium'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 3, 'standard'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 4, 'standard'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 5, 'standard'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 1, 'premium'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 2, 'premium'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 3, 'premium'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 4, 'standard'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 5, 'standard'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 6, 'standard'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 7, 'standard');

--APPLICANT
INSERT INTO co_living.applicant(applicant_id, applicant_name, surname, email, income_info, accepted) VALUES
('passport,GA2539654', 'George', 'Adler', 'georgeadler@gmail.com', '77300', true),
('id card,934621753', 'Filippo', 'Filippi', 'filippo_filippi@gmail.com', '53000', false),
('id card,436577811', 'Sara', 'Carter', 'saracarter99@gmail.com', '31234', true),
('driving license,JS336722', 'Julie', 'Smith', 'smithjulie@live.com', '23000', true),
('driving license,MR996633', 'Marco', 'Rossi', 'marcom@live.com', '77600', true),
('id card,550033291', 'Mattew', 'Veen', 'mattveen96@gmail.com', '52160', true),
('passport,SR4459881', 'Silvia', 'Rossi', 'silviarossi@hotmail.it', '80000', true),
('health card,9876543210', 'Sophia', 'Victoria', 'vict_soph@gmail.com', '82190', true),
('passport,HS1012023', 'Harry', 'Smith', 'harrysmith@gmail.com', '58879', true),
('id card,550030317', 'Mark', 'Wolf', 'mwolf@gmail.com', '28440', true) ;

--FORM
INSERT INTO co_living.form(applicant_id, room_number, form_number) VALUES
('passport,HS1012023', 6, 5),
('driving license,MR996633', 4, 1),
('driving license,JS336722', 3, 6),
('id card,550030317', 7, 3),
('health card,9876543210', 2, 4),
('id card,550033291', 1, 9),
('passport,GA2539654', 1, 10),
('id card,934621753', 2, 8),
('id card,436577811', 6, 7),
('passport,SR4459881', 4, 2);

--STANNDARD QUEUE
INSERT INTO co_living.standard_queue(co_living_address, room_number, applicant_id, entry_time) VALUES
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 6, 'passport,HS1012023', '2020-06-09 19:15:00 CET'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 4, 'driving license,MR996633', '2020-06-10 7:35:03 CET'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 3, 'driving license,JS336722', '2021-03-01 19:15:00 CET'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 7, 'id card,550030317', '2021-08-24 23:15:00 CET'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 2, 'health card,9876543210', '2021-11-24 15:15:00 CET'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 1, 'id card,550033291', '2022-03-12 20:20:00 CET'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 1, 'passport,GA2539654', '2022-09-21 10:00:00 CET');

--TENANT
INSERT INTO co_living.tenant(tenant_id, tenant_name, surname, username, user_password, profession, email, bank_info, 
phone_number, nationality, national_ID) VALUES
('BZZ2233440', 'Sara', 'Carter', 'SaraCarter','sar99htlL', 'taxi driver', 'saracarter99@gmail.com', 'CS45GG001111111TV3E','+45355897101', 'English', 'id card,436577811'),
('CFF3344551', 'Julie', 'Smith', 'JulieSmith', 'Julie88_E', 'teacher', 'smithjulie@live.com', 'SJ8651PL2222222EX34I', '+39887321590', 'American', 'driving license,JS336722'),
('DYY4455662', 'Marco', 'Rossi', 'MarcoRossi', 'mr!Forza8', 'nurse', 'marcom@live.com', 'RM53K0K17777777S3R','+33564778901', 'Italian', 'driving license,MR996633'),
('ERR5566773', 'Mattew', 'Veen', 'MattewVeen', 'Mv!!_3450', 'chef', 'mattveen96@gmail.com', 'VM881U229685472','+74556879214', 'Dutch','id card,550033291'),
('FTT6677884', 'Silvia', 'Rossi', 'SilviaRossi', 'sil90_edW', 'software developer','silviarossi@hotmail.it', 'RS12TUM94444444P','+99764326198', 'Italian', 'passport,SR4459881'),
('GPP7788995', 'Sophia', 'Victoria', 'SophiaVict', 'hap_34svR', 'lawyer', 'vict_soph@gmail.com', 'VS00MM339999999','+45920348649', 'Russian','health card,9876543210'),
('HWW8899006', 'Harry', 'Smith', 'HarrySmith', 'pop!Dance04', 'dj', 'harrysmith@gmail.com', 'SH6623RY8888888W2P','+88675599831', 'American', 'passport,HS1012023'),
('ILL9764351', 'Mark', 'Wolf', 'MarkWolf', 'root33!E', 'carpenter', 'mwolf@gmail.com', 'WM82Q0004444444', '+51890752341', 'English', 'id card,550030317') ;

--PRIORITY QUEUE
INSERT INTO co_living.priority_queue(co_living_address, room_number, applicant_id, entry_time) VALUES
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 6, 'id card,436577811', '2022-12-08 19:15:00 CET'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 7, 'passport,SR4459881', '2023-04-08 19:13:08 CET') ;


--CONTRACT
INSERT INTO co_living.contract (contract_number, applicant_id, co_living_address, room_number, tenant_id, offer_type, start_date, end_date, monthly_rent, manager_id) VALUES
(1, 'passport,SR4459881', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 4, 'FTT6677884', 'standard', '2020-02-01','2022-04-01','520','passport,FE83726153'),
(2, 'passport,HS1012023', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 6, 'HWW8899006', 'standard', '2020-06-30','2023-06-30','510','passport,FE83726153'),
(3, 'driving license,MR996633', 'Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 4, 'DYY4455662', 'standard','2020-09-08','2023-01-01','530','id card,18672692'),
(4, 'driving license,JS336722', 'Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 3, 'CFF3344551', 'standard','2021-03-17','2023-03-17','510','id card,28391821'),
(5, 'id card,550030317', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 7, 'ILL9764351', 'standard', '2021-10-01', '2023-02-25','530', 'passport,FE83726153'),
(6, 'id card,436577811', 'Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 2, 'BZZ2233440', 'premium', '2022-01-01', '2022-10-31', '610', 'id card,18672692'),
(7, 'health card,9876543210', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 2, 'GPP7788995','premium','2022-01-01', '2024-01-01','630','passport,FE83726153'),
(8, 'id card,550033291', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 1, 'ERR5566773', 'premium','2022-04-10','2023-04-10','620','passport,FE83726153');

--MANDATE
INSERT INTO co_living.mandate(co_living_address, tenant_id, start_date, end_date) VALUES
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 'DYY4455662', '2020-09-09', '2022-04-23'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'ILL9764351', '2022-08-25', '2022-12-09'),
('Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 'BZZ2233440', '2022-04-24', '2022-10-31') ;

--COMMON SPACES
INSERT INTO co_living.common_space (common_space_name, co_living_address) VALUES
('kitchen','Via Luigi Cadorna,9,Padova,35123,Padova,Italy'),
('kitchen','Via Gaetano Trezza,18,Verona,37129,Verona,Italy'),
('dining room','Via Luigi Cadorna,9,Padova,35123,Padova,Italy'),
('dining room','Via Gaetano Trezza,18,Verona,37129,Verona,Italy'),
('hallway','Via Luigi Cadorna,9,Padova,35123,Padova,Italy'),
('hallway','Via Gaetano Trezza,18,Verona,37129,Verona,Italy'),
('living room','Via Gaetano Trezza,18,Verona,37129,Verona,Italy');

--CLEANING SCHEDULE
INSERT INTO co_living.cleaning_schedule (common_space_name, co_living_address, week_day, start_time, duration) VALUES
('kitchen','Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 'monday', '09:00:00 CET', '90'),
('kitchen','Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'wednesday', '14:00:00 CET', '120'),
('dining room','Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 'monday', '10:30:00 CET','30'),
('dining room','Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'tuesday', '8:00:00 CET', '45'),
('hallway','Via Luigi Cadorna,9,Padova,35123,Padova,Italy', 'thursday', '16:00:00 CET', '30'),
('hallway','Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'tuesday', '8:45:00 CET', '30'),
('living room','Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'friday', '9:00:00 CET','60');

--EVENT
INSERT INTO co_living.event(event_name, event_date, starting_time, duration, max_tenants, max_guests, common_space_name, co_living_address) VALUES
('Cooking class', '2022-10-12', '10:30:00', 120, 8, 2, 'kitchen', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy'),
('NYE Party', '2022-12-31', '20:00:00', 270, 30, 10, 'dining room', 'Via Luigi Cadorna,9,Padova,35123,Padova,Italy'),
('Karaoke night', '2023-01-03', '21:15:00', 180, 15, 8, 'living room', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy') ;

--GUEST
INSERT INTO co_living.guest(guest_id, tenant_id, guest_name, guest_surname, email, phone_number) VALUES
('passport,AD89xd32', 'DYY4455662', 'Bianca', 'Rizzi', 'bianca_rizze@hotmail.it', '+99454567312'),
('id card,Bb923ss', 'HWW8899006', 'Mike', 'Miles', 'mikemiles@gmail.com', '+65457384721') ;

--PARTICIPATION
INSERT INTO co_living.participation(event_name, tenant_id, arrival_time) VALUES
('Cooking class', 'GPP7788995', '09:00:00 CET'),
('Cooking class', 'ILL9764351', '09:00:00 CET'),
('Cooking class','HWW8899006', '09:00:00 CET'),
('NYE Party', 'CFF3344551', '22:30:00 CET'),
('NYE Party', 'DYY4455662', '22:30:00 CET'),
('Karaoke night','HWW8899006', '20:30:00 CET'),
('Karaoke night', 'GPP7788995', '20:30:00 CET'),
('Karaoke night','ERR5566773', '20:30:00 CET'),
('Karaoke night', 'ILL9764351', '20:30:00 CET');

--GUEST PARTICIPATION
INSERT INTO co_living.guest_participation(event_name, guest_id, arrival_time) VALUES
('Cooking class', 'id card,Bb923ss', '09:00:00 CET'),
('NYE Party', 'passport,AD89xd32', '22:30:00 CET');

--RATE
INSERT INTO co_living.rate(co_living_address, tenant_id, grade, review) VALUES
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'GPP7788995', 9, 'wonderful experience'),
('Via Gaetano Trezza,18,Verona,37129,Verona,Italy', 'ILL9764351', 8, 'it is good') ;

--PARTNER
INSERT INTO co_living.partner(partner_address, partner_name, provided_services) VALUES 
('Via Enrico Toti,22,Padova,35135,Padova,Italy','Event lab', 'party planning'),
('Via Marco,18,Padova,35129,Padova,Italy','Galileo Ristorazione','catering'),
('Via Silvio Pellico,2,Verona,37123,Verona,Italy','Autovia','transport'),
('Via Giovanni della Casa,7,Verona,37122,Verona,Italy','AI Moschetto','groceries');

--PARTNERSHIP
INSERT INTO co_living.partnership (partner_address, partner_name, co_living_address) VALUES
('Via Giovanni della Casa,7,Verona,37122,Verona,Italy','AI Moschetto', 'Via Gaetano Trezza,18,Verona,37129,Verona,Italy'),
('Via Silvio Pellico,2,Verona,37123,Verona,Italy','Autovia','Via Luigi Cadorna,9,Padova,35123,Padova,Italy');

--SPONSOR
INSERT INTO co_living.sponsor (partner_addess, partner_name, event_name) VALUES
('Via Enrico Toti,22,Padova,35135,Padova,Italy', 'Event lab', 'NYE Party'),
('Via Marco,18,Padova,35129,Padova,Italy','Galileo Ristorazione', 'NYE Party'),
('Via Giovanni della Casa,7,Verona,37122,Verona,Italy','AI Moschetto','Karaoke night');

--COMPLAINTS
INSERT INTO co_living.complaint(ticket_number, comments, manager_id) VALUES
(1, 'the sink is broken in the kitchen, we need a plumber a.s.a.p', 'id card,18672692'),
(2, 'the heat in my room only work 30minutes a day and I dont know why...', 'id card,18672692');

--WRITE
INSERT INTO co_living.write(tenant_id, ticket_number) VALUES
('DYY4455662',1),
('CFF3344551',2);

--ORGANIZE
INSERT INTO co_living.organize(event_name, manager_id, event_time) VALUES
('Cooking class','passport,FE83726153', '09:00:00 CET'),
('NYE Party','id card,28391821', '22:30:00 CET'),
('Karaoke night','passport,FE83726153', '20:30:00 CET');

