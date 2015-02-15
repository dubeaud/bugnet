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
        <xsl:text>Urmatoarea problema a fost adaugata la proiectul pe care-l monitorizati.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Titlu: </xsl:text><xsl:value-of select="Issue/Title" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Proiect: </xsl:text><xsl:value-of select="Issue/ProjectName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Creat De: </xsl:text> <xsl:value-of select="Issue/CreatorDisplayName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Reper: </xsl:text><xsl:value-of select="Issue/MilestoneName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Categorie: </xsl:text><xsl:value-of select="Issue/CategoryName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Prioritate: </xsl:text> <xsl:value-of select="Issue/PriorityName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Tip: </xsl:text><xsl:value-of select="Issue/IssueTypeName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Descriere: </xsl:text><xsl:value-of select="helpers:StripHTML2(Issue/Description)" />
        <xsl:text>&#10;</xsl:text>
		    <xsl:text>&#10;</xsl:text>
        <xsl:text> Mai multe informatii puteti gasi la </xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        Daca doriti sa nu mai primiti notificari va rugam sa vizitati <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx si schimbati optiunile de notificare.
    </xsl:template>
</xsl:stylesheet>
