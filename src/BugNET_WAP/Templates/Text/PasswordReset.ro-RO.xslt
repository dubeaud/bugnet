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
        <xsl:text>Parola d-voastra a fost resetata la &#160;&#160;</xsl:text><xsl:value-of select="Password" />&#160; Autentificati-va aici. <xsl:value-of select="HostSetting_DefaultUrl" />Account/Login.aspx
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Va rugam sa aveti in vedere ca parola este case-sensitive.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Odata autentificat, puteti sa modificati parola apasand click pe nume d-voastra in stanga sus si alegeti Parola.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Va multumim,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
