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
            Someone has requested a password reset for your <xsl:value-of select="HostSetting_ApplicationTitle" /> account.  To reset your password, simply click on the following link:
        </p>
        <a href="{HostSetting_DefaultUrl}Account/PasswordReset.aspx?token={string}" target="_blank">
            <xsl:value-of select="HostSetting_DefaultUrl" />Account/PasswordReset.aspx?token=<xsl:value-of select="string" />
        </a>
        <p>If you did not request this password reset, then no action is required and you can ignore this email.</p>
        <p>
            Thank you!
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
