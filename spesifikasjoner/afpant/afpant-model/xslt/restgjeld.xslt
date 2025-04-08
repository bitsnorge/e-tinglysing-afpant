<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:decimal-format name="nb-no-space" decimal-separator="," grouping-separator=" " NaN=" "/>
    
    <!-- Root template -->
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:call-template name="get-title"/>
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
                            <xsl:call-template name="get-title"/>
                        </h1>
                        <hr/>
                    </div>
                    <div id="body">
                        <xsl:apply-templates select="innfrielsessaldoforespoersel"/>
                        <xsl:apply-templates select="innfrielsessaldosvar"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Title helper template -->
    <xsl:template name="get-title">
        <xsl:choose>
            <xsl:when test="innfrielsessaldoforespoersel">Forespørsel om innfrielsessaldo</xsl:when>
            <xsl:when test="innfrielsessaldosvar">Svar på innfrielsessaldo</xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Innfrielsessaldosvar template -->
    <xsl:template match="innfrielsessaldosvar">
        <!-- Avsender section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Avsender</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="avsender"/>
                </div>
            </div>
        </div>

        <!-- Mottaker section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Mottaker</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="mottaker"/>
                </div>
            </div>
        </div>

        <!-- Lån section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Lån</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="laanliste/laan"/>
                </div>
            </div>
        </div>

        <!-- Registerenheter section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Registerenheter med dokumentreferanser</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="registerenheterMedDokumentreferanser/registerenhetMedDokumentreferanse"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Innfrielsessaldoforespoersel template -->
    <xsl:template match="innfrielsessaldoforespoersel">
        <!-- Avsender section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Avsender</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="avsender"/>
                </div>
            </div>
        </div>

        <!-- Mottaker section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Mottaker</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="mottaker"/>
                </div>
            </div>
        </div>

        <!-- Registerenheter section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Registerenheter med Hjemmelshavere</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="registerenheterMedHjemmelshavere"/>
                </div>
            </div>
        </div>

        <!-- Innfrielsesdatoer section -->
        <div class="hovedseksjon">
            <div class="seksjonsoverskrift">Innfrielsesdatoer</div>
            <div class="tabell innhold">
                <div class="kropp">
                    <xsl:apply-templates select="innfrielsesdatoer"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Lån template -->
    <xsl:template match="laan">
        <div class="rad">
            <div class="celle">
                <div>Lånenummer: <xsl:value-of select="laanenummer"/></div>
                <div>Kontonummer: <xsl:value-of select="kontonummer"/></div>
                <xsl:if test="kidnummer">
                    <div>KID: <xsl:value-of select="kidnummer"/></div>
                </xsl:if>
                <xsl:if test="betalingsmelding">
                    <div>Betalingsmelding: <xsl:value-of select="betalingsmelding"/></div>
                </xsl:if>
                
                <div class="rolleoverskrift">Saldoer per dato</div>
                <xsl:for-each select="saldoerPerDato/saldoPerDato">
                    <div class="innhold">
                        <xsl:call-template name="formatNumber">
                            <xsl:with-param name="prefix" select="'NOK '"/>
                            <xsl:with-param name="numericValue" select="beloep"/>
                        </xsl:call-template>
                        <xsl:text> per </xsl:text>
                        <xsl:call-template name="format-date">
                            <xsl:with-param name="date" select="dato"/>
                        </xsl:call-template>
                    </div>
                </xsl:for-each>

                <xsl:if test="laantakereHjemmelshaver/navn">
                    <div class="rolleoverskrift">Låntakere som er hjemmelshavere</div>
                    <xsl:for-each select="laantakereHjemmelshaver/navn">
                        <div class="innhold"><xsl:value-of select="."/></div>
                    </xsl:for-each>
                </xsl:if>
            </div>
        </div>
    </xsl:template>

    <!-- Registerenhet med dokumentreferanse template -->
    <xsl:template match="registerenhetMedDokumentreferanse">
        <div class="rad">
            <div class="celle">
                <xsl:choose>
                    <xsl:when test="matrikkel">
                        <div>Matrikkel:</div>
                        <div class="innhold">
                            Kommune: <xsl:value-of select="matrikkel/@kommunenavn"/> (<xsl:value-of select="matrikkel/@kommunenummer"/>)<br/>
                            Gårdsnr: <xsl:value-of select="matrikkel/@gaardsnummer"/><br/>
                            Bruksnr: <xsl:value-of select="matrikkel/@bruksnummer"/>
                            <xsl:if test="matrikkel/@festenummer">
                                <br/>Festenr: <xsl:value-of select="matrikkel/@festenummer"/>
                            </xsl:if>
                            <xsl:if test="matrikkel/@seksjonsnummer">
                                <br/>Seksjonsnr: <xsl:value-of select="matrikkel/@seksjonsnummer"/>
                            </xsl:if>
                        </div>
                    </xsl:when>
                    <xsl:when test="borettsandel">
                        <div>Borettsandel:</div>
                        <div class="innhold">
                            Borettslag: <xsl:value-of select="borettsandel/@borettslagnavn"/><br/>
                            Org.nr: <xsl:value-of select="borettsandel/@organisasjonsnummer"/><br/>
                            Andelsnr: <xsl:value-of select="borettsandel/@andelsnummer"/>
                        </div>
                    </xsl:when>
                    <xsl:when test="aksjeleilighet">
                        <div>Aksjeleilighet:</div>
                        <div class="innhold">
                            Selskap: <xsl:value-of select="aksjeleilighet/@organisasjonsnavn"/><br/>
                            Org.nr: <xsl:value-of select="aksjeleilighet/@organisasjonsnummer"/><br/>
                            Leilighetsnr: <xsl:value-of select="aksjeleilighet/@leilighetsnummer"/>
                        </div>
                    </xsl:when>
                </xsl:choose>

                <xsl:if test="pantedokumentreferanser/pantedokumentreferanse">
                    <div class="rolleoverskrift">Pantedokumentreferanser</div>
                    <xsl:for-each select="pantedokumentreferanser/pantedokumentreferanse">
                        <div class="innhold">
                            Dokumentnr: <xsl:value-of select="@dokumentnummer"/>/<xsl:value-of select="@dokumentaar"/><br/>
                            Embete: <xsl:value-of select="@embetenummer"/><br/>
                            Rettsstiftelse: <xsl:value-of select="@rettsstiftelsesnummer"/><br/>
                            Registrert: <xsl:call-template name="format-datetime">
                                <xsl:with-param name="datetime" select="@registreringstidspunkt"/>
                            </xsl:call-template><br/>
                            Beløp: <xsl:call-template name="formatNumber">
                                <xsl:with-param name="prefix" select="'NOK '"/>
                                <xsl:with-param name="numericValue" select="@beloep"/>
                            </xsl:call-template>
                        </div>
                    </xsl:for-each>
                </xsl:if>
            </div>
        </div>
    </xsl:template>

    <!-- Helper template for formatting dates -->
    <xsl:template name="format-date">
        <xsl:param name="date"/>
        <xsl:value-of select="substring($date, 9, 2)"/>.<xsl:value-of select="substring($date, 6, 2)"/>.<xsl:value-of select="substring($date, 1, 4)"/>
    </xsl:template>

    <!-- Helper template for formatting date-times -->
    <xsl:template name="format-datetime">
        <xsl:param name="datetime"/>
        <xsl:value-of select="substring($datetime, 9, 2)"/>.<xsl:value-of select="substring($datetime, 6, 2)"/>.<xsl:value-of select="substring($datetime, 1, 4)"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="substring($datetime, 12, 5)"/>
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

    <!-- Avsender template -->
    <xsl:template match="avsender">
        <div class="rad">
            <div class="celle kol1">
                <xsl:value-of select="foretaksnavn"/>
                <xsl:if test="@id">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@id"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </div>
        </div>
        <xsl:if test="adresse">
            <div class="rad">
                <div class="celle">
                    <xsl:value-of select="adresse/gatenavn"/>,
                    <xsl:value-of select="adresse/postnummer"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="adresse/poststed"/>
                </div>
            </div>
        </xsl:if>
        <xsl:if test="kontaktperson">
            <div class="rad">
                <div class="celle">
                    <div><xsl:value-of select="kontaktperson/navn"/></div>
                    <xsl:if test="kontaktperson/epost">
                        <div><a href="mailto:{kontaktperson/epost}"><xsl:value-of select="kontaktperson/epost"/></a></div>
                    </xsl:if>
                    <xsl:if test="kontaktperson/telefon">
                        <div>Tlf: <a href="tel:{kontaktperson/telefon}"><xsl:value-of select="kontaktperson/telefon"/></a></div>
                    </xsl:if>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Mottaker template -->
    <xsl:template match="mottaker">
        <div class="rad">
            <div class="celle kol1">
                <xsl:value-of select="foretaksnavn"/>
                <xsl:if test="@id">
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="@id"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </div>
        </div>
        <xsl:if test="adresse">
            <div class="rad">
                <div class="celle">
                    <xsl:value-of select="adresse/gatenavn"/>,
                    <xsl:value-of select="adresse/postnummer"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="adresse/poststed"/>
                </div>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Registerenheter template -->
    <xsl:template match="registerenheterMedHjemmelshavere">
        <xsl:for-each select="registerenhetMedHjemmelshavere">
            <div class="rad">
                <div class="celle">
                    <xsl:choose>
                        <xsl:when test="matrikkel">
                            <div>Matrikkel:</div>
                            <div class="innhold">
                                Kommune: <xsl:value-of select="matrikkel/@kommunenavn"/> (<xsl:value-of select="matrikkel/@kommunenummer"/>)<br/>
                                Gårdsnr: <xsl:value-of select="matrikkel/@gaardsnummer"/><br/>
                                Bruksnr: <xsl:value-of select="matrikkel/@bruksnummer"/>
                                <xsl:if test="matrikkel/@festenummer">
                                    <br/>Festenr: <xsl:value-of select="matrikkel/@festenummer"/>
                                </xsl:if>
                                <xsl:if test="matrikkel/@seksjonsnummer">
                                    <br/>Seksjonsnr: <xsl:value-of select="matrikkel/@seksjonsnummer"/>
                                </xsl:if>
                            </div>
                        </xsl:when>
                        <xsl:when test="borettsandel">
                            <div>Borettsandel:</div>
                            <div class="innhold">
                                Borettslag: <xsl:value-of select="borettsandel/@borettslagnavn"/><br/>
                                Org.nr: <xsl:value-of select="borettsandel/@organisasjonsnummer"/><br/>
                                Andelsnr: <xsl:value-of select="borettsandel/@andelsnummer"/>
                            </div>
                        </xsl:when>
                        <xsl:when test="aksjeleilighet">
                            <div>Aksjeleilighet:</div>
                            <div class="innhold">
                                Selskap: <xsl:value-of select="aksjeleilighet/@organisasjonsnavn"/><br/>
                                Org.nr: <xsl:value-of select="aksjeleilighet/@organisasjonsnummer"/><br/>
                                Leilighetsnr: <xsl:value-of select="aksjeleilighet/@leilighetsnummer"/>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </div>
            </div>
            <xsl:if test="hjemmelshavere">
                <div class="rad">
                    <div class="celle">
                        <div class="rolleoverskrift">Hjemmelshavere</div>
                        <xsl:for-each select="hjemmelshavere/hjemmelshaver">
                            <div class="innhold">
                                <xsl:choose>
                                    <xsl:when test="person">
                                        <xsl:value-of select="person/fornavn"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="person/etternavn"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="person/@id"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:when>
                                    <xsl:when test="organisasjon">
                                        <xsl:value-of select="organisasjon/foretaksnavn"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="organisasjon/@id"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:when>
                                </xsl:choose>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <!-- Innfrielsesdatoer template -->
    <xsl:template match="innfrielsesdatoer">
        <xsl:for-each select="innfrielsesdato">
            <div class="rad">
                <div class="celle">
                    <xsl:value-of select="."/>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
