#Google cloud

## Google storage

### gsutil
#### créer un bucket 
De type DRA, associé à notre projet et créé sur la zone Europe-west

`gsutil mb -c DRA -l EUROPE-WEST1 -p tagada-1487 gs://tagada-backup`

#### activer le versionning 
`gsutil versioning set on  gs://tagada-backup`

#### activer un life-cycle standart
```
cat>lifecycle_config.json<<EOF 
{
  "rule": [
   {
    "action": {
     "type": "Delete"
    },
    "condition": {
     "age": 30,
     "isLive": true
    }
   },
   {
    "action": {
     "type": "Delete"
    },
    "condition": {
     "isLive": false,
     "numNewerVersions": 3
    }
   }
  ]
}
EOF
``` 
puis
`gsutil lifecycle set lifecycle_config.json gs://tagada-backup`

#### lancer une sauvegarde différentiel

`gsutil -m rsync -d -r /sauvegardes/mail  gs://tagada-backup`

#### autoriser l'accès à tout le monde vers ce bucket

`gsutil acl ch -u AllUsers:R  gs://tagada-backup`
