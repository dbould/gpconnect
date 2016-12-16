--LOCK TABLES gpconnect.patients WRITE;
--
--INSERT INTO gpconnect.patients
--  (id,    title,   first_name,   last_name,    address_1,                              address_2,            address_3,            postcode,   phone,              date_of_birth, gender,   nhs_number,  pas_number,   department_id, gp_id, lastUpdated)
--VALUE
--  (1,     'Mr',    'Ivor',       'Cox',        '6948 Et St.',                          'Halesowen',          'Worcestershire',     'VX27 5DV', '(011981) 32362',   '1944-06-06',  'Male',   9476719915,  352541,       1,             3, '2016-07-25 12:00:00'),
--  (2,     'Mr',    'Ivor',       'Cox',        'Ap #126-6226 Mi. St.',                 'Oakham',             'Rutland',            'XM9 4RF',  '(0112) 740 5408',  '1944-06-06',  'Male',   9476719923,  623454,       1,             1, '2016-07-25 12:00:00'),
--  (3,     'Mrs',   'Larissa',    'Mathews',    'P.O. Box 138, 7496 Cursus Avenue',     'Selkirk',            'Selkirkshire',       'X09 3OC',  '0800 1111',        '1937-09-28',  'Female', 9000000017,  346574,       2,             2, '2016-07-25 12:00:00'),
--  (4,     'Miss',    'Freya',      'Blackwell',  'P.O. Box 306, 6801 Tellus Street',     'Kirkby Lonsdale',    'Westmorland',        'P32 4GY',  '07624 647524',     '1980-02-03',  'Female', 9000000033,  332546,       1,             1, '2016-07-25 12:00:00'),
--  (5,     'Mr',   'Brad',     'Case',       'Ap #229-5050 Egestas Avenue',          'St. Albans',         'Hertfordshire',      'B9 8YO',   '0964 934 2028',    '1958-05-14',  'Male',   9000000041,  345267,       3,             1, '2016-07-25 12:00:00'),
--  (6,     'Mr',    'Rashad',     'Hill',       '288-6235 Odio. Street',                'Stockton-on-Tees',   'Durham',             'GF7 2OE',  '0909 764 2554',    '1952-02-19',  'Male',   9000000068,  798311,       3,             2, '2016-07-25 12:00:00'),
--  (7,     'Mrs',   'Ezra',       'Gordon',     'P.O. Box 711, 8725 Purus Rd.',         'Grangemouth',        'Stirlingshire',      'B4 8MW',   '070 6691 5178',    '1958-06-24',  'Female',   9000000076,  595941,       4,             3, '2016-07-25 12:00:00'),
--  (8,     'Mrs',   'Blair',      'Wells',      '783-2544 Cursus, Ave',                 'Lerwick',            'Shetland',           'H2 6HJ',   '(01141) 56013',    '1969-01-31',  'Female', 9000000084,  841652,       4,             1, '2016-07-25 12:00:00');
--
--UNLOCK TABLES;


LOCK TABLES gpconnect.patients WRITE;

INSERT INTO gpconnect.patients
  (id,    title,   first_name,   last_name,    address_1, address_2, address_3, address_4, address_5, postcode,   phone, date_of_birth, gender, nhs_number, pas_number, department_id, gp_id, lastUpdated,sensitive_flag,primary_care_code,date_of_death)
