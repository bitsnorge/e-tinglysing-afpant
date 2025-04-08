<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:decimal-format name="nb-no-space" decimal-separator="," grouping-separator=" " NaN=" "/>
    <!-- Root template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:call-template name="overskrift"/>
                </title>
                <style type="text/css">
                    .rolleoverskrift,
                    .seksjonsoverskrift {
                        font-weight: 500;
                        color: #255473
                    }

                    #footer,
                    .overskrift,
                    .rolleoverskrift {
                        color: #255473
                    }

                    .seksjonsoverskrift {
                        padding-bottom: 8px
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
                        padding: 5px;
                        margin-bottom: 4px
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
                        width: 100%
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

                    .celle {
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

                    .tall {
                        text-align: right;
                    }
                </style>
            </head>
            <body>
                <div id="container">
                    <div id="header">
                        <h1 class="overskrift">
                            <xsl:call-template name="overskrift"/>
                        </h1>
                        <hr/>
                        <xsl:call-template name="footerForH1">
                            <xsl:with-param name="home" select="*"/>
                            <xsl:with-param name="meldingsnavn" select="$dsveMeldingstypeBeskrivelse"/>
                        </xsl:call-template>
                    </div>
                    <div id="body">
                        <xsl:apply-templates select="innfrielsessaldoforespoersel"/>
                        <xsl:apply-templates select="innfrielsessaldosvar"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template name="overskrift">
        <xsl:if test="innfrielsessaldoforespoersel">
            <xsl:text>Forespørsel om innfrielsessaldo</xsl:text>
        </xsl:if>
        <xsl:if test="innfrielsessaldosvar">
            <xsl:text>Svar på innfrielsessaldo</xsl:text>
        </xsl:if>
    </xsl:template>
    <!-- Innfrielsessaldosvar template -->
    <xsl:template match="/innfrielsessaldosvar">
        <xsl:call-template name="mottaker"/>
        <xsl:call-template name="eiendom">
            <xsl:with-param name="registerenhetsliste" select="registerenheterMedDokumentreferanser/registerenhetMedDokumentreferanse"/>
        </xsl:call-template>
        <xsl:call-template name="laanliste"/>
        <xsl:call-template name="ressurser"/>
        <xsl:call-template name="avsender"/>
        <hr/>
    </xsl:template>
    <!-- Helper template for formatting Norwegian account numbers -->
    <xsl:template name="formatAccountNumber">
        <xsl:param name="numericValue" select="."/>
        <xsl:value-of select="concat(substring($numericValue, 1, 4), '.', substring($numericValue, 5, 2), '.', substring($numericValue, 7, 5))"/>
    </xsl:template>
    <!-- Helper template for formatting dates -->
    <xsl:template name="format-date">
        <xsl:param name="date"/>
        <xsl:value-of select="substring($date, 9, 2)"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring($date, 6, 2)"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring($date, 1, 4)"/>
    </xsl:template>
    <xsl:template name="tiddato">
        <xsl:param name="dato"/>
        <xsl:value-of select="substring($dato, 9, 2)"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring($dato, 6, 2)"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring($dato, 1, 4)"/>
        <xsl:text>&#x20;&#x20;</xsl:text>
        <xsl:value-of select="substring($dato, 12, 2)"/>
        <xsl:text>:</xsl:text>
        <xsl:value-of select="substring($dato, 15, 2)"/>
    </xsl:template>
    <!-- Helper template for formatting numbers -->
    <xsl:template name="formatNumber">
        <xsl:param name="prefix"/>
        <xsl:param name="numericValue"/>
        <xsl:if test="string-length($prefix) &gt; 0">
            <xsl:value-of select="$prefix"/>
        </xsl:if>
        <xsl:value-of select="format-number(number($numericValue), '### ### ### ###', 'nb-no-space')"/>
    </xsl:template>
    <!-- Helper template for formatting norwegian phone numbers -->
    <xsl:template name="formatPhoneNumber">
        <xsl:param name="prefix"/>
        <xsl:param name="phoneValue" select="."/>
        <xsl:choose>
            <xsl:when test="string-length($phoneValue) = 8">
                <xsl:value-of select="concat(substring($phoneValue, 1, 2), ' ', substring($phoneValue, 3, 2), ' ', substring($phoneValue, 5, 2), ' ', substring($phoneValue, 7, 2))"/>
            </xsl:when>
            <xsl:when test="string-length($phoneValue) = 11 and substring($phoneValue, 1, 1) = '+'">
                <xsl:value-of select="concat(substring($phoneValue, 1, 3), ' ', substring($phoneValue, 4, 2), ' ', substring($phoneValue, 6, 2), ' ', substring($phoneValue, 8, 2), ' ', substring($phoneValue, 10, 2))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$phoneValue"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="organisasjon">
        <xsl:param name="organisasjon"/>
        <xsl:value-of select="$organisasjon/foretaksnavn"/>
        <xsl:text>&#x20;org.nr.&#x20;</xsl:text>
        <xsl:call-template name="orgnr">
            <xsl:with-param name="id" select="$organisasjon/@id"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template name="orgnr">
        <xsl:param name="id"/>
        <xsl:if test="$id">
            <xsl:value-of select="substring( format-number($id, '000000000'),1,3)"/>
            <xsl:text>&#x20;</xsl:text>
            <xsl:value-of select="substring( format-number($id, '000000000'), 4,3)"/>
            <xsl:text>&#x20;</xsl:text>
            <xsl:value-of select="substring( format-number($id, '000000000'), 7,3)"/>
            <xsl:text>&#xA0;</xsl:text>
            <a href="https://w2.brreg.no/enhet/sok/detalj.jsp?orgnr={$id}" target="_blank" style="text-decoration: none;">
                <xsl:text>&#x29C9;</xsl:text>
            </a>
        </xsl:if>
    </xsl:template>
    <xsl:template name="foedselsnr">
        <xsl:param name="id"/>
        <xsl:if test="$id">
            <xsl:value-of select="substring( format-number($id, '00000000000'),1,6)"/>
            <xsl:text>&#x20;</xsl:text>
            <xsl:value-of select="substring( format-number($id, '00000000000'), 7,5)"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="kontaktperson">
        <xsl:param name="kontakt"/>
        <xsl:param name="referanse"/>
        <div>
            <xsl:value-of select="$kontakt/navn"/>
        </div>
        <div>
            <div>
                <a href="tel:{$kontakt/telefon}">
                    <xsl:value-of select="format-number( number($kontakt/telefon), '## ## ## ##', 'nb-no-space')"/>
                </a>&#x20;(telefon)
            </div>
            <div>
                <a href="tel:{$kontakt/telefondirekte}">
                    <xsl:value-of select="format-number( number($kontakt/telefondirekte), '## ## ## ##', 'nb-no-space')"/>
                </a>
                <xsl:text>&#x20;(direkte)</xsl:text>
            </div>
            <div>
                <a href="mailto:{$kontakt/epost}?Subject=Angående%20{$dsveMeldingstypeBeskrivelse}%20med%20oppdragsnummer%20{$referanse}">
                    <xsl:value-of select="$kontakt/epost"/>
                </a>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="mottaker">
        <div class="hovedseksjon">
            <xsl:call-template name="seksjon">
                <xsl:with-param name="tittel" select="'Mottaker'"/>
            </xsl:call-template>
            <div class="tabell innhold">
                <div class="rad">
                    <div class="celle kol1">
                        <xsl:call-template name="organisasjon">
                            <xsl:with-param name="organisasjon" select="mottaker"/>
                        </xsl:call-template>
                    </div>
                    <div class="celle">
                        <xsl:if test="mottaker/referanse">Referanse:&#x20;
                            <xsl:value-of select="mottaker/referanse"/>
                        </xsl:if>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="avsender">
        <div class="hovedseksjon">
            <xsl:call-template name="seksjon">
                <xsl:with-param name="tittel" select="'Avsender'"/>
            </xsl:call-template>
            <div class="tabell innhold">
                <div class="rad">
                    <div class="celle kol1">
                        <xsl:if test="avsender/kontaktperson">
                            <div style="padding-bottom:8px;">
                                <xsl:call-template name="organisasjon">
                                    <xsl:with-param name="organisasjon" select="avsender"/>
                                </xsl:call-template>
                            </div>
                            <xsl:call-template name="kontaktperson">
                                <xsl:with-param name="kontakt" select="avsender/kontaktperson"/>
                                <xsl:with-param name="referanse" select="avsender/referanse"/>
                            </xsl:call-template>
                        </xsl:if>
                        <xsl:if test="not(avsender/kontaktperson)">
                            <div style="padding-bottom:8px;">
                                <xsl:call-template name="organisasjon">
                                    <xsl:with-param name="organisasjon" select="avsender"/>
                                </xsl:call-template>
                            </div>
                        </xsl:if>
                    </div>
                    <div class="celle">
                        <xsl:if test="avsender/returnertil">
                            <xsl:text>Returneres til:&#x20;</xsl:text>
                            <div style="padding-bottom:8px;">
                                <xsl:call-template name="organisasjon">
                                    <xsl:with-param name="organisasjon" select="avsender/returnertil"/>
                                </xsl:call-template>
                            </div>
                        </xsl:if>
                        <div>
                            <div>Referanse:</div>
                            <xsl:value-of select="avsender/referanse"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="eiendom">
        <xsl:param name="registerenhetsliste"/>
        <div class="hovedseksjon">
            <xsl:call-template name="seksjon">
                <xsl:with-param name="tittel" select="'Eiendom'"/>
            </xsl:call-template>
            <div class="liste">
                <xsl:call-template name="registerenhetvisning">
                    <xsl:with-param name="registerenhetsliste" select="$registerenhetsliste"/>
                </xsl:call-template>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="registerenhetvisning">
        <xsl:param name="registerenhetsliste"/>
        <xsl:for-each select="$registerenhetsliste">
            <div class="listeelement">
                <xsl:call-template name="registerenhet">
                    <xsl:with-param name="registerenhet" select="."/>
                </xsl:call-template>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="registerenhet">
        <xsl:param name="registerenhet"/>
        <div class="innhold">
            <xsl:if test="$registerenhet/matrikkel">
                <xsl:call-template name="eiendomsnivaatype">
                    <xsl:with-param name="matrikkel" select="$registerenhet/matrikkel"/>
                </xsl:call-template>
                <xsl:if test="$registerenhet/adresse">
                    <xsl:call-template name="adresse">
                        <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="matrikkel">
                    <xsl:with-param name="matrikkel" select="$registerenhet/matrikkel"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$registerenhet/borettsandel">
                <xsl:text>Borettsandel</xsl:text>
                <xsl:if test="$registerenhet/adresse">
                    <xsl:call-template name="adresse">
                        <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="borettsandel">
                    <xsl:with-param name="borettsandel" select="$registerenhet/borettsandel"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$registerenhet/aksjeleilighet">
                <xsl:text>Aksjeleilighet</xsl:text>
                <xsl:if test="$registerenhet/adresse">
                    <xsl:call-template name="adresse">
                        <xsl:with-param name="adresse" select="$registerenhet/adresse"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="aksjeleilighet">
                    <xsl:with-param name="aksjeleilighet" select="$registerenhet/aksjeleilighet"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$registerenhet/pantedokumentreferanser">
                <div class="tabell innhold">
                    <div class="kropp">
                        <xsl:for-each select="$registerenhet/pantedokumentreferanser/pantedokumentreferanse">
                            <xsl:call-template name="pant">
                                <xsl:with-param name="dokument" select="."/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    <xsl:template name="aksjeleilighet">
        <xsl:param name="aksjeleilighet"/>
        <div>
            <xsl:value-of select="$aksjeleilighet/@organisasjonsnavn"/>
            <xsl:text>,&#x20;org.nr.&#x20;</xsl:text>
            <xsl:call-template name="orgnr">
                <xsl:with-param name="id" select="$aksjeleilighet/@organisasjonsnummer"/>
            </xsl:call-template>
            <xsl:text>,&#x20;leilighetsnummer:&#x20;</xsl:text>
            <xsl:value-of select="$aksjeleilighet/@leilighetsnummer"/>
        </div>
    </xsl:template>
    <xsl:template name="borettsandel">
        <xsl:param name="borettsandel"/>
        <div>
            <xsl:value-of select="$borettsandel/@borettslagnavn"/>
            <xsl:text>,&#x20;org.nr.&#x20;</xsl:text>
            <xsl:call-template name="orgnr">
                <xsl:with-param name="id" select="$borettsandel/@organisasjonsnummer"/>
            </xsl:call-template>
            <xsl:text>,&#x20;andelnr.&#x20;</xsl:text>
            <xsl:value-of select="$borettsandel/@andelsnummer"/>
        </div>
    </xsl:template>
    <xsl:template name="matrikkel">
        <xsl:param name="matrikkel"/>
        <div>
            <xsl:text>Kommune:&#x20;</xsl:text>
            <xsl:value-of select="$matrikkel/@kommunenavn"/>
            <xsl:text>&#x20;</xsl:text>
            <xsl:value-of select="$matrikkel/@kommunenummer"/>
            <xsl:text>,&#x20;gårdsnr.:&#x20;</xsl:text>
            <xsl:value-of select="$matrikkel/@gaardsnummer"/>
            <xsl:text>,&#x20;bruksnr.:&#x20;</xsl:text>
            <xsl:value-of select="$matrikkel/@bruksnummer"/>
            <!-- Siden XSD sier at seksjonsnummer / festenummer er optional tester vi også mot tom streng (PH) -->
            <xsl:if test="not($matrikkel/@seksjonsnummer = '0') and not($matrikkel/@seksjonsnummer = '')">
                <xsl:text>,&#x20;sekjsonsnr.:&#x20;</xsl:text>
                <xsl:value-of select="$matrikkel/@seksjonsnummer"/>
            </xsl:if>
            <xsl:if test="not($matrikkel/@festenummer = '0') and not($matrikkel/@festenummer = '')">
                <xsl:text>,&#x20;festenr.:&#x20;</xsl:text>
                <xsl:value-of select="$matrikkel/@festenummer"/>
            </xsl:if>
        </div>
    </xsl:template>
    <xsl:template name="eiendomsnivaatype">
        <xsl:param name="matrikkel"/>
        <xsl:if test="$matrikkel/@eiendomsnivaa = 'E'">Grunneiendom</xsl:if>
        <xsl:if test="$matrikkel/@eiendomsnivaa = 'F'">Festeeiendom</xsl:if>
        <xsl:if test="contains($matrikkel/@eiendomsnivaa, 'F_')">Fremfeste
            <xsl:value-of select="$matrikkel/@eiendomsnivaa"/>
        </xsl:if>
    </xsl:template>
    <xsl:template name="adresse">
        <xsl:param name="adresse"/>
        <div>
            <xsl:value-of select="$adresse/gatenavn"/>
            <xsl:text>,&#x20;</xsl:text>
            <xsl:value-of select="$adresse/postnummer"/>
            <xsl:text>&#x20;</xsl:text>
            <xsl:value-of select="$adresse/poststed"/>
        </div>
    </xsl:template>
    <xsl:template name="pant">
        <xsl:param name="dokument"/>
        <div class="rad">
            <div class="celle kol1">
                <span>
                    <xsl:value-of select="$dokument/@dokumentaar"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$dokument/@dokumentnummer"/>
                    <xsl:text>-</xsl:text>
                    <xsl:value-of select="$dokument/@rettsstiftelsesnummer"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$dokument/@embetenummer"/>
                </span>
                <br/>
                <xsl:call-template name="tiddato">
                    <xsl:with-param name="dato" select="$dokument/@registreringstidspunkt"/>
                </xsl:call-template>
                <xsl:if test="$dokument/@kommunenummer">
                    <br/>
                    <xsl:text>Kommune:&#x20;</xsl:text>
                    <xsl:value-of select="$dokument/@kommunenummer"/>
                </xsl:if>
            </div>
            <div class="celle">
                <span>
                    <xsl:text>Pantedokument</xsl:text>
                </span>
                <br/>
                <xsl:text>Beløp: </xsl:text>
                <xsl:call-template name="formatNumber">
                    <xsl:with-param name="prefix" select="'NOK '"/>
                    <xsl:with-param name="numericValue" select="$dokument/@beloep"/>
                </xsl:call-template>
                <br/>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="ressurser">
        <div class="hovedseksjon">
            <xsl:call-template name="seksjon">
                <xsl:with-param name="tittel" select="'Vedlegg'"/>
            </xsl:call-template>
            <div class="tabell innhold">
                <div class="rad" style="font-style: italic;">
                    <div class="celle kol1">Filnavn</div>
                    <div class="celle">Beskrivelse</div>
                </div>
                <xsl:for-each select="metadata/ressurser/vedlegg">
                    <xsl:call-template name="vedlegg">
                        <xsl:with-param name="vedlegg" select="."/>
                    </xsl:call-template>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="vedlegg">
        <xsl:param name="vedlegg"/>
        <div class="rad">
            <div class="celle">
                <xsl:value-of select="$vedlegg/navn"/>
            </div>
            <div class="celle">
                <xsl:value-of select="$vedlegg/beskrivelse"/>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="seksjon">
        <xsl:param name="tittel"/>
        <div class="seksjonsoverskrift">
            <xsl:value-of select="$tittel"/>
        </div>
    </xsl:template>
    <!-- TODO: kontaktperson-template bruker dsveMeldingstypeBeskrivelse-variabelen i en mailto: href, men den er da ikke urlencodet korrekt der (PH) -->
    <xsl:variable name="dsveMeldingstypeBeskrivelse">
        <xsl:call-template name="type"/>
    </xsl:variable>
    <xsl:template name="type">
        <xsl:if test="innfrielsessaldoforespoersel">
            <xsl:text>Forespørsel om innfrielsessaldo</xsl:text>
        </xsl:if>
        <xsl:if test="innfrielsessaldosvar">
            <xsl:text>Svar på innfrielsessaldo</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template name="laanliste">
        <div class="hovedseksjon">
            <xsl:call-template name="seksjon">
                <xsl:with-param name="tittel" select="'Lån'"/>
            </xsl:call-template>
            <div class="tabell innhold">
                <xsl:for-each select="laanliste/laan">
                    <div class="rad">
                        <div class="celle kol1">
                            <div>Lånenummer:
                                <xsl:value-of select="laanenummer"/>
                            </div>
                            <div>Kontonummer:
                                <xsl:call-template name="formatAccountNumber">
                                    <xsl:with-param name="numericValue" select="kontonummer"/>
                                </xsl:call-template>
                            </div>
                            <xsl:if test="kidnummer">
                                <div>KID:
                                    <xsl:value-of select="kidnummer"/>
                                </div>
                            </xsl:if>
                            <xsl:if test="betalingsmelding">
                                <div>Betalingsmelding:
                                    <xsl:value-of select="betalingsmelding"/>
                                </div>
                            </xsl:if>
                            <xsl:if test="laantakereHjemmelshaver/navn">
                                <div>Låntakere:
                                    <xsl:for-each select="laantakereHjemmelshaver/navn">
                                        <div class="innhold">
                                            <xsl:value-of select="."/>
                                        </div>
                                    </xsl:for-each>
                                </div>
                            </xsl:if>
                        </div>
                        <div class="celle">
                            <xsl:for-each select="saldoerPerDato/saldoPerDato">
                                <div>
                                    <xsl:text>Saldo per </xsl:text>
                                    <xsl:call-template name="format-date">
                                        <xsl:with-param name="date" select="dato"/>
                                    </xsl:call-template>
                                    <xsl:text>: </xsl:text>
                                    <span class="tall">
                                        <xsl:call-template name="formatNumber">
                                            <xsl:with-param name="prefix" select="'NOK '"/>
                                            <xsl:with-param name="numericValue" select="beloep"/>
                                        </xsl:call-template>
                                    </span>
                                </div>
                            </xsl:for-each>
                            <xsl:if test="laantakerIkkeHjemmelshaver = 'true'">
                                <div style="color: red; padding-top: 8px;">
                                    Merk: Låntaker er ikke hjemmelshaver
                                </div>
                            </xsl:if>
                            <xsl:if test="transporterklaering = 'true'">
                                <div style="padding-top: 8px;">
                                    Transporterklæring er påkrevd
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                    <xsl:if test="position() != last()">
                        <hr style="margin: 10px 0;"/>
                    </xsl:if>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>
    <xsl:template name="footerForH1">
        <xsl:param name="home"/>
        <xsl:param name="meldingsnavn"/>
        <div style="padding-bottom:16px;">
            <small style="float:right;">DSVE&#xA0;
                <xsl:value-of select="$meldingsnavn"/>,&#x20;opprettet
                <xsl:call-template name="tiddato">
                    <xsl:with-param name="dato" select="$home/metadata/opprettet"/>
                </xsl:call-template>
            </small>
        </div>
    </xsl:template>
</xsl:stylesheet>