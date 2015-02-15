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
        <p>此邮件通知 <xsl:value-of select="HostSetting_ApplicationTitle" /> 的密码已经被重置.</p>
        <p>如果不是你更改了密码, 请尽快向 <xsl:value-of select="HostSetting_ApplicationTitle" /> 寻求帮助.</p>
        <p>
            谢谢!
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
