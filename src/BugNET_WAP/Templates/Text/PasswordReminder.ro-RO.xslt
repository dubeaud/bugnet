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
    <xsl:value-of select="NotificationUser/DisplayName" />,
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Aici gasiti parola ceruta </xsl:text><xsl:value-of select="NotificationUser/Password" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Va rugam sa va autentificati aici </xsl:text><xsl:value-of select="HostSetting_DefaultUrl" /><xsl:text>Account/Login.aspx</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Va rog sa tineti cont de faptul ca parola este case-sensitive.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Odata ce v-ati autentificat, puteti sa va modificati parola apasand click pe numele d-voastra in partea stanga sus si selectand parola in meniul din stanga.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Va multumim,</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:value-of select="HostSetting_ApplicationTitle" />
  </xsl:template>
</xsl:stylesheet>
