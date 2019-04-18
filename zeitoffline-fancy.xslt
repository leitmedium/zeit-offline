<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="article/body/title"/>
                </title>
                <meta content="width=device-width, initial-scale=1" name="viewport"/>
            </head>
            <style type="text/css">
                body {
                display: flex;
                justify-content: center;
                font-family: "Palatino Linotype", "Book Antiqua", Palatino, serif
                }
                .container {
                margin: 10px;
                }
                @media (min-width: 900px) {
                .container {
                max-width: 50vw;
                }
                }
                h1, h2, h3, .sans {
                font-family: Roboto, Helvetica, Arial, sans-serif;
                }
                img {
                padding-bottom: 5px;
                max-width: 50vw;
                width: 100%;
                }
                .meta {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                font-size: 10pt;
                color: grey;
                }
                .meta * {
                margin: 0 5px;
                }
                .meta:first-child {
                margin-left: 0;
                }
                .meta:last-child {
                margin-right: 0;
                }
                span.bildunterschrift { font-size: small; }
                span.copyright { font-size:x-small; }
                p {
                text-align: justify;
                }
            </style>
            <body>
                <div class="container">
                    <h1>
                        <xsl:value-of select="article/body/title"/>
                    </h1>
                    <div class="sans meta">
                        <i>von:
                            <xsl:value-of select="article/head/author/display_name"/>
                        </i>
                        <span>veröffentlicht am:
                            <xsl:value-of select="substring(article/head/attribute[@name='date_first_released'],1,10)"/>
                        </span>
                        <xsl:if test="count(article/head/rankedTags/tag[@type='location']) > 0">
                            <span>
                                Ort:
                                <xsl:for-each select="article/head/rankedTags/tag[@type='location']">
                                    <xsl:copy-of select="."/><xsl:if test="position() &lt; last()">,</xsl:if>
                                </xsl:for-each>
                            </span>
                        </xsl:if>
                        <xsl:if test="count(article/head/rankedTags/tag[@type='keyword']) > 0">
                            <span>
                                Schlüsselwörter:
                                <xsl:for-each select="article/head/rankedTags/tag[@type='keyword']">
                                    <xsl:copy-of select="."/>
                                    <xsl:if test="position() &lt; last()">,</xsl:if>
                                </xsl:for-each>
                            </span>
                        </xsl:if>
                    </div>
                    <xsl:apply-templates/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="attribute"/>
    <xsl:template match="rankedTags"/>
    <xsl:template match="author"/>
    <xsl:template match="subtitle">
        <p class="sans">
            <i>
                <xsl:copy-of select="."/>
            </i>
        </p>
    </xsl:template>
    <xsl:template match="byline"/>
    <xsl:template match="caption"/>
    <xsl:template match="image-credits"/>
    <xsl:template match="bu"/>
    <xsl:template match="teaser"/>
    <xsl:template match="title"/>
    <xsl:template match="copyright"/>
    <xsl:template match="division/image">
        <xsl:if test="./@base-id">
            <p>
                <img>
                    <xsl:attribute name="src"><xsl:value-of select="./@base-id"/>wide__820x461__desktop</xsl:attribute>
                    <xsl:attribute name="alt">
                        <xsl:value-of select="./@alt_local"/>
                    </xsl:attribute>
                </img>
                <span class="bildunterschrift sans">
                    <xsl:value-of select="./@caption_local"/>
                </span>
                <xsl:if test="copyright/text()">
                    <br/>
                    <span class="copyright sans">©
                        <xsl:value-of select="copyright"/>
                    </span>
                </xsl:if>
            </p>
        </xsl:if>
    </xsl:template>
    <xsl:template match="intertitle">
        <h3>
            <xsl:copy-of select="."/>
        </h3>
    </xsl:template>
    <xsl:template match="supertitle">
        <h2>
            <xsl:copy-of select="."/>
        </h2>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:copy-of select="."/>
        </p>
    </xsl:template>
</xsl:stylesheet>
