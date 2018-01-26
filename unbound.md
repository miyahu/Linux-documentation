# unbound

## configuration 

### nettoyage de la configuration

```bash 
grep -Ev "^[[:space:]]*#|^$" unbound.conf > unbound.conf-clean
```
