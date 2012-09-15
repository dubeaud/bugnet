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
        <h1>Welkom bij<xsl:value-of select="HostSetting_ApplicationTitle" />!</h1>
		<p>Hallo, <xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />.  U ontvang deze email omdat u recent een gebruikersaccount heeft aangemaakt op <xsl:value-of select="HostSetting_ApplicationTitle" />. Voordat u kunt inloggen, moet u de volgende link gebruiken om uw account te activeren: </p>
		<p>
			<a href="{HostSetting_DefaultUrl}Account/Verify.aspx?ID={NotificationUser/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
            </a>
		</p>
		<p>Nadat u de bovenstaande link heeft gebruikt kunt u inloggen op de website!</p>
		<p>Als u problemen ondervind met het activeren van uw account, stuur dan een antwoord op dit bericht voor assistentie.</p>
		<p>Dank u wel!</p>
    </xsl:template>
</xsl:stylesheet>
