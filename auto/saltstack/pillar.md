## config
```
pillar_roots:
  base:
      - /srv/pillar
```
## access
```
git:
  pkg.installed:
      - name: {{ pillar['git'] }}
```
## ext_pillar
1. cmd_json
2. consul_pillar
3. django_orm
4. foreman
5. git_pillar
6. pillar_ldap
7. mongo
8. mysql
9. svn_pillar
