<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">
  <xsl:output omit-xml-declaration="yes" method="html" />
  <xsl:strip-space elements="*" />
  <xsl:template match="/root">
    <span><xsl:value-of select="NotificationUser/DisplayName" />,</span>
    <br/>
    <br/>
    <span>Запрошенный Вами пароль: </span><span style="font-family: Courier New; font-weight: bold;"><xsl:value-of select="NotificationUser/Password" /></span>
    <br/>
    <br/>
    <span>Войдите в систему <a href="{HostSetting_DefaultUrl}Account/Login.aspx" target="_blank">здесь.</a></span>
    <br/>
    <br/>
    <span>Пожалуйста учтите, что пароль чувствителен к регистру.</span>
    <br/>
    <span>После входа в систему Вы можете изменить Ваш пароль, щёлкнув на своё имя в левом верхнем углу и выбрав в меню &quot;Пароль&quot;.</span>
    <br/>
    <br/>
    <span>Спасибо,</span>
    <br/>
    <span><xsl:value-of select="HostSetting_ApplicationTitle" /></span>
  </xsl:template>
</xsl:stylesheet>
