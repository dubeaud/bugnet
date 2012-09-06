<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">
    <xsl:output omit-xml-declaration="yes" method="html" />
    <xsl:strip-space elements="*" />
    <xsl:template match="/root">
        <p>
            <xsl:value-of select="NotificationUser/DisplayName" />,
            <br/>
            <br/>
            Uw wachtwoord is gereset naar &#160;<span style="font-family: Courier New; font-weight: bold;">
                <xsl:value-of select="Password" />
            </span>&#160;&#160; Logt u alstublieft
            <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">
                hier
            </a> in.
        </p>
        <p>Houd u er rekening mee dat dit wachtwoord hoofdletter gevoelig is.</p>
        <p>Wanneer u ingelogged bent, kunt u uw wachtwoord wijzigen door op uw gebruikersnaam te klikken en 'wachtwoord' te selecteren.</p>
        <p>
            Dank u wel,
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
