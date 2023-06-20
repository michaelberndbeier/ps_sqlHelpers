# ps_sqlHelpers
A collection of _must have_ powershell scripts I wrote to save some time prototyping and executing sql for multiple databases


## Architecture

### sql-readonly.ps1

Simple Script to execute a given query on a given db using your windows account / _integrated security_-parameter.
As the name suggests: it also has the _readonly_-flag.

### sql-*

The sql-*.ps1 files (except sql-readonly.ps1) are preconfigured sql-readonly variants to enable cool scripts like:

~~~
PS C:\AwesomeProject> sql-prod "select count(*) from orders"

Column1
-------
     69110
~~~

sql-dev.ps1
: your DEV-DB

sql-int.ps1
: the DB of a shared integration test application instance

sql-prod.ps1
: your production database

sql-sup.ps1
: your support instance / nightly clone of the production instance

sql-tst.ps1
: the DB of a shared test / nightly application instance

# Getting started

## Change your connection strings

The files sql-dev.ps1, sql-int.ps1, sql-prod.ps1, sql-sup.ps1, sql-tst.ps1 need to be configured by you to match your system.
Every listed file contains the following lines:

~~~
$dataSource = "someServer\someInstance"
$database = "someDB"
~~~

As you probably are guessing: yes, replace someServer\someInstance with the odbc-server-name and replace someDB with yourDBName.

~~~
$dataSource = "corpDEVSlowMachine\INSTANCE01"
$database = "criticallyImportantDB"
~~~

Yes, you also can omit the instance in some cases:

~~~
$dataSource = "someServer\someInstance"
$database = "someDB"
~~~

As you probably are guessing: yes, replace someServer\someInstance with the odbc-server-name and replace someDB with yourDBName.

~~~
$dataSource = "corpDEVNightlyThings"
$database = "criticallyImportantNightlyBuildDB"
~~~

## How to use it

### 1. Give your Query as an argument

~~~
sql-prod "select count(*) from orders"
~~~

Example:

~~~
PS C:\AwesomeProject> sql-prod "select count(*) from orders"
Column1
-------
     69110
~~~

- cool for simple scripting / research during meetings etc.
- this is how I start 80% of my usage of this script package

### 2. Give your Query as a piped argument

~~~
cat code/orderCount.sql -raw | sql-prod ~
~~~

Example:

~~~
PS C:\AwesomeProject> cat code/orderCount.sql -raw | sql-prod 
Column1
-------
     69110
~~~

### 3. Get Results as *.csv

~~~
exp-prod .\code\orderCount.sql
~~~

Prerequisites
- you configured your connection strings
- you have a project folder with a "data" subfolder
- you have your sql-query ready and saved it as an *.sql


Now you can use the matching exp-*.ps1 for your sql-*.ps1.
Here's an example for executing our order count query stored in .\code\orderCount.sql on your production database.

~~~
PS C:\AwesomeProject> exp-prod .\code\orderCount.sql
PS C:\AwesomeProject> tail .\data\orderCount_prod_20230620_0827.csv
"Column1"
"64"
~~~

What happened:
- sql-prod was called with cat .\code\orderCount.sql
- the result was converted using export-csv
- the result was saved with a suffix matching your exp-* and a timestamp


### 4. Get Results as *.csv for multiple DBs and multiple Queries

~~~
exp-all.ps1 -queryFilesFolder .\code\ -sup -prod -tst
~~~

Prerequisites
- you configured your connection strings
- you have a project folder with a "data" subfolder
- you have your sql-queries ready and saved them as an *.sql in one folder


~~~
PS C:\AwesomeProject> exp-all.ps1 -queryFilesFolder .\code\ -sup -prod -tst
PS C:\AwesomeProject> ls .\data\


    Directory: C:\AwesomeProject\data


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----       20.06.2023     08:36             17 customers_prod_20230620_0836.csv
-a----       20.06.2023     08:36             17 customers_sup_20230620_0836.csv
-a----       20.06.2023     08:36             17 customers_tst_20230620_0836.csv
-a----       20.06.2023     08:36             17 orderCount_prod_20230620_0836.csv
-a----       20.06.2023     08:36             17 orderCount_sup_20230620_0836.csv
-a----       20.06.2023     08:36             17 orderCount_tst_20230620_0836.csv

~~~

What happened:
- exp-* was called for every switch (-prod, -sup, etc.) and every file in your -queryFilesFolder (.\code) 


