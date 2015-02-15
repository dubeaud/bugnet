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
        <p>Следующее задание было обновлено пользователем <xsl:value-of select="Issue/LastUpdateDisplayName" disable-output-escaping="yes" />:</p>
        <table border="0">
            <tr>
                <td width="90px" valign="top">
                    <b>Заголовок:</b>
                </td>
                <td>
                    <xsl:value-of select="Issue/Title" disable-output-escaping="yes" />
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
            <tr>
                <td colspan="2"><b>Изменения:</b></td>
            </tr>
            <tr>
                <td colspan="2">
                    <xsl:if test="count(IssueHistoryChanges/IssueHistory) &gt; 0">
                        <ul>
                            <xsl:for-each select="IssueHistoryChanges/IssueHistory">
                                <li>
                                    <xsl:value-of select="FieldChanged" /> изменено с <b>"<xsl:value-of select="OldValue" disable-output-escaping="yes"/>"</b> на <b>"<xsl:value-of select="NewValue" disable-output-escaping="yes"/>"</b>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </xsl:if>
                </td>
            </tr>
        </table>
        <p>
            Для получения более подробной информации об этом задании пройдите по ссылке
            <a href="{HostSetting_DefaultUrl}Issues/IssueDetail.aspx?id={Issue/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
            </a>
        </p>
        <p style="text-align:center;font-size:8pt;padding:5px;">
            Если Вы больше не хотите получать данные уведомления, то посетите страницу <a href="{HostSetting_DefaultUrl}Account/UserProfile.aspx" target="_blank">Вашего профиля</a> и измените настройки уведомлений.
        </p>
    </xsl:template>
</xsl:stylesheet>
