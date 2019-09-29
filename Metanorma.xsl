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

  <!-- <xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template>  -->

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
    <!-- optional attributes tag -->
    <xsl:if test="@asciidoc-attributes">
      <xsl:value-of select="concat('[', @asciidoc-attributes, ']')"/>
      <xsl:call-template name="newline"/>
    </xsl:if>
    <!-- heading command -->
    <xsl:choose>
      <xsl:when test="ltx:title/text()!=''">
        <xsl:value-of select="concat($depth, ' ', ltx:title/text())"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat($depth, ' ', '{blank}')"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:call-template name="newline"/>
    <!-- blank line -->
    <xsl:call-template name="newline"/>
    <!-- contents -->
    <xsl:apply-templates/>
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

  <xsl:template match="ltx:para">
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:para/ltx:p">
    <xsl:call-template name="paragraph-alignment"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/> <!-- this is the trailing newline of the last line -->
    <xsl:if test="current()[following-sibling::*]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <!--
    Quotes
  -->

  <xsl:template name="quote-attributes">
    <xsl:choose>
      <xsl:when test="@asciidoc-attributes">
        <xsl:value-of select="concat('[quote,', @asciidoc-attributes, ']&#xa;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[quote]&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="quote-delimiter">
    <xsl:text>-----&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="ltx:quote">
    <xsl:call-template name="quote-attributes"/>
    <xsl:call-template name="quote-delimiter"/>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
    <xsl:call-template name="quote-delimiter"/>
    <!-- TODO: should a blank line be here? -->
  </xsl:template>

  <!--
    Admonitions
  -->

  <xsl:template name="admonition-delimiter">
    <xsl:text>====&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="//ltx:para[starts-with(@class, 'admonition--')]">
    <xsl:value-of select="concat('[', translate(substring(@class, 13), $lowercase, $uppercase), ']&#xa;')"/>
    <xsl:call-template name="admonition-delimiter"/>
    <xsl:apply-templates/>
    <xsl:call-template name="admonition-delimiter"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <!--
    Footnotes
  -->

  <xsl:template match="ltx:note">
    <xsl:value-of select="concat(' footnote:[', text(), ']')"/>
  </xsl:template>

  <!--
    Hard line breaks (in paragraphs)
  -->

  <xsl:template match="ltx:p/ltx:break">
    <xsl:text> +&#xa;</xsl:text>
  </xsl:template>

  <!--
    Lists (arbitrarily nested, w/ line breaks and paragraphs)
  -->

  <xsl:template name="list__continuation_marker">
    <xsl:text>+&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="ltx:item/ltx:para/ltx:p">
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/> <!-- this is the trailing newline of the last line -->
  </xsl:template>

  <!-- Unordered lists -->

  <xsl:template name="list--unordered__item_depth_marker">
    <xsl:for-each select="ancestor-or-self::ltx:itemize">*</xsl:for-each>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ltx:itemize/ltx:item/ltx:para[not(preceding-sibling::ltx:para)]">
    <xsl:call-template name="list--unordered__item_depth_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:itemize/ltx:item/ltx:para[preceding-sibling::ltx:para]">
    <xsl:call-template name="list__continuation_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Ordered lists -->

  <xsl:template name="list--ordered__item_depth_marker">
    <xsl:for-each select="ancestor-or-self::ltx:enumerate">.</xsl:for-each>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ltx:enumerate/ltx:item/ltx:para[not(preceding-sibling::ltx:para)]">
    <xsl:call-template name="list--ordered__item_depth_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:enumerate/ltx:item/ltx:para[preceding-sibling::ltx:para]">
    <xsl:call-template name="list__continuation_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!--
    Figures
  -->

  <xsl:template match="ltx:figure">
    <xsl:if test="@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(@labels, ' '), ' '), ':'), ']]&#xa;')"/>
    </xsl:if>
    <xsl:if test="not(@labels)">
      <!-- TODO: drop this unless it's required by asciidoc -->
      <xsl:value-of select="concat('[[', @xml:id, ']]&#xa;')"/>
    </xsl:if>
    <xsl:apply-templates select="ltx:caption"/>
    <xsl:apply-templates select="ltx:graphics"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:figure/ltx:graphics">
    <!-- TODO: we could use the caption as alt text, perhaps? -->
    <xsl:value-of select="concat('image::', @graphic, '[]&#xa;')"/>
  </xsl:template>

  <xsl:template match="ltx:figure/ltx:caption/ltx:tag"/>
  <xsl:template match="ltx:figure/ltx:caption">
    <xsl:value-of select="concat('.', text(), '&#xa;')"/>
  </xsl:template>

  <!--
    Math
  -->

  <xsl:template match="ltx:equation">
    <xsl:if test="@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(@labels, ' '), ' '), ':'), ']]&#xa;')"/>
    </xsl:if>
    <!-- TODO: should distinction between environments be stricter? -->
    <!-- equation, gather -->
    <xsl:apply-templates select="ltx:Math"/>
    <!-- align -->
    <xsl:apply-templates select="ltx:MathFork/ltx:Math"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:Math[@mode='inline']">
    <xsl:value-of select="concat('stem:[', @tex, ']')"/>
  </xsl:template>

  <xsl:template match="ltx:Math[not(@mode) or @mode='display']">
    <xsl:text>[stem]&#xa;</xsl:text>
    <xsl:text>++++&#xa;</xsl:text>
    <xsl:value-of select="@tex"/>
    <xsl:text>&#xa;++++&#xa;</xsl:text>
  </xsl:template>

  <!--
    Tables
  -->

  <xsl:template match="ltx:table">
    <xsl:if test="@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(@labels, ' '), ' '), ':'), ']]&#xa;')"/>
    </xsl:if>
    <xsl:apply-templates select="ltx:caption"/>
    <xsl:apply-templates select="ltx:tabular"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:table/ltx:caption/ltx:tag"/>
  <xsl:template match="ltx:table/ltx:caption">
    <xsl:value-of select="concat('.', text(), '&#xa;')"/>
  </xsl:template>

  <xsl:template match="ltx:tabular">
    <xsl:value-of select="concat('[cols=', count(ltx:tbody/ltx:tr[1]/ltx:td), '*]&#xa;')"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:tbody">
    <xsl:text>|===&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>|===&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="ltx:tr">
    <xsl:apply-templates/>
    <xsl:if test="current()[following-sibling::*]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:td">
    <xsl:text>| </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>


  <!--
    Utilities
  -->

  <!-- XSL 2.0 has upper-case() but we must use translate() with XSL 1.0  -->
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

</xsl:stylesheet>