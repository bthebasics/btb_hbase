#### Hbase Command line 

***reference*** : https://www.guru99.com/hbase-shell-general-commands.html

1. **Generic commands**
   - **Status** command - gives overall system status like a number of servers present in the cluster, active server count, and average load value
   - **version** : currently used HBase version 
   - **table_help** : How to use table-referenced commands
   - **whoami** : returns the current HBase user information from the HBase cluster.
   - **TTL(Time To Live) - Attribute** : HBase, Column families can be set to time values in seconds using TTL. HBase will automatically delete rows once the expiration time is reached. This attribute applies to all versions of a row – even the current version too.

```shell
hbase(main):001:0>status

hbase(main):001:0>status  'summary', 'simple', or 'detailed'  # default is 'summary'


```

​		****

1. **Table Management commands** 

   - **Create** : Will create hbase table 

     ```shell
     hbase(main):001:0> create <tablename>, <columnfamilyname>
     
     hbase(main):001:0> create 'education' ,'guru99'
     ```


   - **List**



   - **Describe** :  

     ​	hbase(main):001:0> describe <table name>

   - **Disable**

     ​	Syntax: hbase>disable <tablename>

   - **Disable_all**

     ​	Syntax:- hbase>disable_all<"matching regex"

       

   - **Enable**

   - **Enable_all**

   - **Drop**

   - **Drop_all**

   - **Show_filters**

     displays all the filter present in the hbase - like columnPrefixFilter, Timestamp Filter

     - ValueFilter

       ```shell
       # Whose value = sku188
       $ hbase(main)> scan 'test1', {FILTER=>"ValueFilter(=,'binary:sku188')"}
       
       # Whose value contains 88
       $ hbase(main)> scan 'test1', {FILTER=>"ValueFilter(=,'substring:88')"}
       ```

     - ColumnPrefixFilter

     - PrefixFilter

       ```shell
       # Data prefixed with 6352bba7aaab443aa1d9943efc586a68 in RowKey
       $ hbase(main)> scan 'stream', {FILTER => "PrefixFilter('6352bba7aaab443aa1d9943efc586a68')"}
       ```

     - PageFilter

       ```shell
       
       $ hbase(main)> scan 'stream',{FILTER => "PageFilter(10)"}
       ```

     - FirstKeyOnlyFilter

     - RowFilter

       ```java
       //Use packages that RowFiltermust be importrelated first :
       
       import org.apache.hadoop.hbase.filter.RegexStringComparator
       import org.apache.hadoop.hbase.filter.CompareFilter
       import org.apache.hadoop.hbase.filter.SubstringComparator
       import org.apache.hadoop.hbase.filter.RowFilter
       
       // Query the record that RowKeysatisfies the regular expression ".*\\.[2]\\..*"( RegexStringComparator)
       $ hbase(main)> import org.apache.hadoop.hbase.filter.CompareFilter
       $ hbase(main)> import org.apache.hadoop.hbase.filter.SubstringComparator
       $ hbase(main)> import org.apache.hadoop.hbase.filter.RowFilter
       $ hbase(main)> scan 'stream', {FILTER => RowFilter.new(CompareFilter::CompareOp.valueOf('EQUAL'), SubstringComparator.new('.2.'))}
       
       //The record RowKeycontaining the string .2.in the query ( SubstringComparator)
       $ hbase(main)> import org.apache.hadoop.hbase.filter.CompareFilter
       $ hbase(main)> import org.apache.hadoop.hbase.filter.SubstringComparator
       $ hbase(main)> import org.apache.hadoop.hbase.filter.RowFilter
       $ hbase(main)> scan 'stream', {FILTER => RowFilter.new(CompareFilter::CompareOp.valueOf('EQUAL'), SubstringComparator.new('.2.'))}
       
       ```

   - **Alter**

      alter <tablename>, NAME=><column familyname>, VERSIONS=>5

     - Altering single, multiple column family names
     - Deleting column family names from table
     - Several other operations using scope attributes with table

     ```shell
     ## change column fam name
     alter 'education', NAME=>'guru99_1', VERSIONS=>5 
     
     ## add new families to existing table
      alter 'edu', 'guru99_1', {NAME => 'guru99_2', IN_MEMORY => true}, {NAME => 'guru99_3', VERSIONS => 5}
     
     ## to delete column family 
      alter 'education', NAME => 'f1', METHOD => 'delete'
      or hbase> alter 'education', 'delete' =>' guru99_1'
     
     
     ## You can change table-scope attributes like MAX_FILESIZE, READONLY, MEMSTORE_FLUSHSIZE, DEFERRED_LOG_FLUSH, etc. These can be put at the end;for example, to change the max size of a region to 128MB or any other memory value we use this command.
      alter <'tablename'>, MAX_FILESIZE=>'132545224'
      
     
     ```

   - **Alter_status** : trough this command, you can get the status of the alter command



## Data manipulation commands

Below are the data manipulation commands : 

- Count : 

  ```shell
  Syntax: hbase> count <'tablename'>, CACHE =>1000
  
  hbase>count 'guru99', INTERVAL => 100000
  hbase> count 'guru99', INTERVAL =>10, CACHE=> 1000
  
  hbase>g.count INTERVAL=>100000
  hbase>g.count INTERVAL=>10, CACHE=>1000
  ```

     

  - The command will retrieve the count of a number of rows in a table. The value returned by this one is the number of rows.
  - Current count is shown per every 1000 rows by default.
  - Count interval may be optionally specified.
  - Default cache size is 10 rows.
  - Count command will work fast when it is configured with right Cache.

