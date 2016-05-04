1

-----

Select all fields for all brands in the brands table.

The result set for this query should be every record in the brands table.

-----


select * from brands
;


==========
2

-----

Select all fields for all car models made by Pontiac in the 
models table. 

The result set should be:
  id   | year  | brand_name |    name
-------+-------+------------+------------
    25 |  1961 | Pontiac    | Tempest
    27 |  1962 | Pontiac    | Grand Prix
    36 |  1963 | Pontiac    | Grand Prix
    42 |  1964 | Pontiac    | GTO
    43 |  1964 | Pontiac    | LeMans
    44 |  1964 | Pontiac    | Bonneville
    45 |  1964 | Pontiac    | Grand Prix
(7 rows)


-----


select * from models where brand_name='Pontiac';


==========
3

-----

Select the brand name and model name for all models made in 
1964 from the models table. 

The result set should be:
 brand_name |    name
------------+-------------
 Chevrolet  | Corvette
 Ford       | Mustang
 Ford       | Galaxie
 Pontiac    | GTO
 Pontiac    | LeMans
 Pontiac    | Bonneville
 Pontiac    | Grand Prix
 Plymouth   | Fury
 Studebaker | Avanti
 Austin     | Mini Cooper
 (10 rows)
 

-----


select brand_name, name from models where year=1964;


==========
4

-----

Select the model name, brand name, and headquarters for 
the Ford Mustang from the models and brands tables.

The result set should be:
  name   | brand_name | headquarters
---------+------------+--------------
 Mustang | Ford       | Dearborn, MI
 (1 rows)


-----


select models.name, brand_name, headquarters from brands join models on brand_name=brands.name where models.name='Mustang';


==========
5

-----

Select all rows for the three oldest brands from the brands
table.

The result set should be:
  id   |    name    | founded |    headquarters     | discontinued
-------+------------+---------+---------------------+--------------
    10 | Studebaker |    1852 | South Bend, Indiana |         1967
    13 | Rambler    |    1901 | Kenosha, Washington |         1969
     6 | Cadillac   |    1902 | New York City, NY   |
(3 rows)


-----


select * from brands order by founded limit 3;


==========
6

-----

Count the Ford models in the database The output should be a 
number.

The result set should be:
   count
------------
          6
(1 rows)


-----


select count(*) from models where brand_name='Ford';


==========
7

-----

Select the name of any and all car brands that are not 
discontinued.

The result set should be:
   name
-----------
 Ford
 Chrysler
 Chevrolet
 Cadillac
 BMW
 Buick
 Tesla
(7 rows)


-----


select brands.name from brands where discontinued is NULL;


==========
8

-----

Select everything from rows 15-24 of the models table in 
alphabetical order by name. The result set should have 10 records.

The result set should be:
  id   | year  | brand_name |   name
-------+-------+------------+----------
    38 |  1963 | Chevrolet  | Corvette
    11 |  1957 | Chevrolet  | Corvette
    20 |  1960 | Chevrolet  | Corvette
     5 |  1953 | Chevrolet  | Corvette
    13 |  1958 | Chevrolet  | Corvette
    10 |  1956 | Chevrolet  | Corvette
    17 |  1959 | Chevrolet  | Corvette
    26 |  1961 | Chevrolet  | Corvette
     8 |  1955 | Chevrolet  | Corvette
    28 |  1962 | Chevrolet  | Corvette
(10 rows)


-----


select * from models order by models.name limit 10 offset 14;


==========
9

-----

Select the brand, name, and year the model's brand was 
founded for all of the models from 1960. Include row(s)
for model(s) even if their brand(s) are not in the brands table.

Note that in the result set, the year the brand was founded should be NULL if
the brand is not in the brands table.

So, the result set should be:
   name   | brand_name | founded
----------+------------+---------
 Corvette | Chevrolet  |    1911
 Corvair  | Chevrolet  |    1911
 Rockette | Fairthorpe |    1954
 Fillmore | Fillmore   |
(4 rows)


-----


select models.name, brand_name, founded from brands full outer join models on models.brand_name=brands.name where models.year=1960;


==========
10

-----

Modify the query so that it shows all brands that are 
not discontinued regardless of whether they have any models in the models table.
The correct output should not include records for Fillmore and Outback, but should
show information about Tesla, a brand with no models in the models table.

-----


select b.name, b.founded, m.name from brands as b left join models as m on b.name=m.brand_name where b.discontinued is null;


==========
11

-----

Modify the query so it only selects models whose brands ARE in the brands table.
So, we shouldn't see models who brands aren't in the brands table (a.k.a. Fillmore,
Outback) nor should we see information about brands who don't have any models in 
the models table (a.k.a. Tesla).

-----


select m.name, m.brand_name, b.founded from models as m inner join brands as b on b.name=m.brand_name;


==========
12

-----

Modify the query so that it only selects brands that do NOT have any
models in the models table.

The correct result set is:

 name  | founded
-------+---------
 Tesla |    2003
(1 rows)

-----


select b.name, founded from brands as b where not exists(select null from models as m where b.name=m.brand_name);


==========
13

-----

Modify the query to add another field to the results that gives 
the number of years from the year of the model until the brand becomes 
discontinued.

Display this new field with the name years_until_brand_discontinued. The correct
result set is:

    name    |       name       | year | discontinued | years_until_brand_discontinued
------------+------------------+------+--------------+--------------------------------
 Austin     | Mini             | 1959 |         1987 |                             28
 Austin     | Mini             | 1963 |         1987 |                             24
 Austin     | Mini Cooper      | 1961 |         1987 |                             26
 Austin     | Mini Cooper      | 1964 |         1987 |                             23
 Austin     | Mini Cooper S    | 1963 |         1987 |                             24
 Fairthorpe | Rockette         | 1960 |         1976 |                             16
 Hillman    | Minx Magnificent | 1950 |         1981 |                             31
 Plymouth   | Fury             | 1964 |         2001 |                             37
 Pontiac    | Bonneville       | 1964 |         2010 |                             46
 Pontiac    | GTO              | 1964 |         2010 |                             46
 Pontiac    | Grand Prix       | 1962 |         2010 |                             48
 Pontiac    | Grand Prix       | 1963 |         2010 |                             47
 Pontiac    | Grand Prix       | 1964 |         2010 |                             46
 Pontiac    | LeMans           | 1964 |         2010 |                             46
 Pontiac    | Tempest          | 1961 |         2010 |                             49
 Rambler    | Classic          | 1963 |         1969 |                              6
 Studebaker | Avanti           | 1961 |         1967 |                              6
 Studebaker | Avanti           | 1962 |         1967 |                              5
 Studebaker | Avanti           | 1963 |         1967 |                              4
 Studebaker | Avanti           | 1964 |         1967 |                              3
(20 rows)

-----


select b.name, m.name, m.year, b.discontinued, (b.discontinued - m.year) as years_until_brand_discontinued from models as m left join brands as b on m.brand_name=b.name where b.discontinued is not null order by b.name, m.name, m.year;