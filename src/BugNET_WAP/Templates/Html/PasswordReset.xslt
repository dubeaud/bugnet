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
        <p>This email confirms that you have changed the password for your <xsl:value-of select="HostSetting_ApplicationTitle" /> account.</p>
        <p>If you did not change the password, please contact  <xsl:value-of select="HostSetting_ApplicationTitle" /> for assistance.</p>
        <p>
            Thank you!
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