- Put

  ```sh
  Syntax: hbase> put <'tablename'>,<'rowname'>,<'columnvalue'>,<'value'>
  
  hbase> put 'guru99', 'r1', 'c1', 'value', 10
  
  create 'guru99', {NAME=>'Edu', VERSIONS=>213423443}
  put 'guru99', 'r1', 'Edu:c1', 'value', 10
  put 'guru99', 'r1', 'Edu:c1', 'value', 15
  put 'guru99', 'r1', 'Edu:c1', 'value', 30
  scan 'guru99', {RAW=>true, VERSIONS=>1000}
  ```

  - It will put a cell 'value' at defined or specified table or row or column.
  - It will optionally coordinate time stamp.

- Get

```shell

Syntax: hbase> get <'tablename'>, <'rowname'>, {< Additional parameters>}
## Here <Additional Parameters> include TIMERANGE, TIMESTAMP, VERSIONS and FILTERS.

hbase> get 'guru99', 'r1', {COLUMN => 'c1'}
hbase> get 'guru99', 'r1'
hbase> get 'guru99', 'r1', {TIMERANGE => [ts1, ts2]}
hbase> get 'guru99', 'r1', {COLUMN => ['c1', 'c2', 'c3']}



```



- Delete

  ```shell
  Syntax: hbase> delete <'tablename'>,<'row name'>,<'column name'>
  
  hbase(main):)020:0> delete 'guru99', 'r1', 'c1''.
  
  ```

- Delete all

  ​	Syntax: hbase>deleteall <'tablename'>, <'rowname'>

  ​	Deletes all the cells in given Row; 

  - We can define optionally column names and time stamp to the syntax.

- Truncate

  ​	truncate <tablename>

  - Disables table if it already presents
  - Drops table if it already presents
  - Recreates the mentioned table

- Scan

```shell
Syntax: hbase>scan <'tablename'>, {Optional parameters}


## additional usage 
hbase> scan '.META.', {COLUMNS => 'info:regioninfo'}
#It display all the meta data information related to columns that are present in the tables in HBase


hbase> scan 'guru99', {COLUMNS => ['c1', 'c2'], LIMIT => 10, STARTROW => 'xyz'}
#It display contents of table guru99 with their column families c1 and c2 limiting the values to 10

hbase> scan 'guru99', {COLUMNS => 'c1', TIMERANGE => [1303668804, 1303668904]}
#It display contents of guru99 with its column name c1 with the values present in between the mentioned time range attribute value

hbase> scan 'guru99', {RAW => true, VERSIONS =>10}
#In this command RAW=> true provides advanced feature like to display all the cell values present in the table guru99

```

- We can pass several optional specifications to this scan command to get more information about the tables present in the system.
- Scanner specifications may include one or more of the following attributes.
- These are TIMERANGE, FILTER, TIMESTAMP, LIMIT, MAXLENGTH, COLUMNS, CACHE, STARTROW and STOPROW.

## Admin Commands

- assign
- balance_switch
- balancer
- catalogjanitor_enabled
- catalogjanitor_run
- catalogjanitor_switch
- close_region
- compact
- flush
- hlog_roll
- major_compact
- merge_region
- move
- split
- trace
- unassign
- zk_dump

## **Replication Commands**

- add_peer
- disable_peer
- enable_peer
- list_peers
- list_replicated_tables
- remove_peer
- set_peer_tableCFs
- show_peer_tableCFs

## **Snapshot Commands**

- clone_snapshot
- delete_snapshot
- list_snapshots
- rename_snapshot
- restore_snapshot
- snapshot

## Security Commands

- **grant**

  Grant users specific rights.

  ```shell
  grant <user> <permissions> [<@namespace> [<table> [<column family> [<column qualifier>]]]
  
  ## ermissions is either zero or more letters from the set “RWXCA”.
  #READ(‘R’), WRITE(‘W’), EXEC(‘X’), CREATE(‘C’), ADMIN(‘A’)
  #Note: A namespace must always precede with ‘@’ character.
  hbase> grant 'bobsmith', 'RWXCA'
  hbase> grant 'bobsmith', 'RWXCA', '@ns1'
  hbase> grant 'bobsmith', 'RW', 't1', 'f1', 'col1'
  hbase> grant 'bobsmith', 'RW', 'ns1:t1', 'f1', 'col1'
  ```

- **revoke**

  Revoke a user’s access rights.

  ```shell
  revoke <user> [<table> [<column family> [<column qualifier>]]
  
  hbase> revoke 'bobsmith'
  hbase> revoke 'bobsmith', 't1', 'f1', 'col1'
  hbase> revoke 'bobsmith', 'ns1:t1', 'f1', 'col1'
  ```

    

- **user_permission**

  Show all permissions for the particular user.

  ```shell
   
  hbase> user_permission
  hbase> user_permission 'table1'
  hbase> user_permission 'namespace1:table1'
  hbase> user_permission '.*'
  hbase> user_permission '^[A-C].*'
  ```

- **visibility labels commands**

  - add_labels
  - clear_auths
  - get_auths
  - set_auths
  - set_visibility

**<u>Other references :</u>** 

https://www.cheatography.com/wangjl1900/cheat-sheets/hbase-cheatsheet/

http://hadooptutorial.info/hbase-functions-cheat-sheet/

**** http://hadooptutorial.info/hbase-shell-commands-in-practice/  

