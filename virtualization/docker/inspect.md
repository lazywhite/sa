Id
Created
Path
Args
State
    Status
    Running
    Paused
    Restarting
    OOMKilled
    Dead
    Pid
    ExitCode
    Error
    StartedAt
    FinishedAt
Image
ResolveConfPath
HostnamePath
HostsPath
LogPath
Name
RestartCount
Driver
MountLabel
ProcessLabel
AppArmorProfile
ExecIDs
HostConfig
    binds
        <host path>:<container path>
        ...
    ContainerIDFile
    LogConfig
        Type: json-file
        Config: {}
    NetworkMode
    PortBindings
        5432/tcp:
            HostIp:<ip>, HostPort:<port>
            ...
        
    RestartPolicy
        Name
        MaximumRetryCount
    AutoRemove
    VolumeDriver
    VolumesFrom
    CapAdd
    CapDrop
    Dns
    DnsOptions
    DnsSearch
    ExtraHosts
    GroupAdd
    IpcMode
    Cgroup
    Links
    OomScoreAdj
    PidMode
    Privileged: boolean
    PublishAllPorts: boolean
    ReadonlyRootfs: boolean
    SecurityOpt: 
    UTSMode
    UsernsMode
    ShmSize
    Runtime
    ConsoleSize
    Isolation
    CpuShares
    Memory
    CgroupParent
    BlkioWeight 


GraphDriver
    Name
    Data
Mounts
    source, destination, mode, rw, propagation
    ...

Config
    hostname
    domainName
    User
    attachStdin
    attachStdout
    attachStderr
    ExposedPorts
        "5432/tcp" : {}
    tty
    OpenStdin
    StdinOnce
    Env
        PGUSER=<>
        PGHOST=<>
        PGPASSWORD=<>

    Cmd
    Image
    Volumes
    WorkingDir
    EntryPoint
    OnBuild
    Labels

NetworkSetting
    Bridge
    SandboxId
    HairpinMode
    LinkLocalIPv6Address
    LinkLocalIPv6Prefixlen
    Ports
        "5432/tcp":[
            {"hostip": <ip>, "hostport":<port>}
            ]
    SandboxKey
    SecondaryIPAddresses
    SecondaryIPv6Addresses
    EndpointID
    Gateway
    IPAddress
    IPPrefixlen
    MacAddress
    Networks
        bridge
            IPAMConfig
            Links
            Aliases
            NetworkID
            EndpointID
            Gateway
            IPAddress
            MacAddress
