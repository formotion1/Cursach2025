USE ARMY
GO

CREATE TABLE dbo.Recruit (
id_recruit int NOT NULL primary key IDENTITY (1,1), 
Surname nvarchar (30) NOT NULL,
Name nvarchar (30) NOT NULL,
Patronymic nvarchar (30) NULL,
Adress nvarchar(max) NOT NULL,
Number_phone nvarchar (11) NOT NULL,
Personal_data nvarchar(max) NOT NULL,
Med_result nvarchar (2) NOT NULL,

constraint Surname check(Surname not like '%[^ְ-ßא-ÿ -]%'),
constraint Name check(Name not like '%[^ְ-ßא-ÿ -]%'),  
constraint Patronymic check(Patronymic not like '%[^ְ-ßא-ÿ -]%'),  
constraint Number_phone check(Number_phone not like '%[^0-9]%' AND Len(Number_phone)=11),

constraint Personal_data check(Personal_data like '%[ְ-ßא-ÿ -,.]%'),
constraint Med_result check(Med_result like '[ְ-ßא-ÿ][0-9]'),
)

CREATE TABLE dbo.Doctor(
id_doctor int NOT NULL primary key IDENTITY (1,1), 
Surname_Doc nvarchar (30) NOT NULL,
Name_Doc nvarchar (30) NOT NULL,
Patronymic_Doc nvarchar (30) NULL,
Number_phone_Doc nvarchar (11) NOT NULL,
Doctor_post varchar (25) NOT NULL,

constraint Surname_Doc check(Surname_Doc not like '%[^ְ-ßא-ÿ -]%'),
constraint Name_Doc check(Name_Doc not like '%[^ְ-ßא-ÿ -]%'),
constraint Patronymic_Doc check(Patronymic_Doc not like '%[^ְ-ßא-ÿ -]%'),
constraint Number_phone_Doc check(Number_phone_Doc not like '%[^0-9]%' AND Len(Number_phone_Doc)=11),
constraint Doctor_post check(Doctor_post not like '%[^ְ-ßא-ÿ -.]%'),
)

CREATE TABLE dbo.Commissar(
id_commissar int NOT NULL primary key IDENTITY (1,1), 
Surname_comm nvarchar (30) NOT NULL,
Name_comm nvarchar (30) NOT NULL,
Patronymic_comm nvarchar (30) NULL,
Number_phone_comm nvarchar (11) NOT NULL,
Commissar_post varchar (25) NOT NULL,
Adress_work nvarchar(max) NOT NULL,

constraint Surname_comm check(Surname_comm not like '%[^ְ-ßא-ÿ -]%'),
constraint Name_comm check(Name_comm not like '%[^ְ-ßא-ÿ -]%'),
constraint Patronymic_comm check(Patronymic_comm not like '%[^ְ-ßא-ÿ -]%'),
constraint Number_phone_comm check(Number_phone_comm not like '%[^0-9]%' AND Len(Number_phone_comm)=11),

constraint Commissar_post check(Commissar_post not like '%[^ְ-ßא-ÿ -]%'),

)

CREATE TABLE dbo.Draft_Board(
id_draft_board int NOT NULL primary key IDENTITY (1,1),
Date_draft date NOT NULL,
Recruit_status nvarchar (8) NOT NULL, 


Recruit_info int NOT NULL,
Commissar_info int NOT NULL,
Doctor_info int NOT NULL,


constraint Recruit_status check(Recruit_status IN ('ֳמהום', 'ֽודמהום')),

constraint Info_rec foreign key (Recruit_info) references dbo.Recruit(id_recruit),
constraint Info_comm foreign key (Commissar_info) references dbo.Commissar(id_commissar),
constraint Info_doc foreign key (Doctor_info) references dbo.Doctor(id_doctor)
)