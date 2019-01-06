# Hbase Workshop

reference  : https://www.youtube.com/watch?v=YNWS1G6h13Y&index=5&list=PLf0swTFhTI8rM5AdWXObgQ-aN5gYyOfKC

- **Create hbase Table through hbase-shell**

```shell
'nyse:stocks_demo' 'cf1'

## row key of the table is "year + stock sticker" - to model thick schema vs thin schema
# Bulk update of data into HBASE
```



- **Create Intellij Project with SBT ( v < 1 ) and Scala ( 2.11 )**

  **build.sbt** is defined as below 

  ```shell
  name := "hbase-kickStarter"
  
  version := "0.1"
  
  scalaVersion := "2.11.12"
  
  libraryDependencies += "com.typesafe" % "config" % "1.3.2"
  libraryDependencies += "org.apache.hadoop" % "hadoop-common" % "2.7.0"
  libraryDependencies += "org.apache.hadoop" % "hadoop-client" % "2.7.0"
  libraryDependencies += "org.apache.hbase" % "hbase-client" % "1.1.8"
  libraryDependencies += "org.apache.hbase" % "hbase-server" % "1.1.8"
  libraryDependencies += "org.apache.hbase" % "hbase-protocol" % "1.1.8"
  libraryDependencies += "org.apache.hbase" % "hbase-common" % "1.1.8"
  libraryDependencies += "org.apache.spark" % "spark-sql_2.11" % "2.3.0"
  
  ## we need to define the mergeStrategy to avoid conflict
  
  ## also Add Framework support for Scala if not showing "scala class options
  
  ## STEPS to Resolve issues with "MergeStrategy"
  ## create assemly.sbt
  
  addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "0.14.8")
  
  ## add below in assemblyMergeStrategy
  assemblyMergeStrategy in assembly := {
    case m if m.toLowerCase.endsWith("manifest.mf") => MergeStrategy.discard
    case m if m.startsWith("META-INF") => MergeStrategy.discard
    case PathList("javax", "servlet", xs@_*) => MergeStrategy.first
    case PathList("org", "apache", xs@_*) => MergeStrategy.first
    case "about.html" => MergeStrategy.rename
    case "reference.conf" => MergeStrategy.concat
    case _ => MergeStrategy.first
  }
  
  // to define entry point for JAR files
  // specify below : 
  mainClass in assembly := Some("NYSELoad")
  
  ```

- **application.properties** to be added to project

  ```shell
  dev.zookeeper.quorum =  
  dev.zookeeper.port = 
  prod.zookeeper.quorum = 
  prod.zookeeper.port = 
  
  ## find the details from ambari or admins
  ```

- **getting started** : Test all the dependencies loading 

```scala
import org.apache.hadoop.hbase.{HBaseConfiguration, TableName}
import org.apache.hadoop.hbase.client.{Connection, ConnectionFactory, Put, Table}
import org.apache.hadoop.hbase.util.Bytes
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.hadoop.conf.Configuration
import org.apache.spark.sql.{Row, SparkSession}

object gettingStarted extends App{

  val hbaseConfig: Configuration = HBaseConfiguration.create()
  print("hello world")
}
```



```scala
// HbaseCRUD.scala

import com.typesafe.config.ConfigFactory
import org.apache.hadoop.hbase.{HBaseConfiguration, TableName}
import org.apache.hadoop.hbase.client._
import org.apache.hadoop.hbase.util.Bytes
import com.typesafe.config.{Config, ConfigFactory}
import org.apache.hadoop.conf.Configuration
import org.apache.spark.sql.{Row, SparkSession}

object HbaseCrud extends App{
_
  val hbaseConfig: Configuration = HBaseConfiguration.create()
  print("hello world")


  hbaseConfig.set("hbase.zookeeper.quorum","2181")
  hbaseConfig.set("hbase.zookeeper.property.clientPort","2181")

  // Establish the connection
  val connection = ConnectionFactory.createConnection(hbaseConfig)

  // Crud operation on a table in database
  val table = connection.getTable(TableName.valueOf("training:hbaseDemo"))

  // (x$1: java.util.List[org.apache.hadoop.hbase.client.Put])Unit
  // hbase stores everything as ByteArray and hence we need to use Bytes.toBytes everytime dealing with hbase
  //scala> Bytes.toBytes("hello")
  //res3: Array[Byte] = Array(104, 101, 108, 108, 111)

  val row = new Put(Bytes.toBytes("2")) // new row key
  val cf = Bytes.toBytes("cf1")
  val c = Bytes.toBytes("c3")
  val v =  Bytes.toBytes("v3")

  row.addColumn(cf,c,v)

  val c1 = Bytes.toBytes("c3")
  val v1 =  Bytes.toBytes("v3")

  row.addColumn(cf,c1,v1)

  table.put(row)

  // get the records from the table
  // Build the query
  // process the results
  // close table
  // close the connection

  val rowKey = Bytes.toBytes("2")
  val query = new Get(rowKey)

  val result = table.get(query)  // argument org.apache.hadoop.hbase.client.Get

  print(result)

  val columnToRetrive = Bytes.toBytes("c4")

  Bytes.toString(result.getValue(cf, columnToRetrive) ) // col fam , col name


// Scan example

  val scan = new Scan()

  val Table = connection.getTable(TableName.valueOf("training:hbaseDemo"))

  val scanner = table.getScanner(scan)
  var result = scanner.next()

  while (result != null ) {
    val rowKey = result.getRow
    println(Bytes.toString(rowKey))


    result = scanner.next()
  }

  table.close()
  connection.close()

  // C/U build the record -> Insert record into Table --> close the connection


  // D - Build the query  -> process results -> close the connection

  // URL -> localhost port -> 2181


}

```



