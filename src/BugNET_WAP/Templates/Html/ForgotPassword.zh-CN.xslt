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
            有人请求重置<xsl:value-of select="HostSetting_ApplicationTitle" /> 的密码.  请点如下击链接以重置密码:
        </p>
        <a href="{HostSetting_DefaultUrl}Account/PasswordReset.aspx?token={string}" target="_blank">
            <xsl:value-of select="HostSetting_DefaultUrl" />Account/PasswordReset.aspx?token=<xsl:value-of select="string" />
        </a>
        <p>如果你没有请求重置密码, 请忽略此邮件.</p>
        <p>
            谢谢!
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
