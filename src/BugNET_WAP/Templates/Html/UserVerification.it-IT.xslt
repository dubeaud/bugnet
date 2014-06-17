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
        <h1>Benvenuto in <xsl:value-of select="HostSetting_ApplicationTitle" />!</h1>
		<p>Ciao, <xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />.
		Stai ricevendo questa notifica perché hai recentemente creato un nuovo account su <xsl:value-of select="HostSetting_ApplicationTitle" />.
		Prima di loggarti, tuttavia, devi visitare il seguente link per attivare il tuo account:
		</p>
		<p>
			<a href="{HostSetting_DefaultUrl}Account/Verify.aspx?ID={NotificationUser/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
            </a>
		</p>
		<p>Solamente dopo aver visitato il link sopra potrai loggarti con successo!</p>
		<p>Se hai problemi di attivazione dell'account, rispondi a questa notifica per ottenere assistenza.</p>
		<p>Grazie!</p>
    </xsl:template>
</xsl:stylesheet>
