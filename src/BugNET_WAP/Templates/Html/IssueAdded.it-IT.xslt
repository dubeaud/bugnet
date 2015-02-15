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
        <p>La seguente segnalazione è stata aggiunta ad un progetto al quale stai partecipando.</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top"><b>Title:</b> </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Progetto:</b> </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Autore:</b> </td>
                <td>
                    <xsl:value-of select="Issue/CreatorDisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Passo:</b> </td>
                <td>
                    <xsl:value-of select="Issue/MilestoneName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Categoria:</b></td>
                <td>
                    <xsl:value-of select="Issue/CategoryName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Priorità:</b> </td>
                <td>
                    <xsl:value-of select="Issue/PriorityName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Tipo:</b> </td>
                <td>
                    <xsl:value-of select="Issue/IssueTypeName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>Descrizione:</b> </td>
            </tr>
			<tr>
				<td colspan="2">
                    <xsl:value-of select="Issue/Description" disable-output-escaping="yes" />
                </td>
			</tr>
        </table>
        <p>
            Puoi trovare maggiori informazioni su questa segnalazione su
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            Se non desideri ricevere più notifiche, visita <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">your profile</a> e modifica le opzioni di notifica.
        </p>
    </xsl:template>
</xsl:stylesheet>
