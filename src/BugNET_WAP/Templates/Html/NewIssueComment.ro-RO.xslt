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
        <p>Un comentariu nou a fost adaugat la urmatoarea problema.</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top">
                    <b>Titlu:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Proiect:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Creata de:</b>
                </td>
                <td>
                    <xsl:value-of select="IssueComment/CreatorDisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Data:</b>
                </td>
                <td>
                    <xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
                </td>
            </tr>
            <tr>
                <td><b>Comentariu:</b> </td>          
            </tr>
            <tr>
                <td colspan="2">
                    <xsl:value-of select="IssueComment/Comment" disable-output-escaping="yes" />
                </td>
            </tr>
        </table>       
        <p>
          Mai multe informatii puteti gasi la
          <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
          Daca doriti sa nu mai primiti notificari va rugam sa vizitati <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">profilul d-voastra</a> si schimbati optiunile de notificare.
        </p>
    </xsl:template>
</xsl:stylesheet>
