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
        <p>如下问题有新的评论.</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top">
                    <b>标题:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>项目:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>创建者:</b>
                </td>
                <td>
                    <xsl:value-of select="IssueComment/CreatorDisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td>
                    <b>日期:</b>
                </td>
                <td>
                    <xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
                </td>
            </tr>
            <tr>
                <td><b>评论:</b> </td>          
            </tr>
            <tr>
                <td colspan="2">
                    <xsl:value-of select="IssueComment/Comment" disable-output-escaping="yes" />
                </td>
            </tr>
        </table>       
        <p>
            更多详细信息，请访问
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            如果不想继续收到此类通知，请访问 <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">你的个人设定</a> 并更改“通知”选项
        </p>
    </xsl:template>
</xsl:stylesheet>
