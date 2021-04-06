---
id: 75
title: Direct Discovery introduction
date: 2014-10-24T05:34:07+01:00
guid: http://aqlik.se/?p=75
permalink: /2014/10/aqlik-direct-discovery/
classes: wide
---
Direct discovery is a way of combining the associative part of QlikView and database data set that will not fit into the QlikView RAM memory. Instead of reading all data into memory <em>Direct Discovery</em> allow me to aggregated data on demand straight from the database or a small selection of transaction in a large data set.

Please note that the Direct Discovery syntax where changed in 11.2 SR5. What I write here might not work in earlier versions. I do recomend you to do an upgrade if you plan to implement Direct Discovery.
<h2 id="direct-discovery-syntax">Direct Discovery Syntax</h2>
The script syntax <code>DIRECT QUERY</code> is the key for enabling Direct Discovery into my QlikView application. In the query I select which fields I want to load as regular in memory and which fields that should have special Direct Discovery properties.

```qlikview
DIRECT QUERY
DIMENSION
TRANSACTION_TYPE,
COUNTRY
NATIVE('TO_CHAR(TRANSACTION_DATE, ''YYYY-MM'')') as [Year-month]
MEASURE
AMOUNT as Amount
DETAIL
TRANSACTION_ID as [Transaction ID]
DETACH
CUSTOMER_ID as [Customer ID]
FROM
dbo.TRANSACTIONS
```

It is possible to use <em>native</em> database functions in the Direct Query statement. The syntax is <code>NATIVE('YourDBSyntax')</code> with the difference that all native apostrophes (<code>'</code>) should be doubled (<code>''</code>).
<h3 id="dimension">Dimension</h3>

![Silos]({{ site.url }}{{ site.baseurl }}/assets/images/2014/10/silos.jpg){: .align-center}
Fields in data discovery that is loaded as a dimension will be loaded into the associative data model simular to regular QlikView dimensions. These are the typical the fields that you are to do selections on to limit you direct query selection.

During the script execution Dimensions will be loaded as distinct from database into the data model.

```sql
SELECT DISTINCT TRANSACTION_TYPE FROM dbo.TRANSACTIONS
SELECT DISTINCT COUNTRY FROM dbo.TRANSACTIONS
SELECT DISTINCT TO_CHAR(TRANSACTION_DATE, 'YYYY-MM') FROM dbo.TRANSACTIONS
```

If you make a selection in a <em>DIMENSION</em> field in the application the selection will be reflected in the WHERE statement when the direct discovery query is sent to the database.

<h3 id="measure">Measure</h3>
Fields loaded as MEASURE in the Direct Query are not loaded as regular QlikView fields. Only the metadata of the field is loaded. There are no distinct values present in the associative data model. The Measure field is to be used in calculated expressions. The user will experience calculations on Measure fields as calculations on any regular field in the data model, but calculations on measure fields are done in the database and regular fields by QlikView. The aggregations supported for measure fields are Sum(), Count(), Avg(), Max() and Min().

<h3 id="detail">Detail</h3>
The DETAIL fields in a Direct Query is similar to measures in the sense that their values are not loaded into the associative data model. Opposite of measure Details are not available in any aggregated form. The purpose is to let the user make selections in normal dimension and when then present the row details based on the other selections. It is not possible to make selections on a detail field and it only possible to present details in a listbox.

To avoid an overpopulated list box QlikView limits the number of details presented in a listbox with the variable DirectTableBoxListThreshold. The default value is 1000, you can adjust it to fit your needs and environment in the script.
[qlikview type="exp"]SET Direct TableBoxListThreshold = 500;[/qlikview]

### Detach
Data values from a Detached field is loaded into memory, but it is not attached to the data model. Each detached field is its own data island. Any selection in a detached field will not make changes in the associative data model, but it will affect the direct query sent to the database. A selection in a detached field will be included in the direct query WHERE statement.

Note: the WHERE statement sent to the database is conducted as follows.

`WHERE field in (value1, value2, …, valueN)`

The Oracle database have a limitation to the allowed numbers of values in a IN() command. It is a good idea to limit the number of values in the fields you choose to both Dimensions and Detach.

## Speed
![Trafic sign by Fred Fokkelman]({{ site.url }}{{ site.baseurl }}/assets/images/2014/10/traffic-sign.png){: .align-left} Direct discovery will never become speedier than your database. Each single selection in your application will either do a select on your database or reuse a cached result. The selections and returning result are per default stored into cache. Default cache history is 3600 seconds. If you have use the same selections twice the cache result will be presented.

You can adjust the cache time with the following variable:

`SET DirectCacheSeconds= 1800;`

<h2 id="security">Security</h2>
There are two big limitations regarding data security when working with direct discovery. I don’t see them as a dealbreaker, but you should be aware them to handle them.

First - the connection used to read from database is shared by all users. It is not possible to limit access on database level based on user credentials.

Second - section access is only applicable server side using the AccessPoint. It is not possible to apply section access when using the desktiop client.
<h2 id="when-to-use-direct-discovery">When to use Direct Discovery</h2>
Direct discovery is not something you put in use for every QlikView project. It is great to use when you want to look at a small part of a huge dataset, but don’t know in advance which part it be. It will also work for aggregating huge amounts of data.

Don’t expect direct discovery to be faster than your normal approach. You will never get results faster than your query runs on the database. You should neither think of it as a real time solution as the cache is crucial to get good performance.

## Further readings
- <a href="http://community.qlik.com/community/discussion-forums/direct-discovery">Direct discovery on Qlik Community</a>
- <a href="http://youtu.be/BYNe949ESUs">QlikView - Data To Discovery In Less Than 10 Minutes</a>
- <a href="http://youtube.com/watch?v=2BbsREMW-5A">Big data analyzed and visualized by Qlik and ParStream in the Amazon cloud</a>