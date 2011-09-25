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
        <h1>Welcome to <xsl:value-of select="HostSetting_ApplicationTitle" />!</h1>
		<p>Hello, <xsl:value-of select="User/DisplayName" disable-output-escaping="yes" />.  You are receiving this email because you recently created
		a new account at <xsl:value-of select="User/DisplayName" disable-output-escaping="yes" />. Before you can login, however, you need to first visit the following link 
		to confirm your account: </p>
		<p>
			<a href="{HostSetting_DefaultUrl}Verify.aspx?ID={User/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Verify.aspx?ID=<xsl:value-of select="User/Id" />
            </a>
		</p>
		<p>After visiting the above link you can log into the site!</p>
		<p>If you have any problems verifying your account, please reply to this email to get assistance.</p>
		<p>Thanks!</p>
    </xsl:template>
</xsl:stylesheet>

