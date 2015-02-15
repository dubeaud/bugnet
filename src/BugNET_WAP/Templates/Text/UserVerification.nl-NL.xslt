<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers"
  exclude-result-prefixes="msxsl helpers">

    <xsl:output omit-xml-declaration="yes" method="html" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/root">
        <xsl:text>Welkom bij</xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Hallo, </xsl:text><xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />
        <xsl:text>. U ontvang deze email omdat u recent een gebruikersaccount heeft aangemaakt op </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>. Voordat u kunt inloggen, moet u de volgende link gebruiken om uw account te activeren: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Nadat u de bovenstaande link heeft gebruikt kunt u inloggen op de website!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Als u problemen ondervind met het activeren van uw account, stuur dan een antwoord op dit bericht voor assistentie.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Dank u wel!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

