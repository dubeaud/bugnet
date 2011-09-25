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
    <xsl:text>The following user has just registered:</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Date: </xsl:text><xsl:value-of select="helpers:FormatShortDateAnd12HTime(User/CreationDate)" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Name: </xsl:text><xsl:value-of select="User/DisplayName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Username: </xsl:text><xsl:value-of select="User/UserName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Email: </xsl:text><xsl:value-of select="User/Email" />
  </xsl:template>
</xsl:stylesheet>
