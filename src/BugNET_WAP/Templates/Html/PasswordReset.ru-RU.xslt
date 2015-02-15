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
        <p>
            <xsl:value-of select="User/DisplayName" />,
            <br/>
            <br/>
            Ваш пароль сброшен на новый &#160;<span style="color:blue;font-weight:bold;">
                <xsl:value-of select="Password" />
            </span>&#160;&#160; Войдите в систему
            <a href="{HostSetting_DefaultUrl}Login.aspx" target="_blank">
                здесь.
            </a>
        </p>
        <p>Пожалуйста учтите, что пароль чувствителен к регистру.</p>
        <p>После входа в систему Вы можете изменить Ваш пароль, щёлкнув на своё имя в левом верхнем углу и выбрав в меню &quot;Пароль&quot;.</p>
        <p>
            Спасибо,
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