### example 2 : Processing NYSE data  

- Read files

- process files

- load in HBASE 

- file has fields : 

  - Stock symbol, date, high prices for day, lowe prices, close price, volume
  - **RowKEY** = "STOCK_SYMBOL + DAY"

  //truncate table ( disable the table)

  run the program NYSELoad.scala



  run : **sbt** **assembly** ## to build FAT JAR

  scp jar to cluster - 

  and run : **java -jar HBase Demo-assembly-1.0.jar**



  ```scala
  import com.typesafe.config.{Config, ConfigFactory}
  import org.apache.hadoop.hbase.client._
  import org.apache.hadoop.hbase.util.Bytes
  import org.apache.hadoop.hbase.{HBaseConfiguration, TableName}
  
  import scala.io.Source
  
  object NYSELoad {
  
  
    def getConneection(conf: Config, env: String)  = {
      val hbaseConfig = HBaseConfiguration.create()
      hbaseConfig.set("hbase.zookeeper.quorum",conf.getString("zookeeper.quorum"))
      hbaseConfig.set("hbase.zookeeper.property.clientPort",conf.getString("zookeeper.port"))
  
      if ( env != "dev") {
  
        hbaseConfig.set("zookeeper.znode.parent",conf.getString("zookeeper.znode.parent")) // hbase-unsecure
        hbaseConfig.set("hbase.cluster.distributed",conf.getString("zookeeper.quorum"))  // true
      }
  
      ConnectionFactory.createConnection(hbaseConfig)
    }
  
    def buildPut(record: String) = {
      //CACI,20180102, 11.455,11.875,11.23,11.875,36664
      // date and stockTicker for key
      val attr = record.split(",")
  
      val key = Bytes.toBytes(attr(1) + ":" +  attr(0))
      val row = new Put(key)
      val cf = Bytes.toBytes("sd") // whatever name of CF
      row.addColumn(cf,Bytes.toBytes("op"),Bytes.toBytes(attr(2)))
      row.addColumn(cf,Bytes.toBytes("hp"),Bytes.toBytes(attr(3)))
      row.addColumn(cf,Bytes.toBytes("lp"),Bytes.toBytes(attr(4)))
      row.addColumn(cf,Bytes.toBytes("cp"),Bytes.toBytes(attr(5)))
      row.addColumn(cf,Bytes.toBytes("vol"),Bytes.toBytes(attr(6)))
  
      row  // return row
    }
  
    def main(args: Array[String]): Unit = {
  
      val env = args(0)
      val conf = ConfigFactory.load.getConfig(env)
  
      val connection = getConneection(conf, env)
      val table = connection.getTable(TableName.valueOf(("nyse:stockData")
  
      val inputPath = args(1)
      val nyseData = Source.fromFile(inputPath).getLines
  
      nyseData.foreach(record => {
        table.put(buildPut(record))
      })
  
    }
  
  }
  ```


**References***: https://github.com/larsgeorge/hbase-book/tree/master/ch03/src/main

scala - https://gist.github.com/HGladiator/8e58f5da02ac7d8a158b3a9e6739c824

**util Class for HBASE:** https://github.com/larsgeorge/hbase-book/blob/master/common/src/main/java/util/HBaseHelper.java



https://github.com/larsgeorge/hbase-book/blob/master/ch05/src/main/java/admin/ListTablesExample.java

https://github.com/larsgeorge/hbase-book/blob/master/common/src/main/java/util/HBaseHelper.java

https://github.com/bomeng/Heracles/tree/master/src/main/scala/org/apache/spark/sql/hbase

