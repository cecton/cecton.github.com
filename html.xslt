<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8"/>
  <!-- doctype-system="http://www.w3.org/TR/html4/strict.dtd" doctype-public="-//W3C//DTD HTML 4.01//EN" -->

  <xsl:template match="cv">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#x0a;</xsl:text>
    <html>
      <head>
        <xsl:if test="@css">
          <link rel="stylesheet" type="text/css" href="{@css}"/>
        </xsl:if>
        <xsl:if test="@icon">
          <link rel="shortcut icon" href="{@icon}"/>
        </xsl:if>
        <title><xsl:value-of select="title/@name"/></title>
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"/> -->
      </head>
      <body>
        <div id="pdf"><a href="{@pdf}"><img src="128px-Adobe_PDF.svg.png" alt="pdf" title="Get the PDF version of this CV"/></a></div>
        <div id="page">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="cv/title">
    <div class="title">
      <h1><xsl:value-of select="@name"/></h1>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cv/title/subtitle">
    <div class="subtitle">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cv/title/subtitle/line">
    <div class="line"><xsl:value-of select="text()"/></div>
  </xsl:template>

  <xsl:template match="cv/word">
    <div class="word"><xsl:value-of select="text()"/></div>
  </xsl:template>

  <xsl:template match="cv//section">
    <div class="section {@class}">
      <h2>
        <xsl:value-of select="@title"/>
        <xsl:if test="@small">
          <xsl:text> </xsl:text><span class="small"><xsl:value-of select="@small"/></span>
        </xsl:if>
        <xsl:if test="@description">
          <span class="description">&#xa0;<span><xsl:value-of select="@description"/></span></span>
        </xsl:if>
      </h2>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cv//subsection">
    <div class="subsection">
      <h3>
        <xsl:value-of select="@title"/>
        <xsl:if test="@small">
          <xsl:text> </xsl:text><span class="small"><xsl:value-of select="@small"/></span>
        </xsl:if>
        <xsl:if test="@description">
          <span class="description">&#xa0;<span><xsl:value-of select="@description"/></span></span>
        </xsl:if>
      </h3>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="cv//text">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="cv//columns">
    <div class="columns"><xsl:apply-templates/></div>
  </xsl:template>

  <xsl:template match="cv//abilities">
    <dl><xsl:apply-templates/></dl>
  </xsl:template>

  <xsl:template match="abilities/label">
    <dt><xsl:apply-templates/></dt>
  </xsl:template>

  <xsl:template match="abilities/ability">
    <dd><xsl:apply-templates/></dd>
  </xsl:template>

  <xsl:template match="cv//card">
    <div class="card"><div class="inner">
      <div class="contact">
        <p><strong>
          <xsl:value-of select="concat(firstname,'&#xa0;',surname)"/>
          <xsl:if test="birth">
            <xsl:value-of select="concat(', ',birth)"/>
          </xsl:if>
          <xsl:text> &lt;</xsl:text>
          <a href="mailto:{email}"><xsl:value-of select="email"/></a>
          <xsl:text>&gt;</xsl:text>
        </strong></p>
        <xsl:apply-templates select="address|phone|mobile"/>
      </div>
      <xsl:apply-templates select="languages"/>
      <xsl:apply-templates select="note"/>
      <xsl:apply-templates select="links"/>
    </div></div>
  </xsl:template>

  <xsl:template match="card/address">
    <p>
      <a href="http://maps.google.com/maps?q={cp}+{city},+{country}" target="_blank">
        <xsl:if test="street">
          <xsl:value-of select="street"/><br/>
        </xsl:if>
        <xsl:value-of select="concat(cp,'&#xa0;',city)"/>
        <xsl:if test="country">
          <br/><xsl:value-of select="country"/>
        </xsl:if>
      </a>
    </p>
  </xsl:template>

  <xsl:template match="card/mobile">
    <p><span style="font-family: OpenSymbol;">&#xe3a9;</span>&#xa0;<xsl:value-of select="text()"/></p>
  </xsl:template>

  <xsl:template match="card/phone">
    <p><span style="font-family: OpenSymbol;">&#xe201;</span>&#xa0;<xsl:value-of select="text()"/></p>
  </xsl:template>

  <xsl:template match="card/languages">
    <div class="languages">
      <span class="pre"><xsl:value-of select="@pre"/></span>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="card/languages/language">
    <xsl:value-of select="concat(text(),'&#xa0;(',@level,')')"/>
    <xsl:if test="not(position()=last()-1)">
      <xsl:text>, </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template match="card/note">
    <div class="notes">
      <xsl:value-of select="text()"/>
    </div>
  </xsl:template>

  <xsl:template match="card/links">
    <div class="links">
      <xsl:apply-templates/>
    </div>
    <div class="website">
      <a href="{/cv/@website}">
        <xsl:value-of select="/cv/@website"/>
      </a>
    </div>
  </xsl:template>

  <xsl:template match="column">
    <div class="column">
      <ul>
        <xsl:apply-templates/>
      </ul>
    </div>
  </xsl:template>

  <xsl:template match="column/li">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <xsl:template match="column/a">
    <li><a href="{@href}" target="_blank"><xsl:value-of select="text()"/></a></li>
  </xsl:template>

  <xsl:template match="br"><br/></xsl:template>

  <xsl:template match="a">
    <a href="{@href}" target="_blank"><xsl:value-of select="text()"/></a>
  </xsl:template>

  <xsl:template match="sup">
    <sup><xsl:value-of select="text()"/></sup>
  </xsl:template>

</xsl:stylesheet>

<!--
  vim:ts=2:sw=2:expandtab
-->

