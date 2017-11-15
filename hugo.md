[Afficher les pages en Draft](#Afficher les pages en Draft)
[Baser l'ordonnancement des pages du menu sur un poid](#Baser l'ordonnancement des pages du menu sur un poid)
[Exclure des pages du menu](#Exclure des pages du menu)

### Afficher les pages en Draft
```bash
hugo -D server
```

### Baser l'ordonnancement des pages du menu sur un poid 

```bash
{{ range .Data.Pages.ByParam "rating" }}
```

### Exclure des pages du menu 

Dans la boucle d'affichage ajouter

```bash
{{ if not .Params.private }} 
```

Dans les pages concernées ajouter

```bash
private: yes
```
 
