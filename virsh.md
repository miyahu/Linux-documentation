# Vish

## managment 

### voir les machines

```bash
virsh list --all
```

### graceful shutdown 

```bash
virsh shutdown ID
```

### hard shutdown

```bash
virsh destroy ID
```

### démarrage 

```bash
virsh start ID
```

### éditer la config d'un guest

virsh edit "guest"

### information sur un guest

```bash
virsh dominfo
```


#### quel disque est accroché à ma vm

```bash
virsh domblklist 65
Target     Source
------------------------------------------------
vda        /dev/vm/antonio1
```
