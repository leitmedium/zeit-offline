<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:foo="http://www.foo.org/" xmlns:bar="http://www.bar.org">
<xsl:template match="/">
  <html>
    <head><title><xsl:value-of select="article/body/title"/></title></head>
   <body>
   <h1><xsl:value-of select="article/body/title"/></h1>
   <i>von: <xsl:value-of select="article/head/author/display_name"/></i><br/>
   veröffentlicht am: <xsl:value-of select="substring(article/head/attribute[@name='date_first_released'],1,10)"/>
   <xsl:for-each select="article/body/division">
       <xsl:copy-of select="."/>
   </xsl:for-each>
   </body>
  </html>
</xsl:template>
</xsl:stylesheet>
