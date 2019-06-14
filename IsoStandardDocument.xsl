<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version   = "1.0"
  xmlns = "http://riboseinc.com/isoxml"
  xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
  xmlns:ltx = "http://dlmf.nist.gov/LaTeXML"
  exclude-result-prefixes = "ltx">

<xsl:output
  method = "xml"
  encoding = "UTF-8"/>

  <!-- remove latexml processing instructions -->
  <xsl:template match="/processing-instruction('latexml')">
    <xsl:apply-templates select="*"/>
  </xsl:template> 

  <!-- identity -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template> 

  <!-- unwrap children of paras (which should be a single p) -->
  <xsl:template match="ltx:para">
    <xsl:apply-templates select="*"/>
  </xsl:template>

  <!-- insert content of ps -->
  <xsl:template match="ltx:p">
    <p><xsl:apply-templates select="node()"/></p>
  </xsl:template>

  <!-- get text of titles (discards numbering tags)  -->
  <xsl:template match="ltx:title">
    <title><xsl:apply-templates select="text()"/></title>
  </xsl:template>

  <xsl:template match="ltx:section">
    <clause>
      <xsl:apply-templates select="ltx:title|ltx:para"/>
    </clause>
  </xsl:template>

  <xsl:template match="ltx:section[ltx:title/text()='Foreword' or @heading='foreword' or @foreword]">
    <foreword>
      <xsl:apply-templates select="ltx:title|ltx:para"/>
    </foreword>
  </xsl:template>

  <xsl:template match="ltx:document">
    <iso-standard>
      <!-- all sections preceding and excluding the first numbered one are grouped in the preface -->
      <preface>
        <xsl:for-each select="(ltx:section[@inlist])[1]/preceding-sibling::ltx:section">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </preface>
      <!-- all sections following and including the first numbered one are grouped as clauses -->
      <sections>
        <!-- NOTE: unnumbered sections following the first numbered one are just suppressed -->
        <xsl:for-each select="ltx:section[@inlist]">
          <xsl:apply-templates select="."/>
        </xsl:for-each>
      </sections>
    </iso-standard>
  </xsl:template>

</xsl:stylesheet>