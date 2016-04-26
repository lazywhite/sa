import zmq
import time

# ZeroMQ Context
context = zmq.Context()

# Define the socket using the "Context"
sock = context.socket(zmq.PUSH)
sock.bind("tcp://127.0.0.1:5690")

id = 0

while True:
    time.sleep(1)
    id, now = id+1, time.ctime()

    # Message [id] - [message]
    message = "{id} - {time}".format(id=id, time=now)

    sock.send(message)

    print "Sent: {msg}".format(msg=message)
