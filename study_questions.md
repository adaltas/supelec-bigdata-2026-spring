# Study Questions

01. What is big data? Describe some of the parameters.
02. Name and describe the two main hardware strategies for working with big data.
03. What is a problem introduced by implementing the hardware strategy used by Hadoop and other typical big data systems?
04. What is a cluster? 
05. In what two ways can we describe a node?
06. What is the software architecture pattern used by tools like Hadoop?
07. At a high level, name the three main components of Hadoop, and briefly describe the role each one plays.
08. What type of storage system is used in Hadoop? Describe how the system works including the default size of the units of data that make up this system.
09. What problem does the default data unit size try to solve in the Hadoop echo system. Why is this a problem?
10. What components make up the standard storage system in Hadoop?
11. What problem is encountered with the default setup of the Hadoop storage system and what is a solution?
12. Which component changes when implementing the solution above and how does it change?
13. What problem is introduced by implementing the above solution?
14. What is the way we solve this problem in Hadoop and with other components in the Hadoop ecosystem?
15. What is WORM?
16. Explain the Map Reduce programming paradigm, including a definition of map, reduce, and shuffle.
17. In Map Reduce, as implemented by Hadoop, how are calculations persisted?
18. Why is it best to match the number of mappers to the number of blocks?
19. Why is it better to "push" the code/calculations to the data than to "pull" the data to the calculations?
20. In one sentence, describe Apache Spark.
21. Why is a tool like Spark preferred over something like the Hadoop implementation of Map Reduce?
22. Name and describe the components of Spark and their functions.
23. Name and describe the fundamental data structure in spark.
24. What are the two categories of operations in Spark. How do they differ?
25. What is lazy evaluation?
26. Similar to Map Reduce, there is a way that calculations are split in Spark. Describe this split and the ideal data size for this split.
27. Describe the difference between working at the RDD level and the Dataframe level.
28. How do Dataframes relate to RDDs?
29. What is the name of the mechanism that makes Dataframes the preferred method for most for interacting with data in Spark?
30. Why should the schema always be defined for data in production Spark?
31. Briefly describe the medallion architecture for data.
32. What is the CAP theorem? Describe each part and name the part that must always be considered when working in a distributed system.
33. Describe OLTP vs OLAP.
34. Describe the two main categories of file formats and which each is good for.
35. Three file formats where discussed during the class, where does each fit in to the main file format category?
36. What does DAG stand for and how does it work?
37. Which component in Hive is responsible for managing the metadata of the tables?
38. Which component in Hive is responsible for the data and calculations?
39. What is the difference between managed and external tables in Hive?
40. What does it mean to partition a table in a tool like Hive?
41. What is the messaging paradigm in tools like kafka? Hint: answer can be in the form of (one-word)
42. Name and describe the three main components found in Kafka.
43. What is the difference between a source and sink in a streaming processing system?
44. What is the difference between stream and batch processing?
45. Name and describe the three types of processing semantics.
46. What is the difference between event time and processing time?
47. What role does the trigger play in Spark Structured streaming?
48. Name and understand the difference between the two types of windows discussed during the lectures.
49. What role does the watermark play in Spark Structured Streaming? Hint: It may be helpful to define the watermark by the problem it is trying to solve.
