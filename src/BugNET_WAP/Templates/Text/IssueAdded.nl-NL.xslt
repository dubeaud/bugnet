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
        <xsl:text>Het volgende punt is toegevoegd aan een project dat u volgt.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Titel: </xsl:text><xsl:value-of select="Issue/Title" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Project: </xsl:text><xsl:value-of select="Issue/ProjectName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Aangemaakt door: </xsl:text> <xsl:value-of select="Issue/CreatorDisplayName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Mijlpaal: </xsl:text><xsl:value-of select="Issue/MilestoneName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Categorie: </xsl:text><xsl:value-of select="Issue/CategoryName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Prioriteit: </xsl:text> <xsl:value-of select="Issue/PriorityName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Type: </xsl:text><xsl:value-of select="Issue/IssueTypeName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Omschrijving: </xsl:text><xsl:value-of select="helpers:StripHTML2(Issue/Description)" />
        <xsl:text>&#10;</xsl:text>
		    <xsl:text>&#10;</xsl:text>
        <xsl:text> Meer informatie over dit punt kunt u vinden via de volgende link </xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        Als u geen meldingen meer wenst te ontvangen, ga dan naar <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx en wijzig uw meldings opties.
    </xsl:template>
</xsl:stylesheet>
