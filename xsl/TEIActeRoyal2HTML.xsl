<?xml version="1.0" encoding="UTF-8"?>
<!-- 
Titre      : Programme XSLT pour la transformation en XHTML simple de fichier TEI réalisé à partir de manuscrits
Auteur     : Florence Clavaud (Ecole nationale des chartes)
Audience     : participants à la formation sur TEI donnée an mars 2011 à l'Ecole des chartes
Conditions d'utilisation : licence Creative Commons paternité-pas d'utilisation commerciale-modification autorisée dans les mêmes conditions etc.
Date      : 10 mars 2011
Version : version non finalisée, à utiliser pour le TP 6 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="tei">
	<xsl:output indent="yes" method="xml" encoding="UTF-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<xsl:strip-space elements="*"/>
	<xsl:template match="comment() | processing-instruction()"/>
	<xsl:template match="/tei:TEI">
		<!-- on génère le squelette de la page HTML -->
		<xsl:element name="html">
			<!-- metadonnees simples. Pourraient être complétées pour générer des balises meta en établissant une correspondance avec le modèle Dublin Core -->
			<xsl:element name="head">
				<xsl:element name="title">
					<xsl:value-of select="normalize-space(//tei:titleStmt/tei:title[1])"/>
					<xsl:if test="//tei:titleStmt/tei:title[@type='complement']">
						<xsl:value-of
							select="concat(' : ', //tei:titleStmt/tei:title[@type='complement'])"/>
					</xsl:if>
				</xsl:element>
				<link rel="stylesheet" type="text/css" href="acteRoyal.css"/>
				<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			</xsl:element>
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
							<!-- à faire, ajouter de quoi avoir un lien vers notes et index -->
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
						<!-- à faire, ajouter de quoi afficher notes et index -->
					</div>
				</div>
			</body>
		</xsl:element>
	</xsl:template>
	<!-- LES INFOS D'EN-TETE -->
	<xsl:template match="tei:titleStmt">
		<div class="titleStmt">
			<p class="title">
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
	<xsl:template match="tei:principal | tei:author"> Par <!-- <xsl:text>Par </xsl:text> -->
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
				<!--<xsl:apply-templates select="tei:address"/> -->
				<xsl:apply-templates select="tei:date"/>
			</p>
		</div>
	</xsl:template>
	<xsl:template match="tei:publisher">
		<span class="publisher">
			<xsl:apply-templates/>
			<xsl:text>. </xsl:text>
		</span>
	</xsl:template>
	<xsl:template match="tei:address">
		<!-- si on ne veut pas que l'adresse de l'organisme responsable de la publication figure dans la sortie, il suffit de mettre le contenu de cette règle en commentaire, pour qu'elle soit vide -->
		<xsl:text> (</xsl:text>
		<xsl:apply-templates select="child::tei:addrLine"/>
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
			<!-- il va falloir compléter cette partie -->
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
		<p class="msContents">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="tei:summary">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Suggestion : dans la sortie HTML il manque l’information sur la langue du texte dans la page Web (dans le fichier TEI
	source, il y a un élément textLang-->
	<!-- <xsl:template match="tei:textLang">
		<p>
			<xsl:text>Langue du document : </xsl:text>
			<xsl:apply-templates/>
				
			
			
			
			
		</p>
		
		
	</xsl:template>-->
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
	<xsl:template match="tei:choice">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:ex">
		<xsl:value-of select="concat('(', normalize-space(.), ')')"/>
	</xsl:template>
	<xsl:template match="tei:expan">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="tei:abbr"/>
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
	<!-- retours à la ligne dans la page Web, chaque fois qu'il y a un changement de ligne dans le manuscrit -->
	<!-- <xsl:template match="tei:lb">
		<br/>
	</xsl:template>-->
	<!-- Une règle qui s'appliquera à un élément si aucune autre instruction spécifique ne le concerne ; elle permet donc de voir ce qui reste à traiter ; pratique !! -->
	<xsl:template match="*">
		<!-- Attention, du CSS dans un attribut style est une
			mauvaise pratique, ne surtout pas imiter <span style="margin:0 0 0 1em">
		-->
		<span>
			<code style="color:red">
				<xsl:text>&lt;</xsl:text>
				<xsl:value-of select="name()"/>
				<xsl:for-each select="@*">
					<xsl:text> </xsl:text>
					<xsl:value-of select="name()"/>
					<xsl:text>="</xsl:text>
					<xsl:value-of select="."/>
					<xsl:text>"</xsl:text>
				</xsl:for-each>
				<xsl:text>&gt;</xsl:text>
			</code>
			<xsl:apply-templates/>
			<code style="color:red">&lt;/<xsl:value-of select="name()"/>&gt;</code>
		</span>
	</xsl:template>
</xsl:stylesheet>
