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
    <xsl:text>Het volgende punt is aan u toegewezen:</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Titel: </xsl:text><xsl:value-of select="Issue/Title" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Project: </xsl:text><xsl:value-of select="Issue/ProjectName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
      <xsl:text> Meer informatie over dit punt kunt u vinden via de volgende link </xsl:text>
      <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      Als u geen meldingen meer wenst te ontvangen, ga dan naar <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx en wijzig uw meldings opties.
  </xsl:template>
</xsl:stylesheet>
