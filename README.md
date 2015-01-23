EXPENSE ORGANIZER
-----
Created by Sarah Joy Calpo & Ron Park.

MIT and GPL copyrights, get it right.

Don't do drugs, unless they're pure.
-----

Database Tables

              List of relations
 Schema |        Name         | Type  | Owner
--------+---------------------+-------+-------
 public | categories          | table | Guest
 public | companies           | table | Guest
 public | companies_expenses  | table | Guest
 public | expenses            | table | Guest
 public | expenses_categories | table | Guest


                              Table "public.categories"
 Column |       Type        |                        Modifiers
--------+-------------------+---------------------------------------------------------
 id     | integer           | not null default nextval('categories_id_seq'::regclass)
 name   | character varying |
 budget | numeric(9,2)      |
Indexes:
    "categories_pkey" PRIMARY KEY, btree (id)

                                 Table "public.companies"
 Column |       Type        |                      Modifiers
--------+-------------------+------------------------------------------------------
 id     | integer           | not null default nextval('company_id_seq'::regclass)
 name   | character varying |
Indexes:
    "company_pkey" PRIMARY KEY, btree (id)

                               Table "public.companies_expenses"
   Column   |  Type   |                            Modifiers
------------+---------+-----------------------------------------------------------------
 id         | integer | not null default nextval('companies_expenses_id_seq'::regclass)
 company_id | integer |
 expense_id | integer |
Indexes:
    "companies_expenses_pkey" PRIMARY KEY, btree (id)

                                     Table "public.expenses"
   Column    |       Type        |                       Modifiers
-------------+-------------------+-------------------------------------------------------
 id          | integer           | not null default nextval('expenses_id_seq'::regclass)
 date        | date              |
 amount      | numeric(9,2)      |
 description | character varying |
Indexes:
    "expenses_pkey" PRIMARY KEY, btree (id)

                            Table "public.expenses_categories"
   Column    |  Type   |                            Modifiers
-------------+---------+------------------------------------------------------------------
 id          | integer | not null default nextval('expenses_categories_id_seq'::regclass)
 expense_id  | integer |
 category_id | integer |
Indexes:
    "expenses_categories_pkey" PRIMARY KEY, btree (id)
