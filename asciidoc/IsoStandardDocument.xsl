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

  <xsl:template match="/processing-instruction('latexml')"/>

  <xsl:template match="ltx:tags|ltx:title"/>

  <!-- <xsl:strip-space elements="*"/> -->

  <xsl:template match="@*|node()">
<xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template> 

  <xsl:template match="ltx:para">
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates select="*"/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="//ltx:p">
    <xsl:apply-templates select="node()"/>
  </xsl:template>

  <xsl:template match="ltx:section[ltx:title/text()='Foreword' or @heading='foreword' or @foreword]">
    <xsl:text>[[Foreword]]&#xA;</xsl:text>
    <xsl:value-of select="concat('.', ltx:title/text())"/>
    <xsl:apply-templates/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template name="heading">
    <xsl:param name="depth"/>
    <xsl:choose>
      <xsl:when test="ltx:title/text()!=''">
        <xsl:value-of select="concat($depth, ltx:title/text())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($depth, ' {blank}')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="newline">
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>


  <xsl:template match="ltx:section">
    <xsl:call-template name="newline"/>
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'=='" />
    </xsl:call-template>
    <xsl:call-template name="newline"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:subsection">
    <xsl:call-template name="newline"/>
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'==='" />
    </xsl:call-template>
    <xsl:call-template name="newline"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:document">
    <deleteme/>
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <!--



  <xsl:template match="ltx:title">
    <xsl:if test="text()">
      <title><xsl:apply-templates select="text()"/></title>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:section|ltx:subsection">
    <clause>
      <xsl:copy-of select="@obligation"/>
      <preferred><xsl:value-of select="ltx:title/text()"/></preferred>
      <xsl:for-each select="str:tokenize(@alternate, ',')">
        <alternate><xsl:value-of select="."/></alternate>
      </xsl:for-each>
      <xsl:for-each select="str:tokenize(@deprecated, ',')">
        <deprecated><xsl:value-of select="."/></deprecated>
      </xsl:for-each>
      <xsl:if test="@domain">
        <domain><xsl:value-of select="@domain"/></domain>
      </xsl:if>
      <xsl:apply-templates/>
    </clause>
  </xsl:template>


  <xsl:template match="ltx:section[ltx:title/text()='Abstract' or @heading='abstract' or @abstract]">
    <abstract>
      <xsl:attribute name="obligation">informative</xsl:attribute>
      <xsl:apply-templates/>
    </abstract>
  </xsl:template>

  <xsl:template match="ltx:section[ltx:title/text()='Introduction' or @heading='introduction' or @introduction]">
    <introduction>
      <xsl:attribute name="obligation">informative</xsl:attribute>
      <xsl:apply-templates/>
    </introduction>
  </xsl:template>

  <xsl:template match="ltx:section[ltx:title/text()='Terms and definitions' or @heading='terms and definitions' or @termsanddefinitions]">
    <terms>
      <xsl:attribute name="obligation">normative</xsl:attribute>
      <xsl:apply-templates/>
    </terms>
  </xsl:template>

  <xsl:template match="ltx:section[ltx:title/text()='Normative references' or @heading='normative references' or @normativereferences]">
    <references>
      <xsl:attribute name="obligation">informative</xsl:attribute>
      <xsl:apply-templates/>
    </references>
  </xsl:template>

  <xsl:template match="ltx:document">
    <xsl:for-each select="(ltx:section[@inlist])[1]/preceding-sibling::ltx:section">
      <xsl:apply-templates select="."/>
    </xsl:for-each>
    <sections>
      <xsl:for-each select="ltx:section[@inlist]">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </sections>
  </xsl:template> -->

</xsl:stylesheet>