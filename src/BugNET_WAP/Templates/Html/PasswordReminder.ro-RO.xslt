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
    <span><xsl:value-of select="NotificationUser/DisplayName" />,</span>
    <br/>
    <br/>
    <span>Aici gasiti parola ceruta </span><span style="font-family: Courier New; font-weight: bold;"><xsl:value-of select="NotificationUser/Password" /></span>
    <br/>
    <br/>
    <span>Va rugam sa va autentificati <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">aici.</a></span>
    <br/>
    <br/>
    <span>Va rog sa tineti cont de faptul ca parola este case-sensitive.</span>
    <br/>
    <span>Odata ce v-ati autentificat, puteti sa va modificati parola apasand click pe numele d-voastra in partea stanga sus si selectand parola in meniul din stanga.</span>
    <br/>
    <br/>
    <span>Va multumim,</span>
    <br/>
    <span><xsl:value-of select="HostSetting_ApplicationTitle" /></span>
  </xsl:template>
</xsl:stylesheet>
