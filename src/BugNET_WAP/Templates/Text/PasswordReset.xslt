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
        <xsl:text>Your password has been reset to &#160;&#160;</xsl:text><xsl:value-of select="Password" />&#160; Please login here. <xsl:value-of select="HostSetting_DefaultUrl" />Account/Login.aspx
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Please note that this password is case-sensitive.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Once you are logged in, you can modify your password by clicking your username and selecting password.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Thank you,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
