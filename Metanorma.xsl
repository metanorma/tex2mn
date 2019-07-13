<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version   = "1.0"
  xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
  xmlns:ltx = "http://dlmf.nist.gov/LaTeXML"
  xmlns:str = "http://exslt.org/strings"
  extension-element-prefixes = "str"
  exclude-result-prefixes = "ltx str">

  <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

  <xsl:strip-space elements="*" />

  <xsl:template match="ltx:tags|ltx:title"/>

  <xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template> 

  <xsl:template match="ltx:section[ltx:title/text()='Foreword' or @heading='foreword' or @foreword]">
    <xsl:text>[[Foreword]]&#xA;</xsl:text>
    <xsl:value-of select="concat('.', ltx:title/text())"/>
    <xsl:apply-templates/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="term-extras">
    <xsl:for-each select="tokenize(@alternate, ',')">
      <xsl:value-of select="concat('alternate:[', ., ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:for-each>
    <xsl:for-each select="tokenize(@deprecated, ',')">
      <xsl:value-of select="concat('deprecated:[', ., ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:for-each>
    <xsl:if test="@domain">
      <xsl:value-of select="concat('domain:[', @domain, ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="newline">
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <!--
    Sectioning
  -->

  <xsl:template name="heading">
    <xsl:param name="depth"/>

    <xsl:call-template name="newline"/>
    <xsl:call-template name="heading-attributes"/>

    <xsl:choose>
      <xsl:when test="ltx:title/text()!=''">
        <xsl:value-of select="concat($depth, ' ', ltx:title/text())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($depth, ' ', '{blank}')"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:call-template name="newline"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template name="heading-attributes">
    <xsl:if test="@asciidoc-attributes">
      <xsl:value-of select="concat('[', @asciidoc-attributes, ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:section">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'=='" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ltx:subsection">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'==='" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ltx:subsubsection">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'===='" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ltx:paragraph">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'====='" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="ltx:subparagraph">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'======'" />
    </xsl:call-template>
  </xsl:template>

  <!--
    Text formatting
  -->

  <xsl:template match="ltx:text[@font='bold']">**<xsl:apply-templates/>**</xsl:template>
  <xsl:template match="ltx:text[@font='italic']">__<xsl:apply-templates/>__</xsl:template>
  <xsl:template match="ltx:text[@font='smallcaps']">[smallcap]#<xsl:apply-templates/>#</xsl:template>
  <xsl:template match="ltx:text[@class='strikethrough']">[strike]#<xsl:apply-templates/>#</xsl:template>

  <!--
    Paragraphs and their alignment
  -->

  <xsl:template name="paragraph-alignment">
    <xsl:if test="../@align"> <!-- NOTE: parent is expected to be ltx:para -->
      <xsl:value-of select="concat('[align=', ../@align, ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="//ltx:para/ltx:p">
    <xsl:call-template name="newline"/>
    <xsl:call-template name="paragraph-alignment"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <!--
    Quotes
  -->

  <xsl:template name="quote-attributes">
    <xsl:choose>
      <xsl:when test="@asciidoc-attributes">
        <xsl:value-of select="concat('[quote,', @asciidoc-attributes, ']')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[quote]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="quote-delimiter">
    <xsl:text>&#xa;-----&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="ltx:quote">
    <xsl:call-template name="newline"/>
    <xsl:call-template name="quote-attributes"/>
    <xsl:call-template name="quote-delimiter"/>
    <xsl:apply-templates/>
    <xsl:call-template name="quote-delimiter"/>
  </xsl:template>

</xsl:stylesheet>