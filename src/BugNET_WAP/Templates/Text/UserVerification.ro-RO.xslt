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
        <xsl:text>Bine ati venit la </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Buna ziua, </xsl:text><xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />
        <xsl:text>. Primiti acest email pentru ca ati creat receent un cont nou la </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>. Inainte de a va autentifica,trebuie sa accesati urmatorul link pentru a confirma contul d-voastra: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="string" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Dupa ce ati viziatat link-ul de mai sus puteti sa va autentificati pe site!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Daca aveti probleme in verificarea contului, va rog faceti raspundeti la acest email pentru a primi asistenta.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Va multumim!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

