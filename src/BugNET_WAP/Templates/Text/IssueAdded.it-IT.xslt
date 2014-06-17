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
        <xsl:text>La seguente segnalazione è stata aggiunta ad un progetto al quale stai partecipando.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Titolo: </xsl:text><xsl:value-of select="Issue/Title" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Progetto: </xsl:text><xsl:value-of select="Issue/ProjectName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Autore: </xsl:text> <xsl:value-of select="Issue/CreatorDisplayName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Passo: </xsl:text><xsl:value-of select="Issue/MilestoneName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Categoria: </xsl:text><xsl:value-of select="Issue/CategoryName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Priorità: </xsl:text> <xsl:value-of select="Issue/PriorityName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Tipo: </xsl:text><xsl:value-of select="Issue/IssueTypeName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Descrizione: </xsl:text><xsl:value-of select="helpers:StripHTML2(Issue/Description)" />
        <xsl:text>&#10;</xsl:text>
		    <xsl:text>&#10;</xsl:text>
        <xsl:text> Puoi trovare maggiori informazioni su questa segnalazione su </xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        Se non desideri ricevere più notifiche, visita <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx e modifica le opzioni di notifica.
    </xsl:template>
</xsl:stylesheet>
