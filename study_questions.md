# Study Questions

01. What is big data? Describe some of the parameters.
02. Name and describe the two main hardware strategies for working with big data.
03. What is a problem introduced by implementing the hardware strategy used by Hadoop and other typical big data systems?
04. What is a cluster? 
05. In what two ways can we describe a node?
06. What is the software architecture pattern used by tools like Hadoop?
07. At a high level, name the three main components of Hadoop, and briefly describe the role each one plays.
08. What type of storage system is used in Hadoop? Describe how the system works including the default size of the units of data that make up this system.
09. What problem does the default data unit size try to solve in the hadoop echo system. Why is this a problem?
10. What components make up the standard storage system in Hadoop?
11. What problem is encountered with the default setup of the hadoop storage system and what is a solution?
12. Which component changes when implementing the solution above and how does it change?
13. What problem is introduced by implementing the above solution?
14. What is the way we solve this problem in Hadoop and with other components in the Hadoop ecosystem?
15. What is WORM?
16. Explain the Map Reduce programming paradigm, including a definition of map, reduce, and shuffle.
17. In Map Reduce, as implemented by Hadoop, how are calculations persisted?
18. Why is it best to match the number of mappers to the number of blocks?
19. Why is it better to "push" the code/calculations to the data than to "pull" the data to the calculations?
20. In one sentence, describe Apache Spark.
21. Why is a tool like Spark prefered over something like the Hadoop implementation of Map Reduce?
22. Name and describe the components of Spark and their functions.
23. Name and describe the fundamental data structure in spark.
24. What are the two catagories of operations in Spark. How do they differ?
25. What is lazy evaluation?
26. Similar to Map Reduce, there is a way that calculations are split in Spark. Describe this split and the ideal data size for this split.
