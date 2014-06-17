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
        <xsl:text>Questa notifica conferma che hai cambiato la password del tuo account di </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />&#160;.
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Se non hai modificato di tua iniziativa la password, contatta </xsl:text> <xsl:value-of select="HostSetting_ApplicationTitle" /> per assistenza.
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Grazie,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
