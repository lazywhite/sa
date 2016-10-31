ADD
    ADD <src>... <dest>
    ADD "<src>",... "<dest>": double quote is used for paths containing whitespace
    copy new files, directories or remote file urls from <src> and adds them to the filesystem of the container 
COPY    
    COPY <src>... <dest>
    COPY "<src>",... "<dest>"
ENV
    <key>[=]<value>
    set the environment variable <key> to <value>, can be replaced inline
ENTRYPOINT: allow you to configure a container that will run as an executable
    ENTRYPOINT ["executable", "param1", "param2"]
    ENTRYPOINT command param1 param2
    
EXPOSE
LABEL
USER
    set the user name or UID to use when running the image and for any RUN, CMD, and ENTRYPOINT instructions 
WORKDIR
    set the working directory for any RUN, CMD, ENTRYPOINT, COPY, ADD instructions that follow it in the Dockerfile
VOLUME
ARG
    ARG <name>[ =<default value>]
    define a variable that user can pass at build-time to the builder with the docker build command using "build-arg <var>=<value>"
STOPSIGNAL
    set the system call signal that will be sent to the container to exit

HEALTHCHECK
    check container health by running a command inside the container

.dockerignore

