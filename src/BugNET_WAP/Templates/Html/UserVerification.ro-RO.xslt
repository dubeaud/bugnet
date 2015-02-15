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
        <h1>Bine ati venit la <xsl:value-of select="HostSetting_ApplicationTitle" />!</h1>
		<p>Buna ziua, <xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />.  Primiti acest email pentru ca ati creat receent
        un cont nou la <xsl:value-of select="HostSetting_ApplicationTitle" />. Inainte de a va autentifica,trebuie sa accesati urmatorul link 
		pentru a confirma contul d-voastra: </p>
		<p>
			<a href="{HostSetting_DefaultUrl}Account/Verify.aspx?ID={NotificationUser/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
            </a>
		</p>
		<p>Dupa ce ati viziatat link-ul de mai sus puteti sa va autentificati pe site!</p>
		<p>Daca aveti probleme in verificarea contului, va rog faceti raspundeti la acest email pentru a primi asistenta.</p>
		<p>Va multumim!</p>
    </xsl:template>
</xsl:stylesheet>
