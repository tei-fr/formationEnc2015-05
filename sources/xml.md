<!DOCTYPE html>
<html>
  <head>
    <title>Title</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="themes/remark-dark-em.css" rel="stylesheet" media="all" type="text/css"/>
  </head>
  <body>
    <textarea id="source">
title: 02-XML
description: emchateau, ENC 27-30 octobre 2014
theme: themes/remark-dark-em.css
name: inverse
layout: true
class: inverse

---

name: index
class: center middle

# 01 – eXtensible Markup Language
Formation TEI | projet Desgodets 2015

.footnote[[Répertoire GitHub](https://github.com/emchateau/formEnc2014-10/tree/desgodets) | [Programme](00-programme.html)]

---

name: introduction
class: center middle

# Introduction sur .red[XML]

???

On vient de voir qu’un balisage descriptif permettait de **se concentrer sur le contenu du texte plutôt que sur la présentation physique finale du document**.

Dans une démarche qui privilégie avant tout l’édition du texte, il convient en premier lieu de **rendre la structure du texte explicite, c’est-à-dire de clarifier à la fois les relations hiérarchiques et séquentielles**. La présence du balisage détermine par la suite la possibilité de traiter les éléments pour une transformation.

Le métalangage informatique XML (Extensible Markup Language) permet le développement de vocabulaires descriptifs de balisages interopérables spécifiques à certains domaines.

- cf. Bray, Tim, Paoli, Jean, Sperberg-McQueen, C. Michael, Maler, Eve, et Yergeau, François, [Extensible Markup Language (XML) 1.0](http://www.w3.org/TR/REC-xml/), Recommandation du W3C, 2008.

## Un modèle de contenu arborescent

Son **modèle de contenu arborescent** est précisément conforme au modèle OHCO.

S’il offre une grammaire lisible par la machine, il ne présente pas une réelle sémantique et ne peut donc à lui seul spécifier formellement une sémantique.

XML propose simplement **une solution rigoureuse, compréhensible par les machines, pour définir un langage de balisage descriptif**.

## Une large utilisation dans le domaine culturel

La plupart des contenus des bibliothèques numériques aujourd’hui mis à disposition sur le web sont encodés en utilisant un balisage XML. « La large adoption de vocabulaires XML spécialisés comme la TEI rendent disponible une importante information sémantique, mais seulement sous la forme d’une documentation en prose et de pratiques partagées. »[1]

[1] Coombs, James H, Renear, Allen H, et DeRose, Steven J. ["Markup Systems and the Future of Scholarly Text Processing."](http://xml.coverpages.org/coombs.html) Communications of the ACM 30, no. 11 (1987): 933-947.

---

layout: false

# e.red[X]tensible .red[M]arkup .red[L]anguage – historique

### héritier de SGML (Standard Generalized Marku Language)

- métalangage informatique pour le balisage du texte

- norme ISO (ISO 8879:1986)

## publication par le W3C en février 1998

- des spécifications du métalangage XML 1.0

- maîtres mots : simplicité, clarté, universalité

- [version 1.1](http://www.w3.org/TR/xml11) en 2004

???

## héritier de SGML

SGML lui-même héritier d’un langage descriptif conçu en 1969 par des ingénieurs de la société IBM : DCF (Document Composition Facility).

SGML : puissant et générique mais aussi trop souple et complexe en même temps → surtout utilisé dans le cadre d’applications lourdes. Utilisation la plus notable : langage HTML, dérivé du SGML => langage de publication pour le web.Né en 1989 et depuis 2011, HTML 5.

## Publication de XML

En février 1998 : publication en février 1998 par le W3C Consortium des spécifications du métalangage XML 1.0 => maîtres mots : simplicité, clarté, universalité.

Dans son Référentiel général  d’interopérabilité publié en 2009, la Direction générale de la modernisation de l’État recommande l’utilisation des technologies XML (Extensible Markup Language) à des fins d’interopérabilité et de pérennisation de l’information.

Depuis 1998, la norme XML a peu évolué → dernière édition en date : 5e édition, mise à jour en 2008. Version 1.0 => véritable témoignage de sa stabilité.

Version 1.1. publiée en février 2004 et mise à jour en 2006, notamment pour intégrer les évolution d’Unicode, mais XML 1.1 reste très peu utilisé.

## Un succès immédiat

Les langages et outils permettant de produire, contrôler, échanger, transformer et exploiter des fichiers XML se sont multipliés, souvent associés à des normes du W3C : modèles de documents et de (méta)données, langages de modélisation, de présentation, de programmation, protocoles, …

Métalangage désormais utilisé partout en informatique qu’il s’agisse de structurer des informations dont la durée de vie est importante ou d’échanger des informations entre applications, qu’on ait à s’occuper essentiellement de données, de documents ou d’une combinaison des deux.


- cf. Ministre du Budget, des Comptes publics, [Référentiel Général d’Interopérabilité (RGI)](http://references.modernisation.gouv.fr/rgi-interoperabilite), 2009.

---

# Principes de conception de .red[XML]

### applicable à tout type de texte

### extensible

### définition par un schéma

### hypertextualité

### simple, universel

### modèle hiérarchique

???

- XML s’applique à tout type de texte : fondé sur le principe du balisage → càd : sur l’isolement d’une portion de texte et l’identification explicite de son rôle ou nature particulière. Autorise l’imbrication des balises et une granularité aussi fine que nécessaire.

- Un modèle (=la liste des balises utilisables, leurs noms, les contraintes de leur emploi : position, cardinalité, type de contenu) peut être défini sous la forme d’une DTD (Document Type Definition) ou d’un schéma (écrit en RelaxNG ou directement XML).

- XML permet d’identifier la structure d’un texte et d’informer sur la sémantique des informations qu’il contient, ou d’en isoler les données => notion de structuration absolument primordiale : permet de rendre l’information exploitable par la machine (moteurs de recherche) et par l’utilisateur ; permet également à l’information d’être réutilisée, échangée, pérénisée. + bonne structure seule condition pour ensuite une transformation automatique.

- XML conçu à l’ère de l’hypermédia : liens peuvent être établis entre des sections du même document XML ou entre un document XML et d’autres ressources électroniques, qui peuvent ne pas être du texte.

- norme simple, sans ambiguité, permettant à un humain de lire l’information produite.

- fichiers XML sont des fichiers texte (peuvent être lus par grand nombre de logiciels donc) et supportent surtout un grand nombre de systèmes d’écriture → utilise le standard Unicode et le codage par défaut de XML est UTF-8 (codage de caractères conçu pour coder l’ensemble des caractères Unicode).

- norme universelle, concentrée sur le contenu informationnel, ne traitant pas de son utilisation, indépendante des plates-formes informatiques (≠.odt, .doc, …).

- utiliser XML pour structurer et échanger l’information est considéré comme une bonne pratique → les documents XML sont de bons candidats pour l’archivage pérenne.
- grâce à leur structure réutilisation : l’accès, l’indexation et la recherche de l’information sont améliorées → on peut avec certains outils informatiques indexer un (ou un ensemble de) documents XML en exploitant leur marquage structurel, ce qui permet des recherches fines multi-critères et améliore considérablement la qualité des réponses par rapport à une recherche plein texte dans un document non structuré.

- on peut aussi explorer un document XML en tant qu’arbre, en utilisant notamment le langage Xpath.
=> XML : format de stockage pour autant de formats de diffusion qu’on souhaite. Après transformation par programmes dans un ou plusieurs formats dédiés, le contenu structuré d’un document XML peut être consulté sous forme imprimée (transformation directement en PDF ou vers LateX), sous forme électronique (HTML) => XML : format pivot pour les nouvelles chaînes éditoriales.

---

# XML en .red[4 points]

### .red[1.] **XML ne sert pas à afficher les données mais à les décrire**. Seul, il ne fait rien. Appliqué à la représentation des textes, il permet de décrire notamment leur structure (livre, chapitre, paragraphe, phrase, mot, etc.)
### .red[2.] **Le nom des balises n’est pas prédéfini** : on peut librement créer son propre vocabulaire
### .red[3.] **On peut utiliser une "grammaire" de balises**, pour définir des contraintes ou s’assurer de la consistance de l’encodage
### .red[4.] **XML est auto-descriptif et lisible par l’homme**. Un fichier XML n’est rien que du texte, on peut facilement prendre connaissance d’un corpus dans n’importe quel éditeur textuel


---

# Élément XML

![élément XML](images/xml01.svg)

---

# Attribut XML

![élément XML](images/xml02.svg)

---

# balisage XML

![élément XML](images/xml00.svg)
---

# Exemple de document XML

```xml
<?xml version="1.0"?>
<doc xmlns="http://example.org/​namespace">
  <p n="1">This is a paragraph.</p>
  <p n="2">This paragraph mentions <placeName>Bristol</placeName>.</p>
</doc>
```

???
Un document XML prend toujours la forme suivante.

Un document XML consiste en une séquence de caractères lisibles par l’homme. C’est **un simple fichier texte** qui ne contient pas de code additionnel ou de données binaires.

Seulement, vous pouvez constater que ce document comporte certaines séquences de caractères régulières (ici mises en valeur par la coloration).

La première ligne de ce documents s’appelle une **déclaration XML** elle appartient au **prologue** du document. C’est une instruction qui permet d’indiquer qu’il s’agit d’un document XML et la version du langage.

On peut également préciser l’encodage des caractères.

---

# Exemple de document XML

```xml
<?xml version="1.0" encoding="UTF-8"?>
<doc xmlns="http://example.org/​namespace">
  <p n="1">This is a paragraph.</p>
  <p n="2">This paragraph mentions <placeName>Bristol</placeName>.</p>
</doc>
```

???

## Encodage

Ici on utilise **l’encodage de caractère UTF-8** (pour Universal Character Set) qui permet de représenter la pluspart des caractères du « répertoire universel de caractères codés » initialement développé par l’ISO (ISO/CEI 10646), aujourd’hui entièrement compatible avec le standard **Unicode**.

Le répertoire Unicode peut contenir plus d’un million de caractères.

cf. https://fr.wikipedia.org/wiki/UTF-8

cf. Jukka Korpela. "Guide to the Unicode standard" http://www.cs.tut.fi/~jkorpela/unicode/guide.html


## Composition

Les caractères `<` et `>` sont utiliser pour marquer le début et la fin de **balises** à l’intérieur de ce flux textuel. Ces éléments possèdent un nom.

Vous remarquez que ces balises, ou markup, ou encore étiquettes, sont appariées. À chaque **balise ouvrante** correspond une **balise fermante** qui se distingue en débutant par la séquence `</`.

Le document comporte également des *attributs*. Ce sont des **paires nom-valeurs** qui se rattachent aux éléments.

--

### Les séquences `<`, `>` et `</` délimitent les balises : `<div></div>`

### Les paires nom-valeur des attributs ont la forme `nom='valeur'` équivalente à `nom="valeur"`

### Syntaxte des éléments vides : `<div></div>` = `<div/>`

---

# Le corps du document XML : un .red[arbre d’éléments]

- Les éléments : permettent de décomposer le texte en unités d’information

```xml
 <titre>Le corps du document XML : un arbre d’éléments</titre>
```

- **Tout élément a un nom** (parfois appelé identificateur générique), ici c’est titre.

- **Un élément peut contenir du texte et/ou d’autres éléments, ou être vide**.

- Il existe un et un seul élément englobant tous les autres, encodé en premier, juste après le prologue : c’est **l’élément racine**.


???

# Le corps du document XML : un arbre d’éléments

## Les éléments : permettent de décomposer le texte en unités d’information


```xml
 <titre>Le corps du document XML : un arbre
 d’éléments</titre>
```

La portion de texte ainsi isolée est marquée par une balise de début (balise ouvrante <titre>) et par une balise de fin (balise fermante </titre>)

## Tout élément a un nom (parfois appelé identificateur générique), ici c’est titre.

## Un élément peut contenir du texte et/ou d’autres éléments, ou être vide.

## Il existe un et un seul élément englobant tous les autres, encodé en premier, juste après le prologue : c’est l’élément racine.

---

# Les .red[attributs]

Les attributs précisent la signification des éléments, leur ajoutent des caractéristiques

- Sont toujours saisis à l’intérieur de la balise ouvrante de l’élément

- Syntaxe : nomAttribut="valeur":

```xml
<date when="2011-03-09">9 mars 2011</date>
```

- le nom de l’attribut obéit aux contraintes syntaxiques des noms XML

- la valeur est encadrée par des guillemets simples ou doubles.

- L’ordre des attributs n’est pas prescrit pour un élément donné

- Un attribut doit nécessairement avoir une valeur, même si cette valeur est nulle

- Pour un même élément, il ne peut y avoir deux attributs de même nom.


???

# Les .red[attributs]

Les attributs précisent la signification des éléments, leur ajoutent des caractéristiques

- Sont toujours saisis à l’intérieur de la balise ouvrante de l’élément

- Syntaxe : nomAttribut="valeur":

```xml
<date when="2011-03-09">9 mars 2011</date>
```

- le nom de l’attribut obéit aux contraintes syntaxiques des noms XML

- la valeur est encadrée par des guillemets simples ou doubles.

- L’ordre des attributs n’est pas prescrit pour un élément donné

- Un attribut doit nécessairement avoir une valeur, même si cette valeur est nulle

- Pour un même élément, il ne peut y avoir deux attributs de même nom.

> Les attributs ne contiennent que du texte, peuvent donc servir pour stocker de l’information qui n’est pas elle-même structurée.

> En principe ne sont pas destinés à ajouter du contenu à l’élément, donc leur valeur n’est pas destinée à être affichée telle quelle dans un format de sortie. Mais ils pourront être exploités par des applications informatiques pour faire par exemple des index, ils peuvent servir à identifier les éléments (attributs de type ID), à établir des renvois (attributs de type IDREF).

---

# Les noms des éléments (et des attributs)

Règles pour l’écriture de ces noms (parfois appelés identificateurs génériques) :

- la chaîne de caractères formant le nom peut contenir les caractères alphanumériques (lettres de a à z, et de A à Z, chiffres de 0 à 9, caractères non latins), le trait sous la ligne, le trait d’union et le point (à l’exclusion de tout autre signe de ponctuation ou blanc) ;

- un nom ne peut pas commencer par un nombre, ni par un point, ni par un trait d’union ;

- le nom ne peut pas commencer par "xml" (quelle que soit la casse utilisée).

- Attention, XML est sensible à la casse.

---

# Les entités

## Entités internes :

- entités caractères prédéfinies ou non, pour saisir certains caractères que l’on doit obligatoirement coder ( <, >, &, ", ’ : caractères codés au moyen des entités lt, gt, amp, quot, apos) ou difficiles à composer au clavier

## Un appel d’entité dans le corps du document XML se fait en utilisant l’esperluette (.red[&]), suivi du nom donné à l’entité, suivi du signe .red[;]

???

Les entités : des réserves de contenu, la plupart du temps à déclarer (dans la DTD) et utilisables n’importe où dans le document


## entités texte,

servant à donner un nom à des expressions ou phrases souvent répétées

## Entités externes :

- texte : fragments XML formant chacun un fichier

- non parsées (fichiers non XML tels qu’images, enregistrements sonores...)

---

## Les commentaires :

- Servent à... commenter, utiles pour documenter ce qu’on fait ou consigner des notes. Ne sont pas destinés aux programmes informatiques, qui les ignorent par défaut.

- Commencent par .red[<!--] et se terminent par .red[-->]

- Le double trait d’union (--) ne doit pas y apparaître.

## Les instructions de traitement :
- Commencent par .red[<?] et se terminent par .red[?>].

- Définissent une cible (fournissent le nom de l’application à qui elles sont destinées, par ex.), et des arguments

## Sections CDATA

sections de caractères non parsées. Commencent par `[! [CDATA[` et se terminent par `]]`.

---

# Espaces de nom

```xml
<TEI xmlns="http://www.tei-c.org/ns/1.0">
  <teiHeader><!-- autres éléments --></teiHeader>
  <text><!-- autres éléments --></text>
</TEI>
```

- formellement défini par son namespace-uri
- déclaré avec l’attribut .red[xmlns]
- déclaration par défaut

???

De plus en plus souvent, afin de faciliter les échanges en évitant toute ambiguité, les noms des éléments et attributs sont rattachés à un namespace (espace de noms).

- Formellement un espace de noms est défini par son URI (namespace-uri).

- Si on utilise un ou plusieurs espaces de noms, l’espace de noms (ou les espaces de noms) utilisé(s) doivent être déclarés dans le fichier XML. On le fait le plus souvent en ajoutant un (ou plusieurs) attribut(s) xmlns à l’élément racine du fichier. Un attribut xmlns a pour valeur l’URI d’un espace de noms.

- L’espace de noms peut être déclaré comme l’espace de noms par défaut, dans ce cas l’URI n’est pas associée à un code donné et les noms des attributs et éléments ne sont pas préfixés.

- Un code peut en effet représenter l’espace de noms, il est alors utilisé à la place de l’URI pour préfixer attributs et éléments ; ce code est appelé préfixe (namespace- prefix).


# Exemple

Ici l’espace de noms par défaut est défini par l’URI http://www.tei-c.org/ns/1.0, c’est l’espace de noms TEI. Tous les éléments du fichier XML qui sont descendants de l’élément racine et qui ne sont pas préfixés sont dans cet espace de noms.

---

# Document .red[bien formé]

- concordance entre l’encodage du document et sa déclaration XML;

- existence des fichiers déclarés (déclaration de DTD, déclaration de fichiers entités
externes) et concordance entre encodage des fichiers entités externes et leur
déclaration XML;

- forme des appels d’entités ;

- présence de **balises ouvrantes et fermantes appariées**, imbrication des balises sans
chevauchement ;

- respect des spécifications relatives aux noms XML (noms d’éléments et d’attributs) ;

- unicité des attributs dans un même élément, aucun attribut sans valeur

- forme des commentaires.

Le contrôle se fait par analyse syntaxique ou parsing (avec des outils appelés parsers).

---

# Bien formé, oui ou non ?

- `<segment>du texte</segment>`

- `<segment><article>du</article><nom>texte</nom></segment>`

- `<segment><article>du <nom></article> texte</nom></segment>`

- `<segment type="text">du texte</segment>`

- `<segment type='text'>du texte</segment>`

- `<segment type=text>du texte</segment>`

- `<segment type="text">du texte<segment/>`

- `<segment type="text">du texte<lacune/></segment>`

- `<segment type="text">du texte< /segment>`

- `<segment type="text">du texte</Segment>`

- `<segment type="text" type="toto">du texte</segment>`

---

# Modèles de documents

Rappel : définissent les contraintes que doit respecter une certaine classe de documents
Diverses syntaxes peuvent être utilisées pour écrire de tels modèles :

- celle des DTD (partie intégrante de la norme XML 1.0), la plus utilisée encore aujourd’hui ;

- celle, exprimée en XML, des schémas XML (norme du W3C publiée en mai 2001 ; 2e édition octobre 2004 ; voir <http://www.w3.org/XML/Schema> ) ;

- celle des schémas RelaxNG (norme ISO/IEC 19757-2 depuis 2003, amendée en 2008 ; voir <http://www.relaxng.org/>).

Beaucoup d’applications XML sont validantes, ainsi un processeur XSLT n’opérera de transformation à partir d’un document XML associé à un modèle que si ce document XML est valide.

???

Les schémas, qui peuvent s’écrire en XML quelle que soit la syntaxe choisie, permettent de contraindre plus fortement que les DTD le contenu des attributs et des éléments, et gèrent les espaces de noms.
Un parseur sachant interpréter la syntaxe utilisée pourra vérifier qu’un document est conforme à un modèle donné (est valide).

Exemples de parseurs : ceux intégrés aux éditeurs XML, aux navigateurs Web ; xmllint dans la librairie libxml, etc.

Beaucoup d’applications XML sont validantes, ainsi un processeur XSLT n’opérera de transformation à partir d’un document XML associé à un modèle que si ce document XML est valide.

---

name: sourcesBiblio
template: inverse
class: center middle

# Sources et bibliographie

---

name: biblio

# Orientations bibliographiques

- A gentle introduction to XML : <http://www.tei-c.org/release/doc/tei-p5-doc/en/html/SG.html>

- XML en concentré : manuel de référence / Elliotte Rusty Harold & W. Scott Means; traduction de Philippe Ensarguet, Frédéric Laurent. - 3e éd. - Paris : O'Reilly, DL 2005. - 1 vol. (XX-760 p.) : couv. ill. en coul. ; 24 cm. - Index. - ISBN 2-84177-353-1 (br.) : 45 € - EAN 9782841773534 ;

- L’espace XML francophone : actualités, discussions, articles et billets, sur le site Web <http://xmlfr.org/>
---

template: inverse
class: center middle

# La [suite](03-part.html)

.left[.footnote[[revenir au début](#index)]]

    </textarea>
    <!--<script src="http://gnab.github.com/remark/downloads/remark-0.6.5.min.js" type="text/javascript"></script>-->
        <script src="js/remark-0.6.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
      var hljs = remark.highlighter.engine;
    </script>
    <script src="remark.language.js" type="text/javascript"></script>
    <script type="text/javascript">
      var slideshow = remark.create({
          highlightStyle: 'monokai',
          highlightLanguage: 'remark'
        }) ;
    </script>

  </body>
</html>
