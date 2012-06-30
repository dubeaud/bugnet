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
        <xsl:value-of select="User/DisplayName" />,
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Uw wachtwoord is gereset naar &#160;&#160;</xsl:text><xsl:value-of select="Password" />&#160; Log u alstublieft hier in. <xsl:value-of select="HostSetting_DefaultUrl" />Login.aspx
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Houd u er rekening mee dat dit wachtwoord hoofdletter gevoelig is.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Wanneer u ingelogged bent, kunt u uw wachtwoord wijzigen door op uw gebruikersnaam te klikken en 'wachtwoord' te selecteren.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Dank u wel,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
