# Les PDF

## Les différents manière de modifier un document pdf

### Ajouter une signature à un groupe de page existante

#### première

1. signer une feuille de papier blanche puis la scanner
2. insérer le scan dans Gimp, faire une selection par couleur puis copier-là
 dans une nouvelle fenêtre avec fond tranparent
3. adapter la taille et faire un export en png (choisir fond transparent) 
4. fractionner son document pdf en plusieurs pages avec
```bash
pdftk mon-pdf.pdf  burst
```
5. charger la page pdf dans Inskape puis importer et positionner la signature en png
6. enregistrer et quitter inskape
7. reconcatener les pages pdf avec
```bash
pdftk pg_000* cat output mon-pdf.pdf
```

#### seconde

1. ouvrir le pdf dans libre-office puis le modifier :-)