VALUE
   (1,'MRS','Minnie','DAWES','','24 GRAMMAR SCHOOL ROAD','','BRIGG','','DN20 8AF','','31/05/1952','',9476719931,352541,1,3,'','','A21472',''),
  (2,'MRS','Dolly','BANTON','','11 QUEENSWAY','','SCUNTHORPE','S HUMBERSIDE','DN16 2BZ','','18/09/1955','',9476719958,623454,1,2,'','','A21472',''),
  (3,'MISS','Ruby','MACKIN','','3 WILDERSPIN HEIGHTS','','BARTON-UPON-HUMBER','S HUMBERSIDE','DN18 5SN','','01/01/1953','',9476719966,346574,2,1,'','','A21472',''),
 (4,'MR','Julian','PHELAN','FARM HOUSE','BONNYHALE ROAD','EALAND','SCUNTHORPE','S HUMBERSIDE','DN17 4JQ','','02/07/1992','',9476719974,332546,1,3,'','','A21472','10/07/2007'),
 (5,'MS','Tania','HARDY','','10 FERRIBY ROAD','','SCUNTHORPE','S HUMBERSIDE','DN17 2EQ','','02/11/1953','',9476113162,332546,2,2,'','S','A21471',''),
 (6,'MR','Dwayne','BULLEN','','4 MILL LANE','WESTWOODSIDE','DONCASTER','S YORKSHIRE','DN9 2AF','','11/05/1958','',9476113170,345267,3,3,'','','A21471',''),
 (7,'MR','Roland','MINTON','','4 HERON WAY','','BARTON-UPON-HUMBER','','DN18 5FF','','13/05/1959','',9476113189,798311,4,1,'','','A21471',''),
 (8,'MS','Arlene','BRYAN','','34 SPILSBY ROAD','','SCUNTHORPE','S HUMBERSIDE','DN17 2JF','','22/10/1964','',9476113197,595941,2,2,'','','A21471',''),
 (9,'MS','Nelly','CRABB','COACH HOUSE','MILLERS BROOK','BELTON','DONCASTER','S YORKSHIRE','DN9 1WA','','09/03/1965','',9476113200,841652,1,3,'','','A21471',''),
 (10,'MRS','Stacey','COFFEY','IVY HOUSE','','WHITTON','SCUNTHORPE','','DN15 9LJ','','30/12/1980','',9476113219,352541,3,1,'','','A21471','07/04/2003'),
 (11,'MRS','Kari','HOOD','','11 DIANA STREET','','SCUNTHORPE','','DN15 6AU','','14/05/1955','',9476728329,352541,4,2,'','','A21475',''),
 (12,'MS','Yvette','FOSTER','','100 BERKELEY STREET','','SCUNTHORPE','S HUMBERSIDE','DN15 7LJ','','15/11/1954','',9476728337,352541,3,3,'','','A21475',''),
 (13,'MRS','Yvonne','STUBBS','','65 DEWSBURY AVENUE','','SCUNTHORPE','S HUMBERSIDE','DN15 8AJ','','24/09/1955','',9476728345,352541,2,2,'','','A21475',''),
 (14,'MS','Lisa','READEN','','1 ASH GROVE','','BRIGG','S HUMBERSIDE','DN20 8AQ','','22/01/1955','',9476728353,352541,1,1,'','','A21475',''),
 (15,'MRS','Norma','DRIVER','2A','GEORGE STREET','KIRTON LINDSEY','GAINSBOROUGH','','DN21 4NA','','05/10/1951','',9476728361,352541,2,2,'','','A21475',''),
 (16,'MR','Duncan','MOFFAT','','2 SPENCER AVENUE','','SCUNTHORPE','S HUMBERSIDE','DN15 7RY','','19/04/1981','',9476728388,352541,3,1,'','','A21475','25/11/1981'),
 (17,'MS','Serena','LOWDAY','','12 WEST VIEW','MESSINGHAM','SCUNTHORPE','S HUMBERSIDE','DN17 3PF','','12/07/1953','',9476730129,352541,4,3,'','','A21474',''),
 (18,'MISS','Faye','SPEEDY','','22 CHURCH STREET','EPWORTH','DONCASTER','','DN9 1ER','','03/10/1952','',9476730137,352541,3,2,'','','A21474',''),
 (19,'MRS','Jean','COWPER','TORBAY COURT','TORRINGTON ROAD','','SCUNTHORPE','','DN17 1UT','','09/10/1954','',9476730145,352541,2,1,'','','A21474',''),
 (20,'MRS','Myrtle','HELSBY','MARISTOWE','BELTON ROAD','BELTOFT','DONCASTER','S YORKSHIRE','DN9 1NN','','14/02/1956','',9476730153,352541,1,3,'','','A21474',''),
 (21,'MISS','Elisa','HOOS','','10 WILLIAM STREET','','SCUNTHORPE','S HUMBERSIDE','DN16 1SZ','','06/12/1955','',9476730161,352541,3,2,'','','A21474',''),
 (22,'MR','Matt','FARMER','','10 WARLEY AVENUE','','SCUNTHORPE','S HUMBERSIDE','DN16 1QE','','12/06/1977','',9476730188,352541,2,1,'','','A21474','26/10/1991');
	
UNLOCK TABLES;
	