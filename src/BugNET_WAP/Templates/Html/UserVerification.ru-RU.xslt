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
        <h1>Добро пожаловать в приложение &quot;<xsl:value-of select="HostSetting_ApplicationTitle" />&quot;!</h1>
        <p>Здравствуйте, <xsl:value-of select="User/DisplayName" disable-output-escaping="yes" />.  Вы получили это письмо, так как недавно
        создали учётную запись в приложении &quot;<xsl:value-of select="HostSetting_ApplicationTitle" />&quot;. Пройдите по следующей ссылке
        для подтверждения Вашей учётной записи: </p>
        <p>
            <a href="{HostSetting_DefaultUrl}Account/Verify.aspx?ID={NotificationUser/Id}" target="_blank">
                <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
            </a>
        </p>
        <p>После подтверждения учётной записи Вы сможете войти в систему!</p>
        <p>Если у Вас возникли проблемы с подтверждением учётной записи, ответьте на данное письмо для связи с администратором системы.</p>
        <p>Спасибо!</p>
    </xsl:template>
</xsl:stylesheet>
