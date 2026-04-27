<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <xsl:output method="html" encoding="utf-8" indent="yes" omit-xml-declaration="yes"/>
  <xsl:decimal-format name="nb-no-space" decimal-separator="," grouping-separator=" " NaN=" "/>
  <xsl:template match="/Forutsetningsbrev">
    <html>
      <head>
        <title>
          Overførsel fra <xsl:value-of select="Kreditor/Navn"/> (Forutsetningsbrev)
        </title>
        <style type="text/css">
          body {
          font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
          font-size: 12px;
          line-height: 1.22857143;
          color: #333;
          background-color: #fff;
          }

          table {
          width: 100%;
          text-align: left;
          }
          
          table td {
          vertical-align: top;
          padding: 6px;
          vertical-align: top;
          border-top: 1px solid #ddd;
          }
          
        </style>
      </head>
      <body>
        <section>
          <header>
            <h2>
              Overførsel fra <xsl:value-of select="Kreditor/Navn"/>
            </h2>
          </header>
          <table>
            <tbody>
              <tr>
                <td>Overføres til</td>
                <td>
                  <xsl:value-of select="Mottaker/Navn"/>
                  <xsl:text>, org.nr </xsl:text>
                  <xsl:value-of select="Mottaker/Organisasjonsnummer"/>
                </td>
              </tr>
              <tr>
                <td>
                  Registerenhet<xsl:if test="count(Registerenheter/Registerenhet)&gt;1">
                    <xsl:text>er</xsl:text>
                  </xsl:if>
                </td>
                <td>
                  <xsl:for-each select="Registerenheter/Registerenhet">
                    <xsl:choose>
                      <xsl:when test="string-length(Organisasjonsnummer) &gt; 0">
                        <!-- Borettsandel -->
                        <xsl:text>Org.nr </xsl:text>
                        <xsl:value-of select="Organisasjonsnummer"/>
                        <xsl:text> Andelsnr. </xsl:text>
                        <xsl:value-of select="Andelsnummer"/>
                        <xsl:if test="string-length(BorettslagNavn) &gt; 0">
                          <xsl:text> (</xsl:text>
                          <xsl:value-of select="BorettslagNavn"/>)
                        </xsl:if>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- Fast eiendom / eierseksjon -->
                        Knr. <xsl:value-of select="Kommunenummer"/>, gnr. <xsl:value-of select="Gardsnummer"/>, bnr. <xsl:value-of select="Bruksnummer"/>
                        <xsl:if test="string-length(Festenummer) &gt; 0 and Festenummer != '0'">
                          <xsl:text>, fnr. </xsl:text><xsl:value-of select="Festenummer"/>
                        </xsl:if>
                        <xsl:if test="string-length(Seksjonsnummer) &gt; 0 and Seksjonsnummer != '0'">
                          <xsl:text>, snr. </xsl:text><xsl:value-of select="Seksjonsnummer"/>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="string-length(Adresse) &gt; 0">
                      <xsl:text> (</xsl:text>
                      <xsl:value-of select="Adresse"/>)
                    </xsl:if>
                    <br/>
                  </xsl:for-each>
                </td>
              </tr>
              <tr>
                <td>Rettighetshavere</td>
                <td>
                  <xsl:for-each select="Debitorer/RettighetsHaver">
                    <xsl:value-of select="Navn"/>
                    <xsl:text>, </xsl:text>
                    <xsl:call-template name="formatRettighetsHaverNummer">
                      <xsl:with-param name="nummer" select="Nummer"/>
                    </xsl:call-template>
                    <br/>
                  </xsl:for-each>
                </td>
              </tr>
              <tr>
                <td>Pantedokument</td>
                <td>
                  <xsl:call-template name="formatNumber">
                    <xsl:with-param name="prefix" select="'Kr. '"/>
                    <xsl:with-param name="numericValue" select="PantedokumentDetaljer/Beloep"/>
                  </xsl:call-template>
                </td>
              </tr>
              <tr>
                <td>Prioritet</td>
                <td>

                  <xsl:choose>
                    <xsl:when test="PantedokumentDetaljer/ForstePrioritet='true'">1. prioritet</xsl:when>
                    <xsl:otherwise>

                      <table>
                        <thead>
                          <tr>
                            <th>Prioritet</th>
                            <th>Panthaver</th>
                            <th>Beløp</th>
                            <th>Beskrivelse</th>
                          </tr>
                        </thead>
                        <tbody>
                          <xsl:for-each select="PantedokumentDetaljer/Prioritet/PrioritetsAngivelse">
                            <tr>
                              <td>

                                <xsl:call-template name="formatPrioritetsRekkefolge">
                                  <xsl:with-param name="prioritetsRekkefolge" select="Rekkefolge"/>
                                </xsl:call-template>
                              </td>
                              <td>
                                <xsl:value-of select="Panthaver/Navn"/>
                                <xsl:if test="string-length(Panthaver/Nummer)&gt;0">
                                  <xsl:text>, </xsl:text>
                                  <xsl:call-template name="formatRettighetsHaverNummer">
                                    <xsl:with-param name="nummer" select="Panthaver/Nummer"/>
                                  </xsl:call-template>
                                </xsl:if>
                              </td>
                              <td>
                                <xsl:call-template name="formatNumber">
                                  <xsl:with-param name="prefix" select="'Kr. '"/>
                                  <xsl:with-param name="numericValue" select="Beloep"/>
                                </xsl:call-template>
                              </td>
                              <td>
                                <xsl:value-of select="PrioritetsBeskrivelse"/>
                              </td>
                            </tr>
                          </xsl:for-each>
                        </tbody>
                      </table>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
              <tr>
                <td>Beløp</td>
                <td>
                  <xsl:call-template name="formatNumber">
                    <xsl:with-param name="prefix" select="'Kr. '"/>
                    <xsl:with-param name="numericValue" select="OverfoerselDetaljer/Beloep"/>
                  </xsl:call-template>
                  <xsl:text> (totalbeløp </xsl:text>
                  <xsl:call-template name="formatNumber">
                    <xsl:with-param name="prefix" select="'Kr. '"/>
                    <xsl:with-param name="numericValue" select="OverfoerselDetaljer/TotalBeloep"/>
                  </xsl:call-template>
                  <xsl:text>)</xsl:text>
                </td>
              </tr>
              <tr>
                <td>Overføres dato</td>
                <td>
                  <xsl:value-of select="OverfoerselDetaljer/BeloepOverforesDato"/>
                </td>
              </tr>
              <tr>
                <td>Til konto</td>
                <td>
                  <xsl:call-template name="formatAccountNumber">
                    <xsl:with-param name="numericValue" select="OverfoerselDetaljer/TilKontonummer"/>
                  </xsl:call-template>
                </td>
              </tr>
              <tr>
                <td>KID</td>
                <td>
                  <xsl:value-of select="OverfoerselDetaljer/KID"/>
                </td>
              </tr>
              <tr>
                <td>Betalingsmelding</td>
                <td>
                  <xsl:value-of select="OverfoerselDetaljer/Betalingsmelding"/>
                </td>
              </tr>
              <xsl:if test="string-length(OverfoerselDetaljer/MeglerSaksnummer) &gt; 0">
                <tr>
                  <td>Oppdragsnummer megler</td>
                  <td>     
                      <xsl:value-of select="OverfoerselDetaljer/MeglerSaksnummer"/>                    
                  </td>
                </tr>
              </xsl:if>
              <xsl:if test="string-length(OverfoerselDetaljer/KreditorSaksnummer) &gt; 0">
                <tr>
                  <td>Saksnummer kreditor</td>
                  <td>
                      <xsl:value-of select="OverfoerselDetaljer/KreditorSaksnummer"/>
                  </td>
                </tr>
              </xsl:if>
              <tr>
                <td>Beløpet som overføres gjelder</td>
                <td>
                  Dekning av kjøpesum og omkostninger for ovennevnte eiendom
                </td>
              </tr>
            </tbody>
          </table>
        </section>

        <section>
          <h4>Forutsetninger</h4>
          <p>
            I det påfølgende henviser uthevet tekst til ovenstående tabell.
          </p>
          <p> 
            Det forutsettes at beløpet ikke stilles til selgers disposisjon før hjemmel til eiendommen blir
            overskjøtet til <strong>rettighetshavere</strong> eller annen tilfredsstillende sikkerhet (f.eks sikringsdokument) er
            tinglyst, og at elektronisk <strong>pantedokument</strong> er tinglyst i ovennevnte <strong>registerenhet</strong> med angitt
            <strong>prioritet</strong>, foran avtalepant, utleggspant og andre heftelser som begrenser omsetning av
            eiendommen, herunder boretter og forkjøpsretter. Vi aksepterer likevel at andre typer heftelser som
            kjøper har akseptert å overta, kan forbli tinglyst på eiendommen med prioritet foran bankens pant.
          </p>
          <p>
            Det forutsettes videre at vi mottar bekreftelse så snart rett prioritet foreligger.
          </p>
          <p>
            Dersom vi ikke har mottatt overnevnte bekreftelse innen 4 måneder, ber vi om at det meddeles når
            vi kan forvente at rett prioritet vil foreligge.
          </p>
        </section>
        <section>
          <h4>Avsender</h4>
          <p>
            <address>
              <xsl:value-of select="Kreditor/Navn"/>
              <xsl:text> (Org.nr </xsl:text>
              <xsl:value-of select="Kreditor/Nummer"/>)<br/>
              <xsl:value-of select="Avsender/Navn"/>
              <br/>
              <xsl:if test="string-length(Avsender/Email) &gt; 0">
                <a href="mailto:{Avsender/Email}">
                  <xsl:value-of select="Avsender/Email"/>
                </a>
                <br/>
              </xsl:if>
              <xsl:if test="string-length(Avsender/TelefonDirekte) &gt; 0">
                <a href="tel:{Avsender/TelefonDirekte}">
                  <xsl:call-template name="formatPhoneNumber">
                    <xsl:with-param name="phoneValue" select="Avsender/TelefonDirekte"/>
                  </xsl:call-template>
                </a>
                <xsl:text> (direkte)</xsl:text>
                <br/>
              </xsl:if>
              <xsl:if test="string-length(Avsender/Telefon) &gt; 0">
                <a href="tel:{Avsender/Telefon}">
                  <xsl:call-template name="formatPhoneNumber">
                    <xsl:with-param name="phoneValue" select="Avsender/Telefon"/>
                  </xsl:call-template>
                </a>
                <xsl:text> (telefon)</xsl:text>

                <br/>
              </xsl:if>
            </address>
          </p>
        </section>
        <footer>
          <small>
            Forutsetningsbrev: <xsl:value-of select="@xsi:noNamespaceSchemaLocation"/> / xslt 2.0.2 | Forutsetningsbrevet ble produsert <xsl:value-of select="OverfoerselDetaljer/ProdusertDato"/>
          </small>
        </footer>
      </body>
    </html>
  </xsl:template>


  <!-- Formatting helper functions: start -->
  <xsl:template name="formatRettighetsHaverNummer">
    <xsl:param name="nummer" select="."/>
    <xsl:choose>
      <xsl:when test="string-length($nummer)=11">
        <xsl:value-of select="'fnr. '"/>
      </xsl:when>
      <xsl:when test="string-length($nummer)=6">
        <xsl:value-of select="'f.dato '"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'orgnr. '"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$nummer"/>
  </xsl:template>

  <xsl:template name="formatPrioritetsRekkefolge">
    <xsl:param name="prioritetsRekkefolge" select="."/>
    <xsl:choose>
      <xsl:when test="$prioritetsRekkefolge='PrioritetEtter'">
        <xsl:value-of select="'Etter'"/>
      </xsl:when>
      <xsl:when test="$prioritetsRekkefolge='PrioritetLikestiltMed'">
        <xsl:value-of select="'Likestilt med'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$prioritetsRekkefolge"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="formatAccountNumber">
    <xsl:param name="numericValue" select="."/>

    <xsl:value-of select="concat(substring($numericValue, 1, 4), '.', substring($numericValue, 5, 2), '.', substring($numericValue, 7, 5))"/>
  </xsl:template>

  <xsl:template name="formatNumber">
    <xsl:param name="prefix"/>
    <xsl:param name="numericValue" select="."/>

    <xsl:if test="string-length($prefix) &gt; 0">
      <xsl:value-of select="$prefix"/>
    </xsl:if>
    <xsl:value-of select="format-number( $numericValue, '### ### ### ###,00', 'nb-no-space')"/>
  </xsl:template>

  <!-- Info: the 'string-replace' helper uses recursion -->
  <xsl:template name="string-replace">
    <xsl:param name="string"/>
    <xsl:param name="from"/>
    <xsl:param name="to"/>
    <xsl:choose>
      <xsl:when test="contains($string,$from)">
        <xsl:value-of select="substring-before($string,$from)"/>
        <xsl:copy-of select="$to"/>
        <xsl:call-template name="string-replace">
          <xsl:with-param name="string" select="substring-after($string,$from)"/>
          <xsl:with-param name="from" select="$from"/>
          <xsl:with-param name="to" select="$to"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
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
    
  <!-- Formatting helper functions: end-->
</xsl:stylesheet>