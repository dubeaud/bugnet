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
            Parola d-voastra a fost resetata la &#160;<span style="font-family: Courier New; font-weight: bold;">
                <xsl:value-of select="Password" />
            </span>&#160;&#160; Autentificati-va
            <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">
                aici.
            </a>
        </p>
        <p>Va rugam sa aveti in vedere ca parola este case-sensitive.</p>
        <p>Odata autentificat, puteti sa modificati parola apasand click pe nume d-voastra in stanga sus si alegeti Parola.</p>
        <p>
            Va multumim,
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
