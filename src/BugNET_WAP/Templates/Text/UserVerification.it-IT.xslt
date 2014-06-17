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
        <xsl:text>Benvenuto in </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Ciao, </xsl:text><xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />
        <xsl:text>. Stai ricevendo questa notifica perché hai recentemente creato un nuovo account su </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>. Prima di loggarti, tuttavia, devi visitare il seguente link per attivare il tuo account: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Solamente dopo aver visitato il link sopra potrai loggarti con successo!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Se hai problemi di attivazione dell'account, rispondi a questa notifica per ottenere assistenza.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Grazie!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

