<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" encoding="UTF-8"/>
    <xsl:template match="comment()">
        <xsl:value-of select="."/>
    </xsl:template>
    
</xsl:stylesheet>
