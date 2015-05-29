<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Titre      : Programme XSLT pour la transformation en XHTML simple de fichier TEI réalisé à partir de manuscrits
Auteur     : Florence Clavaud (Ecole nationale des chartes)
Audience     : participants à la formation sur TEI donnée an mars 2011 à l'Ecole des chartes
Conditions d'utilisation : licence Creative Commons paternité-pas d'utilisation commerciale-modification autorisée dans les mêmes conditions etc.
Date      : 10 mars 2011, relecture 12 avril 2011
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="tei">
	<xsl:output indent="yes" method="xml" encoding="UTF-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
	<xsl:strip-space elements="*"/>
	<!-- un paramètre pour traiter la section de commentaires ou non -->
	<xsl:param name="commentaires"/>
	<xsl:template match="comment() | processing-instruction()"/>
	<xsl:template match="/tei:TEI">
		<!-- on génère le squelette de la page HTML -->
		<html>
			<!-- métadonnées simples. Pourraient être complétées pour générer des balises meta en établissant une correspondance avec le modèle Dublin Core -->
			<head>
				<title>
					<xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/>
					<xsl:if test="//tei:titleStmt/tei:title[@type='complement']">
						<xsl:value-of
							select="concat(' : ', //tei:titleStmt/tei:title[@type='complement'])"/>
					</xsl:if>
				</title>
				<link rel="stylesheet" type="text/css" href="acteRoyal.css"/>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			</head>
			<!-- le corps de la page -->
			<body>
				<!-- une colonne à gauche, pour l'en-tête et l'image -->
				<div id="gauche">
					<div id="header">
						<!-- cette colonne ne contiendra que les informations bibliographiques -->
						<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:titleStmt"/>
						<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:publicationStmt"
						/>
					</div>
					<!-- on va placer les images numériques ici, ce n'est pt-être pas l'idéal, mais il y a de la place à cet endroit et on veut rester simple -->
					<div id="images">
						<img src="{descendant::tei:div[@type='transcription']/@facs}"
							alt="O/1/284 n° 525, page 1" width="90%"/>
					</div>
				</div>
				<!-- une autre colonne, elle-même scindée en plusieurs parties, pour la table des matières, les métas du document, la transcription, etc. -->
				<div id="droite">
					<div id="tdm">
						<ul>
							<li>
								<a href="#metadonnees-textuelles">Informations sur le document</a>
							</li>
							<li>
								<a href="#transcription">Transcription</a>
							</li>
							<li>
								<a href="#notes">Notes historiques</a>
							</li>
							<xsl:if test="$commentaires='oui'">
							<li>
								<a href="#commentaires">Commentaires</a>
							</li>
								</xsl:if>
							<!--<li>
								<a href="#index-personnes">Index des personnes</a>
							</li>
							<li>
								<a href="#index-lieux">Index des lieux</a>
								</li>-->
							<li><a href="#index">Index</a></li>
						</ul>
					</div>
					<div id="body">
						<!-- cette colonne présente toute la substance composant l'édition du manuscrit, notes incluses -->
						<div id="metadonnees">
							<hr/>
							<xsl:apply-templates select="tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>
							<xsl:apply-templates
								select="tei:teiHeader/tei:encodingDesc/tei:classDecl"/>
						</div>
						<div id="transcription">
							<hr/>
							<h2>Transcription</h2>
							<xsl:apply-templates
								select="tei:text/tei:body/tei:div[@type='transcription']"/>
							<p>
								<a href="#tdm">Retour au début</a>
							</p>
						</div>
						<div id="notes">
							<hr/>
							<xsl:apply-templates select="tei:text/tei:back/tei:div[@type='notes']"/>
							<p>
								<a href="#tdm">Retour au début</a>
							</p>
						</div>
						<xsl:if test="$commentaires='oui'">
						<div id="commentaires">
							<hr/>
							<h2>Commentaires</h2>
							<xsl:apply-templates
								select="tei:text/tei:body/tei:div[@type='commentaires']"/>
							<p>
								<a href="#tdm">Retour au début</a>
							</p>
						</div>
							</xsl:if>
					</div>
					<div id="index">
						<hr/>
						<h2>Index</h2>
						<!-- les index ou plutôt fichiers d'autorité -->
						<xsl:apply-templates select="tei:text/tei:back/tei:div[@type='indexes']"/>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<!-- LES INFOS D'EN-TETE -->
	<xsl:template match="tei:titleStmt">
		<div class="titleStmt">
			<p class="docTitle">
				<xsl:apply-templates select="tei:title[1]"/>
			</p>
			<!-- A REVOIR -->
			<xsl:if test="tei:author">
				<p class="author">
					<xsl:apply-templates select="tei:author"/>
				</p>
			</xsl:if>
			<xsl:if test="tei:principal">
				<p class="principal">
					<xsl:apply-templates select="tei:principal"/>
				</p>
			</xsl:if>
			<xsl:if test="tei:respStmt">
				<p class="respStmt">
					<span class="libelle">Contributeurs : </span>
					<xsl:for-each select="tei:respStmt">
						<span class="respStmt">
							<xsl:apply-templates select="tei:name"/>
							<xsl:apply-templates select="tei:resp"/>
						</span>
						<xsl:if test="position() != last()">
							<xsl:text> ; </xsl:text>
						</xsl:if>
					</xsl:for-each>
				</p>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- dans le div spécifié ci-dessus, un paragraphe pour le titre, un autre pour l'auteur principal, un autre pour les responsabilités secondaires -->
	<xsl:template match="tei:title[1]">
		<xsl:apply-templates/>
		<xsl:if test="following-sibling::tei:title[@type='complement']">
			<xsl:value-of
				select="concat(' : ', normalize-space(following-sibling::tei:title[@type='complement']))"
			/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="tei:principal | tei:titleStmt/tei:author">
		<xsl:text>Par </xsl:text>
		<xsl:value-of select="."/>
	</xsl:template>
	<xsl:template match="tei:respStmt/tei:name">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:resp">
		<xsl:value-of select="concat(' (', ., ')')"/>
	</xsl:template>
	<xsl:template match="tei:publicationStmt">
		<div class="publicationStmt">
			<p>
				<xsl:apply-templates select="tei:publisher"/>
				<xsl:apply-templates select="tei:address"/>
				<xsl:apply-templates select="tei:date"/>
			</p>
		</div>
	</xsl:template>
	<xsl:template match="tei:publisher">
		<span class="publisher">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:address">
		<!-- si on ne veut pas que l'adresse de l'organisme responsable de la publication figure dans la sortie, il suffit de mettre le contenu de cette règle en commentaire, pour qu'elle soit vide -->
		<xsl:text> (</xsl:text>
		<xsl:apply-templates select="tei:addrLine"/>
		<xsl:text>). </xsl:text>
	</xsl:template>
	<xsl:template match="tei:publicationStmt/tei:date">
		<span class="libelle">Date de publication : </span>
		<span class="date">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:addrLine">
		<xsl:apply-templates/>
		<xsl:if test="position() != last()">
			<xsl:text>, </xsl:text>
		</xsl:if>
	</xsl:template>
	<!-- LES METAS DU DOCUMENT -->
	<xsl:template match="tei:sourceDesc">
		<div class="sourceDesc">
			<xsl:apply-templates select="tei:msDesc/tei:msIdentifier"/>
			<xsl:apply-templates select="tei:msDesc/tei:msContents"/>
			
			<xsl:apply-templates select="tei:msDesc/tei:physDesc"/>
			<!-- à compléter éventuellement -->
		</div>
	</xsl:template>
	<xsl:template match="tei:msIdentifier">
		<p class="msIdentifier">
			<!-- les instructions ne sont pas génériques, mais ça ira pour les 2 documents TEI -->
			<xsl:value-of
				select="concat(tei:institution, ' - ', tei:repository, ' (', tei:country, ') : ', tei:collection, ', ', tei:idno)"
			/>
		</p>
	</xsl:template>
	<xsl:template match="tei:msContents">
		<div class="msContents">
		<!-- <p class="msContents">-->
			<xsl:apply-templates/>
		<!-- </p>-->
			</div>
	</xsl:template>
	<xsl:template match="tei:physDesc">
		<div class="physDesc">
			<!-- <p class="msContents">-->
			<xsl:apply-templates/>
			<!-- </p>-->
		</div>
	</xsl:template>
	
	<xsl:template match="tei:summary">
		<p class="summary">
		<xsl:apply-templates/>
			</p>
	</xsl:template>
	<xsl:template match="tei:textLang">
		<p class="textLang"><xsl:text>Langue du document : </xsl:text>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="tei:objectDesc">
		<p class="objectDesc">
			<xsl:apply-templates select="descendant::tei:material"/>
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="descendant::tei:dimensions"/>
			<xsl:text> ; </xsl:text>
			<xsl:apply-templates select="descendant::tei:condition"/>
		</p>
	</xsl:template>
	<xsl:template match="tei:dimensions">
		<xsl:value-of select="concat('larg. ', tei:width, ' x haut. ', tei:height, ' ', @unit)"/>
	</xsl:template>
	<xsl:template match="tei:handDesc">
		<p class="label">Description des mains :</p>
		<ul>
			<xsl:for-each select="tei:handNote">
				<li><xsl:apply-templates/></li>
			</xsl:for-each>
		</ul>
	</xsl:template>
	<xsl:template match="tei:additions">
		<p class="additions">
		<!-- <span class="label">Additions : </span>-->
		<xsl:for-each select="tei:p">
			<xsl:apply-templates/>
			<xsl:if test="position() !=last()"><xsl:text> </xsl:text></xsl:if>
		</xsl:for-each>
			</p>
	</xsl:template>
	
	<xsl:template match="tei:classDecl">
		<!-- todo -->
	</xsl:template>
	<!-- TRANSCRIPTION -->
	<xsl:template match="tei:div[@type='transcription']">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:div[@type='transcription']/tei:div">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="tei:div[@type='transcription']/tei:div/tei:p">
		<p>
			<xsl:if test="@ana">
				<xsl:attribute name="class">
					<xsl:value-of select="substring-after(@ana, '#')"/>
				</xsl:attribute>
				<!-- pour afficher une étiquette devant chacune des réponses du roi :<xsl:choose>
					<xsl:when test="@ana='#ord'">
						<span class="label">Réponse : </span>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>-->
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="tei:subst">
		<span class="subst">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:del">
		<!--  <span class="del">
			<xsl:apply-templates/>
			</span>-->
		<xsl:element name="span">
			<xsl:attribute name="class">
				<!-- ici on utilise la fonction XPath local-name qui renvoie le nom de l'élément courant sans son préfixe -->
				<xsl:value-of select="local-name()"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="tei:add">
		<span>
			<xsl:attribute name="class">
				<xsl:text>add</xsl:text>
				<xsl:if test="@hand">
					<xsl:value-of select="concat('-hand', substring-after(@hand, '#'))"/>
				</xsl:if>
				<xsl:if test="@place">
					<xsl:value-of select="concat(' ', normalize-space(@place))"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:lb">
		<!-- retours à la ligne dans la page Web, chaque fois qu'il y a un changement de ligne dans le manuscrit <br/>-->
		<br/>
	</xsl:template>
	<xsl:template match="tei:ex">
		<xsl:value-of select="concat('(', normalize-space(.), ')')"/>
	</xsl:template>
	<xsl:template match="tei:expan">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:abbr | tei:am | tei:reg"/>
	<xsl:template match="tei:hi">
		<xsl:choose>
			<xsl:when test="@rend='super'">
				<sup>
					<xsl:apply-templates/>
				</sup>
			</xsl:when>
			<xsl:when test="@rend='bigger'">
				<xsl:apply-templates/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="tei:quote">
		<xsl:text>« </xsl:text>
		<xsl:apply-templates/>
		<xsl:text> »</xsl:text>
	</xsl:template>
	<xsl:template match="tei:seg">
		<span>
			<xsl:attribute name="class">
				<xsl:text>seg</xsl:text>
				<xsl:if test="@type">
					<xsl:value-of select="concat(' ', @type)"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:g">
		<xsl:if test="@ref='#paraphe'">
			<xsl:text> (paraphe)</xsl:text>
			<!-- <xsl:value-of select="@rend"/> -->
		</xsl:if>
	</xsl:template>
	<xsl:template match="tei:div[@type='transcription']//tei:persName">
		<span class="persName">
			<xsl:choose>
				<xsl:when test="@ref[starts-with(., '#')]">
					<xsl:variable name="monRef">
						<xsl:value-of select="substring-after(@ref, '#')"/>
					</xsl:variable>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="normalize-space(@ref)"/>
						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:value-of
								select="normalize-space(ancestor::tei:text/tei:back//tei:listPerson/tei:person[@xml:id=$monRef]/tei:persName[@type='complete'])"
							/>
						</xsl:attribute>
						<xsl:apply-templates/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>
	<xsl:template match="tei:div[@type='transcription']//tei:placeName | tei:summary//tei:placeName">
		<span class="placeName">
			<xsl:choose>
				<xsl:when test="@ref[starts-with(., '#')]">
					<xsl:variable name="monRef">
						<xsl:value-of select="substring-after(@ref, '#')"/>
					</xsl:variable>
					<xsl:element name="a">
						<xsl:attribute name="href">
							<xsl:value-of select="normalize-space(@ref)"/>
						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:value-of
								select="normalize-space(ancestor::tei:TEI//tei:back//tei:listPlace/tei:place[@xml:id=$monRef]/tei:placeName[@type='complete'])"
							/>
						</xsl:attribute>
						<xsl:apply-templates/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates/>
				</xsl:otherwise>
			</xsl:choose>
		</span>
	</xsl:template>
	<xsl:template match="tei:ref">
		<xsl:choose>
			<xsl:when test="@type='note'">
				<xsl:variable name="monRef" select="substring-after(@target, '#')"/>
				<sup>
					<a href="{@target}">
						<xsl:attribute name="title">
							<xsl:value-of
								select="normalize-space(ancestor::tei:text/tei:back//tei:div[@type='notes']/tei:note[@xml:id=$monRef])"
							/>
						</xsl:attribute>
						<xsl:value-of select="count(preceding::tei:ref[@type='note']) + 1"/>
					</a>
				</sup>
			</xsl:when>
			<xsl:otherwise>
				<a href="{@target}">
					<xsl:apply-templates/>
				</a>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<!-- NOTES -->
	<xsl:template match="tei:div[@type='notes']">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:note">
		<p class="note">
			<xsl:attribute name="id">
				<xsl:value-of select="normalize-space(@xml:id)"/>
			</xsl:attribute>
			<span class="numero">
				<xsl:value-of select="format-number(substring-after(@xml:id, '-'),'#')"/>
				<!-- <xsl:value-of select="count(preceding-sibling::tei:note) + 1"/> -->
				<xsl:text>. </xsl:text>
			</span>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<!-- FICHES D'AUTORITE -->
	<xsl:template match="tei:div[@type='indexes']">
		<div class="index-list" id="index-personnes">
			<xsl:apply-templates select="tei:listPerson"/>
			<p>
				<a href="#tdm">Retour au début</a>
			</p>
		</div>
		<div class="index-list" id="index-lieux">
			<xsl:apply-templates select="tei:listPlace"/>
			<p>
				<a href="#tdm">Retour au début</a>
			</p>
		</div>
	</xsl:template>
	<xsl:template match="tei:listPerson">
		<h3>Index des personnes</h3>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:listPlace">
		<h3>Index des lieux</h3>
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:person">
		<p class="person">
			<xsl:attribute name="id">
				<xsl:value-of select="@xml:id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="tei:place">
		<p class="place">
			<xsl:attribute name="id">
				<xsl:value-of select="@xml:id"/>
			</xsl:attribute>
			<xsl:apply-templates select="tei:placeName"/>
			<br/>
			<xsl:apply-templates select="tei:desc"/>
			<br/>
			<xsl:apply-templates select="tei:note | tei:bibl"/>
		</p>
	</xsl:template>
	<xsl:template match="tei:person/tei:persName[@type='complete']">
		<span class="entree">
			<xsl:apply-templates/>
			<xsl:text>. </xsl:text>
		</span>
		<br/>
	</xsl:template>
	<xsl:template match="tei:person/tei:persName[not(@type)]"/>
	<xsl:template match="tei:place/tei:placeName[not(@type)]"/>
	<xsl:template match="tei:birth | tei:death  | tei:sex"/>
	<xsl:template match="tei:occupation">
		<span class="occupation">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="tei:person/tei:note">
		<br/>
		<span class="note"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:place/tei:placeName[@type='complete']">
		<span class="entree">
			<xsl:apply-templates/>
			<xsl:apply-templates select="following-sibling::tei:location"/>
			<xsl:text>. </xsl:text>
		</span>
		
	</xsl:template>
	<xsl:template match="tei:location">
		<xsl:text> (</xsl:text>
		<xsl:if test="tei:settlement[@type='commune']">
			<xsl:apply-templates select="tei:settlement[@type='commune']"/>
			<xsl:if test="following-sibling::*">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="tei:district[@type='departement']">
			<xsl:apply-templates select="tei:district[@type='departement']"/>
			<xsl:if test="following-sibling::*">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="tei:region">
			<xsl:apply-templates select="tei:region"/>
			<xsl:if test="following-sibling::*">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:if>
		<xsl:if test="tei:country">
			<xsl:apply-templates select="tei:country"/>
		</xsl:if>
		<xsl:text>).</xsl:text>
		<xsl:if test="tei:geo">
			<br/>
			<span class="geo"><xsl:text>Coordonnées géographiques : </xsl:text>
			<xsl:value-of select="concat('lat. ', substring-before(tei:geo, ' '), ', long. ', substring-after(tei:geo, ' '))"/></span>
		</xsl:if>
	</xsl:template>
	<xsl:template match="tei:desc">
		
		<span class="desc">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<!-- COMMENTAIRES -->
	<xsl:template match="tei:div[@type='commentaires']">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:div[@type='commentaires']/tei:div">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="tei:head">
		<h3><xsl:apply-templates/></h3>
	</xsl:template>
	<xsl:template match="tei:div[@type='commentaires']//tei:p">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="tei:div[@type='commentaires']//tei:listBibl">
		<ul>
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="tei:listBibl/tei:bibl">
		<li><xsl:apply-templates/></li>
	</xsl:template>
	<xsl:template match="tei:bibl//tei:title">
		<span class="title"><xsl:apply-templates/></span>
	</xsl:template>
	<xsl:template match="tei:bibl//tei:surname">
		<span class="surname"><xsl:apply-templates/></span>
	</xsl:template>
</xsl:stylesheet>
