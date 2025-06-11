<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
  <xsl:decimal-format name="nb-no-space" decimal-separator="," grouping-separator=" " NaN=" "/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:call-template name="overskrift"/>
        </title>
        <style type="text/css">
          .hoved-overskrift {
            font-size: 48px;
            color: #000000
          }

          .finansieringsbekreftelse-overskrift {
            font-size: 40px;
            color: #000000
          }

          .rolleoverskrift {
            font-weight: 500;
            color: #255473
          }

          .seksjonsoverskrift {
            font-weight: 700;
            font-size: 30px;
            color: #000000;
            padding-bottom: 18px
          }

          .underseksjonsoverskrift {
            font-weight: 500;
            font-size: 27px;
            color: #000000;
            padding-bottom: 6px;
            padding-top: 16px;
          }

          .rolleoverskrift {
            padding-top: 8px
          }

          .listeelement {
            font-weight: 400;
            padding-bottom: 4px
          }

          .innhold {
            padding-left: 8px
          }

          body {
            margin: 0;
            padding: 0;
            height: 100%
          }

          .hovedseksjon {
            padding-left: 10px;
            margin-bottom: 20px
          }

          .innrykk {
            padding-left: 10px;
          }

          #container {
            min-height: 100%;
            position: relative;
            margin: 10px;
            font-family: helvetica;
            max-width: 210mm
          }

          #header {
            padding-left: 5px;
            padding-top: 1px;
            padding-bottom: 1px
          }

          #body {
            padding-top: 10px;
            padding-bottom: 50px;
            widht: 100%
          }

          #footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 50px;
            background: #BDCBBD!important;
            text-align: center
          }

          .tabell {
            display: table;
            padding-bottom: 4px;
            width: 100%;
            table-layout: fixed
          }

          .rad {
            display: table-row
          }

          .celle,
          .divTableHead {
            border: 0;
            display: table-cell;
            padding: 1px
          }

          .kropp {
            display: table-row-group
          }

          .kol1 {
            min-width: 80px;
            width: 350px
          }

          .kol2 {
            width: 120px
          }

          .headerrad {
            color: grey;
            font-size: 11px
          }

          .kommentar {
            color: grey;
            font-size: 10px;
            font-style: italic;
          }

          .tall {
            text-align:right;
          }
          
          .right {
            text-align:right;
          }

          .status {
            font-weight: bold;
            padding: 5px;
            border-radius: 3px;
          }

          .status-approved {
            background-color: #90EE90;
          }

          .status-disapproved {
            background-color: #FFB6C1;
          }

          .status-other {
            background-color: #FFD700;
          }
        </style>
      </head>
      <body>
        <div id="container">
          <div id="header">
            <h1 class="hoved-overskrift">
              <xsl:call-template name="overskrift"/>
            </h1>
            <hr/>
            <xsl:call-template name="footerForH2"/>
          </div>
          <div id="body">
            <xsl:apply-templates select="finansieringsbekreftelseResponse/finansieringsbekreftelse"/>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="overskrift">
    <xsl:text>Finansieringsbekreftelse</xsl:text>
  </xsl:template>

  <xsl:template match="finansieringsbekreftelse">
    <h2 class="finansieringsbekreftelse-overskrift">
      <xsl:text>Finansieringsbekreftelse</xsl:text>
    </h2>
    <hr/>

    <xsl:call-template name="status"/>
    <xsl:call-template name="budinformasjon"/>
    <xsl:call-template name="salgsobjekt"/>
    <xsl:call-template name="megler"/>
    <xsl:call-template name="bank"/>

    <xsl:if test="lenkeTilSalgsoppgave">
      <xsl:call-template name="salgsoppgave">
        <xsl:with-param name="lenkeTilSalgsoppgave" select="lenkeTilSalgsoppgave"/>
      </xsl:call-template>
    </xsl:if>

    <xsl:call-template name="ressurser"/>

    <div style="padding-bottom:16px;">
      <hr/>
    </div>
  </xsl:template>

  <xsl:template name="status">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Status'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <span class="status status-{translate(status, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')}">
              <xsl:value-of select="status"/>
            </span>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="budinformasjon">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Budinformasjon'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">Budbeløp:</div>
          <div class="celle kol2 tall">
            <xsl:value-of select="format-number(Budinformasjon/budbelop, '# ##0,00', 'nb-no-space')"/> kr
          </div>
        </div>
        <div class="rad">
          <div class="celle kol1">Akseptfrist:</div>
          <div class="celle kol2">
            <xsl:value-of select="Budinformasjon/akseptfrist"/>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="salgsobjekt">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Salgsobjekt'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <xsl:apply-templates select="salgsobjekt"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="megler">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Megler'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:call-template name="organisasjon">
              <xsl:with-param name="organisasjon" select="megler"/>
            </xsl:call-template>
          </div>
          <div class="celle">
            <xsl:if test="megler/referanse">Referanse:&#x20;<xsl:value-of select="megler/referanse"/></xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="bank">
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Bank'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <xsl:call-template name="organisasjon">
              <xsl:with-param name="organisasjon" select="bank"/>
            </xsl:call-template>
          </div>
          <div class="celle">
            <xsl:if test="bank/referanse">Referanse:&#x20;<xsl:value-of select="bank/referanse"/></xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="salgsoppgave">
    <xsl:param name="lenkeTilSalgsoppgave"/>
    <div class="hovedseksjon">
      <xsl:call-template name="seksjon">
        <xsl:with-param name="tittel" select="'Salgsoppgave'"/>
      </xsl:call-template>
      <div class="tabell innhold">
        <div class="rad">
          <div class="celle kol1">
            <a href="{$lenkeTilSalgsoppgave}">Lenke til salgsoppgave</a>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="ressurser">
    <xsl:if test="metadata/ressurser/vedlegg">
      <div class="hovedseksjon">
        <xsl:call-template name="seksjon">
          <xsl:with-param name="tittel" select="'Vedlegg'"/>
        </xsl:call-template>
        <div class="tabell innhold">
          <xsl:for-each select="metadata/ressurser/vedlegg">
            <div class="rad">
              <div class="celle kol1">
                <xsl:value-of select="navn"/>
                <xsl:if test="beskrivelse">
                  <span class="kommentar">&#x20;(<xsl:value-of select="beskrivelse"/>)</span>
                </xsl:if>
              </div>
            </div>
          </xsl:for-each>
        </div>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="seksjon">
    <xsl:param name="tittel"/>
    <h3 class="seksjonsoverskrift">
      <xsl:value-of select="$tittel"/>
    </h3>
  </xsl:template>

  <xsl:template name="organisasjon">
    <xsl:param name="organisasjon"/>
    <xsl:value-of select="$organisasjon/foretaksnavn"/>
    <xsl:if test="$organisasjon/adresse">
      <br/>
      <xsl:value-of select="$organisasjon/adresse/gatenavn"/>
      <br/>
      <xsl:value-of select="$organisasjon/adresse/postnummer"/>&#x20;<xsl:value-of select="$organisasjon/adresse/poststed"/>
    </xsl:if>
  </xsl:template>

  <xsl:template name="footerForH2">
    <div class="headerrad">
      <xsl:value-of select="format-dateTime(current-dateTime(), '[D01].[M01].[Y0001] [H01]:[m01]')"/>
    </div>
  </xsl:template>
</xsl:stylesheet>
