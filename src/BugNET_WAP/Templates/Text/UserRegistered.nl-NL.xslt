<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">

  <xsl:output omit-xml-declaration="yes" method="text" />
  <xsl:strip-space elements="*" />
  
  <xsl:template match="/root">
    <xsl:text>De volgende gebruiker heeft zich zojuist geregistreerd:</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Datum: </xsl:text><xsl:value-of select="helpers:FormatShortDateAnd12HTime(NotificationUser/CreationDate)" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Naam: </xsl:text><xsl:value-of select="NotificationUser/DisplayName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Gebruikersnaam: </xsl:text><xsl:value-of select="NotificationUser/UserName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Email: </xsl:text><xsl:value-of select="NotificationUser/Email" />
  </xsl:template>
</xsl:stylesheet>
