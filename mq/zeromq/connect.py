import zmq

# ZeroMQ Context
context = zmq.Context()

# Define the socket using the "Context"
socket = context.socket(zmq.PAIR)
socket.connect("tcp://127.0.0.1:5696")
