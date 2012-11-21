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
        <p>Вам назначено новое задание:</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top">
                    <b>Название:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/Title"  disable-output-escaping="yes"/>
                </td>
            </tr>
            <tr>
                <td>
                    <b>Проект:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/ProjectName" disable-output-escaping="yes" />
                </td>
            </tr>
        </table>
        <p>
            Больше информации по данному заданию можно найти по ссылке
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            Если Вы больше не хотите получать уведомления, то откройте <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">Ваш профиль</a> и измените настройки уведомлений.
        </p>
    </xsl:template>
</xsl:stylesheet>
