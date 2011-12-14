<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers"
  exclude-result-prefixes="msxsl helpers">

    <xsl:output omit-xml-declaration="yes" method="html" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/root">
        <xsl:text>Welcome to </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Hello, </xsl:text><xsl:value-of select="User/DisplayName" disable-output-escaping="yes" />
        <xsl:text>.  You are receiving this email because you recently created
		a new account at </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>. Before you can login, however, you need to first visit the following link  
		to confirm your account: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="User/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>After visiting the above link you can log into the site!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>If you have any problems verifying your account, please reply to this email to get assistance.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Thanks!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

