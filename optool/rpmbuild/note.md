layout: post
title: RPMbuild
date: 2016-03-07 12:28:04
tags: rpmbuild
categories: [tech]
---
## Macros
```
rpmbuild --showrc
rpm --eval '%{macro_name}'
~/.rpmmacros
```
<!-- more -->
### Autoconf macros  
  
```
%{_sysconfdir}        /etc
%{_prefix}            /usr
%{_exec_prefix}       %{_prefix}
%{_bindir}            %{_exec_prefix}/bin
%{_libdir}            %{_exec_prefix}/%{_lib}
%{_libexecdir}        %{_exec_prefix}/libexec
%{_sbindir}           %{_exec_prefix}/sbin
%{_sharedstatedir}    /var/lib
%{_datarootdir}       %{_prefix}/share
%{_datadir}           %{_datarootdir}
%{_includedir}        %{_prefix}/include
%{_infodir}           /usr/share/info
%{_mandir}            /usr/share/man
%{_localstatedir}     /var
%{_initddir}          %{_sysconfdir}/rc.d/init.d


# paths variable and macro
%{_var}               /var
%{_tmppath}           %{_var}/tmp
%{_usr}               /usr
%{_usrsrc}            %{_usr}/src
%{_lib}               lib (lib64 on 64bit multilib systems)
%{_docdir}            %{_datadir}/doc
%{buildroot}          %{_buildrootdir}/%{name}-%{version}-%{release}.%{_arch}
$RPM_BUILD_ROOT       %{buildroot}

# rpm directory macros
%{_topdir}            %{getenv:HOME}/rpmbuild
%{_builddir}          %{_topdir}/BUILD
%{_rpmdir}            %{_topdir}/RPMS
%{_sourcedir}         %{_topdir}/SOURCES
%{_specdir}           %{_topdir}/SPECS
%{_srcrpmdir}         %{_topdir}/SRPMS
%{_buildrootdir}      %{_topdir}/BUILDROOT

# build flags variable and macro
%{__global_cflags}   -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4
%{optflags}          %{__global_cflags} -m32 -march=i686 -mtune=atom -fasynchronous-unwind-tables
$RPM_OPT_FLAGS       %{optflags}

# ~/.rpmmacros
%_topdir      %(echo $HOME)/rpmbuild
%_tmppath     %{_topdir}/tmp
```
  
##  action 
```
install: 1  
upgrade: 2  
uninstall: 0  
```

## Sections
```
%prep
%build
%install
%clean
%files
%pre
%post
%preun
%postun

```


## 查看未安装rpm包信息
```
rpm -qipl  drbd-pacemaker-9.5.0-1.el7.centos.x86_64.rpm # 文件列表
```
