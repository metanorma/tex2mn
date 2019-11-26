<?xml version="1.0" encoding="utf-8"?>
<!--
  tex2mn 0.1.0 - converts Metanorma documents from LaTeX to AsciiDoc

  Copyright (C) 2019 Ribose Inc. <open.source@ribose.com>
  This project is available under the terms of the MIT License.
-->

<xsl:stylesheet
  version   = "1.0"
  xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
  xmlns:ltx = "http://dlmf.nist.gov/LaTeXML"
  xmlns:str = "http://exslt.org/strings"
  extension-element-prefixes = "str"
  exclude-result-prefixes = "ltx str">

  <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>

  <xsl:strip-space elements="*" />

  <xsl:template match="ltx:tags|ltx:title|ltx:toctitle"/>

  <!-- <xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template>  -->

  <!-- NOTE: it's apparently forbidden (by latexmlpost) to use a variable in a predicate -->
  <xsl:template match="ltx:section[translate(ltx:title/text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='foreword' or @asciidoc-attributes='heading=foreword']">
    <xsl:text>[[Foreword]]&#xA;</xsl:text>
    <xsl:value-of select="concat('.', ltx:title/text(), '&#xA;')"/>
    <xsl:apply-templates/>
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
    Document root
  -->

  <xsl:template match="/">
    <xsl:call-template name="document-title"/>
    <xsl:call-template name="document-attributes"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!--
    Document title
  -->

  <xsl:template name="document-title">
    <xsl:if test="ltx:document/ltx:title">
      <xsl:value-of select="concat('= ', ltx:document/ltx:title, '&#xA;')"/>
    </xsl:if>
  </xsl:template>

  <!--
    Document attributes
  -->

  <xsl:template name="document-attributes">
    <xsl:for-each select="ltx:document/ltx:rdf">
      <xsl:if test="@content">
        <xsl:value-of select="concat(':', @property, ': ', @content, '&#xA;')"/>
      </xsl:if>
      <xsl:if test="not(@content)">
        <xsl:value-of select="concat(':', @property, ':&#xA;')"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:if test="ltx:document/ltx:rdf">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:text[@content]">
    <xsl:value-of select="concat('{', @content, '}')"/>
  </xsl:template>

  <!--
    Sectioning
  -->

  <xsl:template name="heading">
    <xsl:param name="depth"/>
    <xsl:param name="extra"/>
    <!-- optional label -->
    <xsl:if test="@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(@labels, ' '), ' '), ':'), ']]&#xa;')"/>
    </xsl:if>
    <!-- optional attributes tag -->
    <xsl:choose>
      <xsl:when test="@asciidoc-attributes and $extra">
        <xsl:value-of select="concat('[', $extra, ',', @asciidoc-attributes, ']')"/>
        <xsl:call-template name="newline"/>
      </xsl:when>
      <xsl:when test="@asciidoc-attributes or $extra">
        <xsl:value-of select="concat('[', $extra, @asciidoc-attributes, ']')"/>
        <xsl:call-template name="newline"/>
      </xsl:when>
    </xsl:choose>
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

  <xsl:template match="ltx:appendix">
    <xsl:call-template name="heading">
      <xsl:with-param name="depth" select="'=='" />
      <xsl:with-param name="extra" select="'appendix'" />
    </xsl:call-template>
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

  <xsl:template match="ltx:p">
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
      <xsl:when test="./ltx:rdf[@property='asciidoc-attributes']">
        <xsl:value-of select="concat('[quote,', ./ltx:rdf/@content, ']&#xa;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>[quote]&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="quote-delimiter">
    <xsl:text>_____&#xa;</xsl:text>
  </xsl:template>

  <!-- <xsl:template match="ltx:quote"> -->
  <xsl:template match="ltx:*[@class='block-quote']" priority="1">
    <xsl:call-template name="quote-attributes"/>
    <xsl:call-template name="quote-delimiter"/>
    <xsl:apply-templates/><xsl:if test="name()='p'"><xsl:text>&#xa;</xsl:text></xsl:if>
    <xsl:call-template name="quote-delimiter"/>
    <!-- TODO: should a blank line be here? -->
  </xsl:template>

  <!--
    Admonitions
  -->

  <xsl:template name="admonition-delimiter">
    <xsl:text>====&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="//ltx:*[starts-with(@class, 'block-admonition--')]">
    <xsl:value-of select="concat('[', translate(substring(@class, 19), $lowercase, $uppercase), ']&#xa;')"/>
    <xsl:call-template name="admonition-delimiter"/>
    <xsl:apply-templates/><xsl:if test="name()='p'"><xsl:text>&#xa;</xsl:text></xsl:if>
    <xsl:call-template name="admonition-delimiter"/>
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

  <xsl:template name="list__item_label_marker">
    <xsl:if test="../@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(../@labels, ' '), ' '), ':'), ']] ')"/>
    </xsl:if>
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
    <xsl:call-template name="list__item_label_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:itemize/ltx:item/ltx:para[preceding-sibling::ltx:para]">
    <xsl:call-template name="list__continuation_marker"/>
    <xsl:call-template name="list__item_label_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Ordered lists -->

  <xsl:template name="list--ordered__item_depth_marker">
    <xsl:for-each select="ancestor-or-self::ltx:enumerate">.</xsl:for-each>
    <xsl:text> </xsl:text>
  </xsl:template>

  <xsl:template match="ltx:enumerate/ltx:item/ltx:para[not(preceding-sibling::ltx:para)]">
    <xsl:call-template name="list--ordered__item_depth_marker"/>
    <xsl:call-template name="list__item_label_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:enumerate/ltx:item/ltx:para[preceding-sibling::ltx:para]">
    <xsl:call-template name="list__continuation_marker"/>
    <xsl:call-template name="list__item_label_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Description lists -->

  <xsl:template match="ltx:description">
    <xsl:for-each select="ltx:item">
      <xsl:apply-templates select="ltx:tags/ltx:tag[not(@role)]"/>
      <xsl:text>:</xsl:text>
      <xsl:for-each select="ancestor-or-self::ltx:description">:</xsl:for-each>
      <xsl:text>&#xa;</xsl:text>
      <xsl:apply-templates/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="ltx:description/ltx:item/ltx:para[not(preceding-sibling::ltx:para)]">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="ltx:description/ltx:item/ltx:para[preceding-sibling::ltx:para]">
    <xsl:call-template name="list__continuation_marker"/>
    <xsl:apply-templates/>
  </xsl:template>

  <!--
    Figures
  -->

  <xsl:template name="figure__label">
    <xsl:if test="@labels">
      <!-- NOTE: latexml lists and prefixes labels as "LABEL:lab1 LABEL:lab2" so we take the first one and drop the prefix -->
      <xsl:value-of select="concat('[[', substring-after(substring-before(concat(@labels, ' '), ' '), ':'), ']]&#xa;')"/>
    </xsl:if>
    <xsl:if test="not(@labels)">
      <!-- TODO: drop this unless it's required by asciidoc -->
      <xsl:value-of select="concat('[[', @xml:id, ']]&#xa;')"/>
    </xsl:if>
  </xsl:template>

  <!-- NOTE: this matches only parent of composite figures -->
  <xsl:template match="ltx:figure[./ltx:figure]">
    <xsl:call-template name="figure__label"/>
    <xsl:apply-templates select="ltx:caption"/>
    <xsl:text>====&#xa;</xsl:text>
    <xsl:apply-templates select="ltx:figure"/>
    <xsl:text>====&#xa;</xsl:text>
    <xsl:call-template name="newline"/>
    <xsl:apply-templates select="ltx:paragraph"/>
  </xsl:template>

  <!-- NOTE: this matches either simple figures or children of composite figures -->
  <xsl:template match="ltx:figure[not(./ltx:figure)]">
    <xsl:call-template name="figure__label"/>
    <xsl:apply-templates select="ltx:caption"/>
    <xsl:apply-templates select="ltx:graphics"/>
    <xsl:call-template name="newline"/>
    <xsl:apply-templates select="ltx:paragraph"/>
  </xsl:template>

  <xsl:template match="ltx:figure/ltx:graphics">
    <!-- TODO: we could use the caption as alt text, perhaps? -->
    <xsl:value-of select="concat('image::', @graphic, '[]&#xa;')"/>
  </xsl:template>

  <xsl:template match="ltx:figure/ltx:caption/ltx:tag"/>
  <!-- NOTE: is it correct to assume there's only one ltx:tex inside the caption? -->
  <xsl:template match="ltx:figure/ltx:caption/ltx:text">
    <xsl:value-of select="concat('.', text(), '&#xa;')"/>
  </xsl:template>

  <!-- NOTE: we're assuming the only paragraph inside an figure will be the key -->
  <xsl:template match="ltx:figure/ltx:paragraph">
    <xsl:value-of select="concat('*', ltx:title, '*&#xa;')"/>
    <xsl:call-template name="newline"/>
    <xsl:apply-templates select="ltx:para/ltx:description"/>
    <xsl:call-template name="newline"/>
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
  <!-- NOTE: is it correct to assume there's only one ltx:tex inside the caption? -->
  <xsl:template match="ltx:table/ltx:caption/ltx:text">
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
    Links
  -->

  <xsl:template match="ltx:ref[@href]">
    <!-- NOTE: to handle *anything* a user might throw at us, we use the explicit link macro -->
    <xsl:choose>
      <xsl:when test="@href!=node()">
        <xsl:value-of select="concat('link:++', @href, '++', '[', node(), ']')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('link:++', @href, '++', '[]')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--
    Cross references
  -->

  <xsl:template match="ltx:ref[@labelref]">
    <xsl:choose>
      <!-- NOTE: by default (disabled with nocrossref) latexmk would add a child text node containing @labelref so we couldn't choose here -->
      <xsl:when test="node()">
        <xsl:value-of select="concat('&lt;&lt;', substring-after(@labelref, ':'), ', ', text(), '&gt;&gt;')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('&lt;&lt;', substring-after(@labelref, ':'), '&gt;&gt;')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--
    Blocks
  -->

  <!-- NOTE: we expect to match only p, block and inline-block but use priority to simplify the XSL -->
  <xsl:template match="ltx:*[starts-with(@class, 'block-example--')]" priority="1">
    <xsl:value-of select="concat('[.', substring-after(@class, 'block-example--'), ']&#xa;')"/>
    <xsl:call-template name="block--example__delimiter"/>
    <!-- NOTE: if we matched a p we need an extra line termination -->
    <xsl:apply-templates/><xsl:if test="name()='p'"><xsl:text>&#xa;</xsl:text></xsl:if>
    <xsl:call-template name="block--example__delimiter"/>
    <xsl:if test="current()[following-sibling::*]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="block--example__delimiter">
    <!-- NOTE: we add a = for each nesting level -->
    <xsl:for-each select="ancestor::ltx:*[starts-with(@class, 'block-example--')]">=</xsl:for-each>
    <xsl:text>====&#xa;</xsl:text>
  </xsl:template>

  <!-- NOTE: we expect to match only p, block and inline-block but use priority to simplify the XSL -->
  <xsl:template match="ltx:*[starts-with(@class, 'block-open--')]" priority="1">
    <xsl:value-of select="concat('[.', substring-after(@class, 'block-open--'), ']&#xa;')"/>
    <xsl:call-template name="block--open__delimiter"/>
    <xsl:apply-templates/>
    <xsl:text>&#xa;</xsl:text>
    <xsl:call-template name="block--open__delimiter"/>
    <xsl:if test="current()[following-sibling::*]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="block--open__delimiter">
    <xsl:text>--&#xa;</xsl:text>
  </xsl:template>

  <!--
    Terms and Definitions
  -->

  <xsl:template match="ltx:*[@class='block-example']" priority="1">
    <xsl:text>[example]&#xa;</xsl:text>
    <xsl:call-template name="block--example__delimiter"/>
    <!-- NOTE: if we matched a p we need an extra line termination -->
    <xsl:apply-templates/><xsl:if test="name()='p'"><xsl:text>&#xa;</xsl:text></xsl:if>
    <xsl:call-template name="block--example__delimiter"/>
    <xsl:if test="current()[following-sibling::*]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="ltx:para[@class='source']">
    <xsl:text>[.source]&#xa;</xsl:text>
    <xsl:apply-templates/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <xsl:template match="ltx:rdf[@property='alt' or @property='deprecated' or @property='domain']">
    <xsl:value-of select="concat(@property, ':[', @content, ']&#xA;')"/>
    <xsl:if test="current()[not(following-sibling::ltx:rdf)]">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>

  <!--
    Bibliography
  -->

  <xsl:template match="ltx:cite">
    <xsl:for-each select="str:tokenize(./ltx:bibref/@bibrefs, ',')">
      <xsl:value-of select="concat('&lt;&lt;', ., '&gt;&gt;')"/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="ltx:bibliography/ltx:title">
    <xsl:text>[bibliography]&#xa;</xsl:text>
    <xsl:value-of select="concat('== ', ., '&#xa;')"/>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <!-- NOTE: this matches embedded bibliographies written by the user -->
  <xsl:template match="ltx:bibliography[not(@files)]/ltx:biblist">
    <xsl:for-each select="ltx:bibitem">
      <xsl:text>* </xsl:text>
      <!-- NOTE: remember that position() should be equivalent to refnum if no label is given -->
      <xsl:value-of select="concat('[[[', @key, ',', ./ltx:tags/ltx:tag[@role='refnum'], ']]]')"/>
      <!-- NOTE: embedded bibliographic entries produce one bibblock each -->
      <xsl:apply-templates match="ltx:bibblock"/>
      <xsl:text>&#xa;</xsl:text>
      <!-- <xsl:if test="string-length(substring(node(), 1, 1))!='&#xa;'"><xsl:text>&#xa;</xsl:text></xsl:if> -->
    </xsl:for-each>
    <xsl:call-template name="newline"/>
  </xsl:template>

  <!-- NOTE: this matches BibTeX bibliographies generated by the MakeBibliography preprocessor -->
  <xsl:template match="ltx:bibliography[@files]/ltx:biblist">
    <xsl:for-each select="ltx:bibitem">
      <xsl:text>* </xsl:text>
      <!-- NOTE: remember that position() should be equivalent to refnum if no label is given -->
      <xsl:value-of select="concat('[[[', @key, ',', ./ltx:tags/ltx:tag[@role='refnum'], ']]]', '&#xa;')"/>
      <!-- NOTE: [not(contains(@class, 'ltx_bib_cited'))] skips the "Cited by" block which we aren't handling -->
      <xsl:for-each select="ltx:bibblock[not(contains(@class, 'ltx_bib_cited'))]">
        <!-- NOTE: instead of handling whitespace through concatenation we just break the line -->
        <!-- NOTE: this intercepts blocks beginning with an initial (e.g. "A. Einstein") and prepends a {blank} to avoid generating a spurious list -->
        <xsl:if test="string-length(substring-before(node(), '. '))=1"><xsl:text>{blank}</xsl:text></xsl:if>
        <xsl:apply-templates/>
        <xsl:text>&#xa;</xsl:text>
      </xsl:for-each>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <!--
    Utilities
  -->

  <!-- XSL 2.0 has upper-case() but we must use translate() with XSL 1.0  -->
  <xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
  <xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

</xsl:stylesheet>