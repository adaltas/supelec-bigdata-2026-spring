# Data Engineering with Spark

## Lab 3: Structured Streaming

### Prerequisites

- Docker/Docker Compose

### Goals

- Stream the `events` from wikimedia streaming.
- Run the demo that aggregates edits by robot.
- Use Spark Structured Streaming to define the streaming dataframes and process the streams.

### Lab resources

- compose.yaml
- wikistream_pyspark Notebook
- wikistream_producer.py
- admin.py
- 

### Useful links

- [Structured Streaming Programming Guide](https://spark.apache.org/docs/latest/structured-streaming-programming-guide.html)
- [Wiki Event Streams](https://wikitech.wikimedia.org/wiki/Event_Platform/EventStreams_HTTP_Service)  

### TO DO

1. Copy compose.yaml, admin.py, and wikistream_producer.py to the project directory. (This can be the same project directory created for the Kafka labs or a new directory.)
2. Start the Docker environment with Docker Compose.

```bash
docker compose up -d
```
3. Three new directories will have been created in the project, data, jobs, and notebooks. Copy the wikistream_pyspark notebook to the notebooks directory.
4. Check and follow the jupyterhub link in the docker logs.

```bash
docker logs pyspark_notebook
```
5. Run the admin.py file. **Note** If the admin.py file from the kafka lab already exists, it can be adjusted to create the new topic for the demo.

```python
topic=wikistreams
```

6. Run the producer from the command line.

```bash
python wikistream_producer.py
```

7. In jupyterhub, navigate to the work/wikistream_pyspark.ipynb and run all. This will start the pyspark consumer for the wikistreams data.
8. On the host machine, monitor the Docker logs to view the output of the consumer. **Note** The -f flag is used to follow the log output as it grows. 

```bash
docker logs -f pyspark_notebook
```

9. With the help of the code from the demo, enrich the code with other aggregations, such as changing the window time, monitoring different parts of the output like the size of edit to the wiki page, etc.

## Extra

- If time allows, find out how to use filters at the producer level to customize the wiki events being followed. For instance, the demo is following all changes to wikipedia.fr, but can be customized to other languages, or consumers could be set up to follow specific pages, etc.
