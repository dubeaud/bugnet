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
        <p>A new comment has been added to the following issue.</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top">
                    <b>Title:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Project:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Created By:</b>
                </td>
                <td>
                    <xsl:value-of select="IssueComment/CreatorDisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>Date:</b>
                </td>
                <td>
                    <xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
                </td>
            </tr>
            <tr>
                <td><b>Comment:</b> </td>          
            </tr>
            <tr>
                <td colspan="2">
                    <xsl:value-of select="IssueComment/Comment" disable-output-escaping="yes" />
                </td>
            </tr>
        </table>       
        <p>
            More information on this issue can be found at
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            If you no longer wish to receive notifications, please visit <a href="{HostSetting_DefaultUrl}UserProfile.aspx" target="_blank">your profile</a> and change your notifications options.
        </p>
    </xsl:template>
</xsl:stylesheet>
