# Hbase Bulk Loader

There is utility for bulk loading of data into HBASE file ( CSV , PSV etc)

import files to local Linux:

```shell
curl -o ~/sales.csv https://raw.githubusercontent.com/bsullins/data/master/salesOrders.csv
```

File need to be exported into HDFS first

**command :** 

```shell
hbase  org.apache.hadoop.hbase.mapreduce.ImportTsv \
-Dimporttsv.seperator=, \
-DImporttsv.columns="\
  HBASE_ROW_KEY,\
  order:orderID, \
  order:orderDate, \
  order:shipDate, \
  order:shipMode, \
  order:profit, \
  order:quantity, \
  order:sales"  \
  sales hdfs://sandbox.hortonworks.com:/tmp/sales.csv
```







