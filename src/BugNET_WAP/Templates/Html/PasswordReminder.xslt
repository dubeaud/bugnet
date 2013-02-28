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
    <span>Here is your requested password </span><span style="font-family: Courier New; font-weight: bold;"><xsl:value-of select="NotificationUser/Password" /></span>
    <br/>
    <br/>
    <span>Please login <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">here.</a></span>
    <br/>
    <br/>
    <span>Please note that this password is case-sensitive.</span>
    <br/>
    <span>Once you are logged in, you can modify your password by clicking your name in the top left corner of the page and then selecting Password in the left menu.</span>
    <br/>
    <br/>
    <span>Thank you,</span>
    <br/>
    <span><xsl:value-of select="HostSetting_ApplicationTitle" /></span>
  </xsl:template>
</xsl:stylesheet>
