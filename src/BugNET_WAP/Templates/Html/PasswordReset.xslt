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
            Your password has been reset to &#160;<span style="font-family: Courier New; font-weight: bold;">
                <xsl:value-of select="Password" />
            </span>&#160;&#160; Please login
            <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">
                here.
            </a>
        </p>
        <p>Please note that this password is case-sensitive.</p>
        <p>Once you are logged in, you can modify your password by clicking your username and selecting password.</p>
        <p>
            Thank you,
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
