<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
  xmlns:teix="http://www.tei-c.org/ns/Examples"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei teix xsl" 
  xpath-default-namespace="http://www.tei-c.org/ns/1.0">
  
  
  <xsl:import href="/Applications/oxygen/frameworks/tei/xml/tei/stylesheet/markdown/tei-to-markdown.xsl"/>
  
  <xsl:output method="html" version="5"/>
  <xsl:param name="language" select="fr"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>Title</title>
        <link href="remarks/themes/remark-dark-em.css" rel="stylesheet"
          media="all" type="text/css"/>
      </head>
      <body>
        <textarea id="source">

          <xsl:apply-templates select="TEI/teiHeader"/>
          <xsl:text>
--- 
            </xsl:text>
          <xsl:apply-templates select="TEI/text"/>
        </textarea>
        <!--<script src="http://gnab.github.com/remark/downloads/remark-0.6.5.min.js" type="text/javascript"></script>-->
        <script src="js/remark-0.6.5.min.js" type="text/javascript"/>
        <script type="text/javascript">
        var hljs = remark.highlighter.engine;
      </script>
        <script src="remark.language.js" type="text/javascript"/>
        <script type="text/javascript">
        var slideshow = remark.create({
        highlightStyle: 'monokai',
        highlightLanguage: 'remark'
        }) ;
      </script>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="teiHeader">
        <xsl:text>
title: </xsl:text>
        <xsl:apply-templates select="fileDesc/titleStmt/title"/>
        <xsl:text>
description: </xsl:text>
        <xsl:apply-templates select="fileDesc/titleStmt/author"/>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="fileDesc/publicationStmt/date"/>
        <xsl:text>
</xsl:text>
  </xsl:template>
  
  <xsl:template match="div[@type='slide']">
    <xsl:text>
--- 
    </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="div[@type='slide']/div[2]">
    <xsl:text>
???
    </xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="figure">
    <xsl:text>[</xsl:text>
    <xsl:apply-templates select="figDesc"/>
    <xsl:text>]</xsl:text>
    <xsl:text>(</xsl:text>
    <xsl:apply-templates select="graphic/@url"/>
    <xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template match="teix:egXML">
    <xsl:text>
```xml
    </xsl:text>
    <xsl:copy-of select="."/>
    <xsl:text>
```</xsl:text>
  </xsl:template>
  
  <xsl:template match="gi">
    <xsl:text>&lt;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&gt;</xsl:text>
    
```
  </xsl:template>
  
</xsl:stylesheet>