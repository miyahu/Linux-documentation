* [Afficher les pages en Draft](#Afficher les pages en Draft)
* [Baser l'ordonnancement des pages du menu sur un poid](#Baser l'ordonnancement des pages du menu sur un poid)
* [Exclure des pages du menu](#Exclure des pages du menu)

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

## Principes de base

Les layouts sont apparement indispensables, sans eux, le rendu ne s'effectue pas !!!   
Les layouts peuvent êtres présents à la racine de l'arbo elle-même ou dans le thème, mais ils sont nécessaire pour effectuer le rendu 

## Les index
Hugo permet la création automatique d'index via l'utilisation de la variable 

```bash
{{ .TableOfContents }}
```

### créer automatiquement un sommaire

```bash
{{ .Summary }} 
```

### Template et cascading

#### Le thème

```bash
tree --charset=ascii -I static -I "exampleSite|images|static|modules|scss"  themes/light-hugo/
themes/light-hugo/
|-- archetypes
|   `-- default.md
|-- build.sh
|-- layouts
|   |-- 404.html
|   |-- _default
|   |   |-- list.html
|   |   `-- single.html
|   |-- index.html              <-- page d'accueil (auto-générée sans md)
|   |-- pages
|   |   `-- single.html
|   |-- partials
|   |   |-- footer.html
|   |   |-- foot.html
|   |   |-- header.html
|   |   `-- head.html
|   `-- post
|       |-- single.html         <-- template de la section post
|       `-- summary.html        <-- template de résumé (qui sera repris par index (.Render "Summary"))
|-- LICENSE
|-- README.md
`-- theme.toml
```

#### Le "content"

```bash
 tree --charset=ascii  content/
content/
|-- pages
|   `-- resume.md
`-- post
    |-- creating-a-new-theme.md
    |-- goisforlovers.md
    |-- hugoisforlovers.md
    `-- migrate-from-jekyll.md
```

### Effectuer un OU logique sur des conditions

```bash
{{ if (eq .Type "post") | or (eq .Type "tagada") }}
    {{ .Render "summary" }}
{{ end }}
```

### créer un menu rapidement 

https://gohugo.io/templates/menu-templates/#section-menu-for-lazy-bloggers

```bash
cat themes/light-hugo/layouts/partials/menu.html 
<nav class="sidebar-nav">
    {{ $currentPage := . }}
    {{ range .Site.Menus.main }}
    <a class="sidebar-nav-item{{if or ($currentPage.IsMenuCurrent "main" .) ($currentPage.HasMenuCurrent "main" .) }} active{{end}}" href="{{.URL}}">{{ .Name }}</a>
    {{ end }}
</nav>
```
et dans les pages du content 

```bash
cat content/tagada/pouet.md 
---
title: "Pouet"
date: 2017-11-17T18:41:24+01:00
menu: main
---

### grr

gre
```
