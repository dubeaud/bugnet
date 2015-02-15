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
    <xsl:text>Un comentariu nou a fost adaugat la urmatoarea problema.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Titlu: </xsl:text><xsl:value-of select="Issue/Title" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Proiect: </xsl:text><xsl:value-of select="Issue/ProjectName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Creat de: </xsl:text><xsl:value-of select="IssueComment/CreatorDisplayName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Data: </xsl:text><xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Comentariu: </xsl:text><xsl:value-of select="helpers:StripHTML2(IssueComment/Comment)" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      <xsl:text> Mai multe informatii puteti gasi la </xsl:text>
      <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
    Daca doriti sa nu mai primiti notificari va rugam sa vizitati <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx si schimbati optiunile de notificare.
  </xsl:template>
</xsl:stylesheet>
