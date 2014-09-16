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
        <xsl:text>Добро пожаловать в приложение </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Здравствуйте, </xsl:text><xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />
        <xsl:text>.  Вы получили это письмо, так как недавно создали учётную запись в приложении </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>. Пройдите по следующей ссылке для подтверждения Вашей учётной записи: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="string" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>После подтверждения учётной записи Вы сможете войти в систему!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Если у Вас возникли проблемы с подтверждением учётной записи, ответьте на данное письмо для связи с администратором системы.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Спасибо!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

