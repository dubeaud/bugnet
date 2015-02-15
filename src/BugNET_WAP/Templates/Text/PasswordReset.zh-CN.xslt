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
        <xsl:text>此邮件通知 </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />&#160; 的密码已经被重置.
        <xsl:text>&#10;</xsl:text>
        <xsl:text>如果不是你更改了密码, 请尽快向 </xsl:text> <xsl:value-of select="HostSetting_ApplicationTitle" /> 寻求帮助.
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>谢谢,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
