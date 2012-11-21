<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">
    <xsl:output omit-xml-declaration="yes" method="text" />
    <xsl:strip-space elements="*" />
    <xsl:template match="/root">
        <xsl:value-of select="User/DisplayName" />,
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Ваш пароль сброшен на новый &#160;&#160;</xsl:text><xsl:value-of select="Password" />&#160; Войдите в систему здесь <xsl:value-of select="HostSetting_DefaultUrl" />Login.aspx
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Пожалуйста учтите, что пароль чувствителен к регистру.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>После входа в систему Вы можете изменить Ваш пароль, щёлкнув на своё имя в левом верхнем углу и выбрав в меню Пароль.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Спасибо,</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
