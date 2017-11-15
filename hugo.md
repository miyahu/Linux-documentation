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
 
