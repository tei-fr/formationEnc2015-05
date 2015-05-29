<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml">
<!-- une XSL qui copie tout le document XML-TEI à l'identique !-->

<!-- ne jamais utiliser tel quel : un jeu de règles qui peut servir pour agir précisément 
sur les nœuds d'un document initial, ou pour commencer un travail complexe de
transformation et garder la trace de tous le nœuds du document. -->
  
    <xsl:output omit-xml-declaration="no" indent="yes" method="xml" version="1.0"
        encoding="UTF-8" />
  
<!-- la première instruction traite le noeud document et commande simplement de
parcourir les nœuds fils en profondeur -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="hi/@rend[.='sup']">
        <xsl:attribute name="rend">superscript</xsl:attribute>
    </xsl:template>

<!-- la deuxième instruction traite tous les nœuds (avec node(), sauf les nœuds attributs) 
et tous les  nœuds attributs (avec @*)
Elle se contente de les copier, puis pour les nœuds fils, passe la main ; 
ainsi elle copie tout récursivement -->

    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

<!-- exercices :
supprimer les commentaires dans le fichier résultat ;
supprimer les attributs xml-id de p ;
modifier la valeur d’un attribut rend -->

</xsl:stylesheet>
