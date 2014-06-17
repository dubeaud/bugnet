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
        <xsl:text>Qualcuno ha chiesto il ripristino della password per il tuo account di </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />&#160;. Per reinizializzare la password, vai al seguente indirizzo:
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/PasswordReset.aspx?token=<xsl:value-of select="string" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Se non hai chiesto questa procedura di ripristino, non fare nulla e ignora questa comunicazione. </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Thank you,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
