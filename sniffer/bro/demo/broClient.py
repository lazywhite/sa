from broccoli import *
import pdb


#pdb.set_trace()
bc = Connection("127.0.0.1:48881")
bc.subscribe("HTTP::http_request")
bc.processInput()


@event
def http_request(arg1):
    print arg1
