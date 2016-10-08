## Security
1. the intrinsic security of the kernel and its support for namespaces and cgroups;
2. the attack surface of the Docker daemon itself;
3. loopholes in the container configuration profile, either by default, or when customized by users.
4. the “hardening” security features of the kernel and how they interact with containers.
5. Namespaces provide the first and most straightforward form of isolation: processes running within a container cannot see, and even less affect, processes running in another container, or in the host system.
6. Each container also gets its own network stack,
7. only trusted users should be allowed to control your Docker daemon.

