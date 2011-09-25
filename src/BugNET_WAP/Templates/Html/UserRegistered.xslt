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
        <p>The following user has just registered:</p>
        <table border="0">
            <tr>
                <td width="90px">
                    <b>Date:</b>
                </td>
                <td>
                    <xsl:value-of select="helpers:FormatShortDateAnd12HTime(User/CreationDate)" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Name:</b>
                </td>
                <td>
                    <xsl:value-of select="User/DisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Username:</b> </td>
                <td>
                    <xsl:value-of select="User/UserName" />
                </td>
            </tr>
            <tr>
                <td><b>Email:</b> </td>
                <td>
                    <xsl:value-of select="User/Email" />
                </td>
            </tr>
        </table>
    </xsl:template>
</xsl:stylesheet>
