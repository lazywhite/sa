# store image into Redis
>import redis
r =  redis.StrictRedis()
img = open("/path/to/img.jpeg","rb").read()
r.set("bild1",img)
