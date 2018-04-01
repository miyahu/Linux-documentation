### ajouter son minio local à la config du client docker

```bash
docker run minio/mc config host add minio http://16.72.26.13:9000 BQVCX5ZJY5 JsjTrlPGs8DHa3jix
```

### voir la config local

```bash
docker run minio/mc cat /root/.mc/config.json
```
