<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
    <head><title><xsl:value-of select="article/body/title"/></title></head>
    <style type="text/css">
      body {
      margin-left: 40px;
      max-width: 820px;
      }
      img { padding-bottom: 5px; }
      span.bildunterschrift { font-size: small; }
      span.copyright { font-size:x-small; }
    </style>
   <body>
   <h1><xsl:value-of select="article/body/title"/></h1>
   <p><i>von: <xsl:value-of select="article/head/author/display_name"/></i><br/>
     veröffentlicht am: <xsl:value-of select="substring(article/head/attribute[@name='date_first_released'],1,10)"/></p>
   <xsl:apply-templates/>
   </body>
  </html>
</xsl:template>
<xsl:template match="attribute" />
<xsl:template match="rankedTags" />
<xsl:template match="author" />
<xsl:template match="subtitle"><p><i><xsl:copy-of select="."/></i></p></xsl:template>
<xsl:template match="byline" />
<xsl:template match="caption" />
<xsl:template match="image-credits" />
<xsl:template match="bu" />
<xsl:template match="teaser" />
<xsl:template match="title" />
<xsl:template match="copyright" />
<xsl:template match="division/image">
  <p>
    <img>
      <xsl:attribute name="src"><xsl:value-of select="./@base-id"/>wide__820x461__desktop</xsl:attribute>
      <xsl:attribute name="alt"><xsl:value-of select="./@alt_local"/></xsl:attribute>
    </img>
    <br />
    <span class="bildunterschrift"><xsl:value-of select="./@alt_local"/></span>
    <xsl:if test="copyright/text()">
      <br />
      <span class="copyright">© <xsl:value-of select="copyright"/></span>
    </xsl:if>
  </p>
</xsl:template>
<xsl:template match="intertitle"> <h3><xsl:copy-of select="."/></h3> </xsl:template>
<xsl:template match="supertitle"> <h2><xsl:copy-of select="."/></h2> </xsl:template>
<xsl:template match="p">
  <p>
    <xsl:copy-of select="."/>
  </p>
</xsl:template>
</xsl:stylesheet>
