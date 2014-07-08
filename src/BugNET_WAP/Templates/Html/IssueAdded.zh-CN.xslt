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
        <p>你关注的项目添加了如下问题.</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top"><b>标题:</b> </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>项目:</b> </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>创建者:</b> </td>
                <td>
                    <xsl:value-of select="Issue/CreatorDisplayName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>里程碑:</b> </td>
                <td>
                    <xsl:value-of select="Issue/MilestoneName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>类别:</b></td>
                <td>
                    <xsl:value-of select="Issue/CategoryName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>优先级:</b> </td>
                <td>
                    <xsl:value-of select="Issue/PriorityName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>类型:</b> </td>
                <td>
                    <xsl:value-of select="Issue/IssueTypeName" disable-output-escaping="yes" />
                </td>
            </tr>
            <tr>
                <td><b>描述:</b> </td>
            </tr>
			<tr>
				<td colspan="2">
                    <xsl:value-of select="Issue/Description" disable-output-escaping="yes" />
                </td>
			</tr>
        </table>
        <p>
            访问如下链接以获得更多信息
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            如果不想继续收到该邮件, 请访问 <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">你的个人设置</a> 并更改“通知”选项.
        </p>
    </xsl:template>
</xsl:stylesheet>
