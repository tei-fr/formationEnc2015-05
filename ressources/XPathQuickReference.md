Guide de référence rapide XPath
========

## Expression de chemin

Les étapes de parcours peuvent être combinées avec les opérateurs `/` qui désigne le nœud document et // qui signifie /descendant-or-self::`.

Ces étapes de parcours peuvent comprendre des prédicats.

`axe::testNode[prédicat]/.../axe::testNode[prédicat][...]`


## Axes 

Un axe a la forme `axis::node-test` et sélectionne les nœud qui satisfont le test de nœud sur un axe donné :
`ancestor` | sélectionne les ancêtres du nœud courant jusqu'au nœud document
`ancestor-or-self` | sélectionne le nœud courant et ses ancêtres
`attribute` | sélectionne tous les attributs du nœud courant (si c'est un élément)
`child` | sélectionne les enfants du nœud courant, dans l'ordre du document
`descendant` | sélectionne les enfants du nœud courant et ses enfants, récursivement
`descendant-or-self` | sélectionne le nœud courant et tous ses descendants
`following` | sélectionne les nœuds qui suivent le nœud courant dans l'ordre du document
`following-sibling` | sélectionne tous nœuds qui suivent qui partagent le même parent
`parent` | sélectionne le parent du nœud contexte
`preceding` | sélectionne les nœuds qui précèdent le nœud courant dans le document
`preceding-sibling` | sélectionne tous les nœud précédents qui partagent le même parent
`self` | sélectionne le nœud courant

L'axe `child::` peut être omis, et l'axe `attribute::` peut être abrégé en `@`. L'expression `parent::node()` peut être abrégée par `..`.


## test de nœuds

Les tests de nœuds peuvent être
- le nom d'un élément
- `prefix:*` sélectionne les éléments dans un espace de nom
- `*:localname` sélectionne les nœuds avec un nom local donné, indépendamment de l'espace de nom
- `text()` sélectionne les nœuds textuels
- `node()` sélectionne n'importe que nœud
- `processing-instruction()` sélectionne n'importe quelle instruction de traitement
- `processing-instruction('literal')` sélectionne les instruction de traitement avec le nom cible 
- `comment()` sélectionne les nœuds commentaires

## Opérateurs