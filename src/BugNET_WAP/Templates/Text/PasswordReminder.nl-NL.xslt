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
    <xsl:value-of select="NotificationUser/DisplayName" />,
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Here is your requested password </xsl:text><xsl:value-of select="NotificationUser/Password" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Please login here </xsl:text><xsl:value-of select="HostSetting_DefaultUrl" /><xsl:text>Account/Login.aspx</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Please note that this password is case-sensitive.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Once you are logged in, you can modify your password by clicking your name in the top left corner of the page and then selecting Password in the left menu.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Thank you,</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:value-of select="HostSetting_ApplicationTitle" />
  </xsl:template>
</xsl:stylesheet>
