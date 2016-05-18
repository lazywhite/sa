## Introduction
Apache Flume is a tool/service/data ingestion mechanism for collecting aggregating and transporting large amounts of streaming data such as log files, events (etc...) from various sources to a centralized data store.

Flume is a highly reliable, distributed, and configurable tool. It is principally designed to copy streaming data (log data) from various web servers to HDFS.

## Advanatage
Using Apache Flume we can store the data in to any of the centralized stores (HBase, HDFS).

When the rate of incoming data exceeds the rate at which data can be written to the destination, Flume acts as a mediator between data producers and the centralized stores and provides a steady flow of data between them.

Flume provides the feature of contextual routing.

The transactions in Flume are channel-based where two transactions (one sender and one receiver) are maintained for each message. It guarantees reliable message delivery.

Flume is reliable, fault tolerant, scalable, manageable, and customizable.

## Features
Flume ingests log data from multiple web servers into a centralized store (HDFS, HBase) efficiently.

Using Flume, we can get the data from multiple servers immediately into Hadoop.

Along with the log files, Flume is also used to import huge volumes of event data produced by social networking sites like Facebook and Twitter, and e-commerce websites like Amazon and Flipkart.

Flume supports a large set of sources and destinations types.

Flume supports multi-hop flows, fan-in fan-out flows, contextual routing, etc.

Flume can be scaled horizontally.


## Architecture
agent(source -> (multiplexing) --> channel --> sink) --> plugin --> (hdfs, es, mongodb)

## Multi-hop flow
Within Flume, there can be multiple agents and before reaching the final destination, an event may travel through more than one agent. This is known as multi-hop flow

## Fan-out Flow
The dataflow from one source to multiple channels is known as fan-out flow. It is of two types −

Replicating − The data flow where the data will be replicated in all the configured channels.

Multiplexing − The data flow where the data will be sent to a selected channel which is mentioned in the header of the event.


## Fan-in Flow
The data flow in which the data will be transferred from many sources to one channel is known as fan-in flow.


## Failure Handling
In Flume, for each event, two transactions take place: one at the sender and one at the receiver. The sender sends events to the receiver. Soon after receiving the data, the receiver commits its own transaction and sends a “received” signal to the sender. After receiving the signal, the sender commits its transaction. (Sender will not commit its transaction till it receives a signal from the receiver.)
