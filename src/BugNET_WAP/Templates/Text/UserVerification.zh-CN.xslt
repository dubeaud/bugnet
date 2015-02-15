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
        <xsl:text>欢迎使用 </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />
        <xsl:text>!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Hello, </xsl:text><xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />
        <xsl:text>.  你收到此邮件，因为你在 </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />注册了新用户. 
        <xsl:text>. 在登录之前,请访问如下链接激活该账户: </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/Verify.aspx?ID=<xsl:value-of select="NotificationUser/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>激活之后，您就可以访问网站的服务!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>如果您遇到任何问题, 您都可以回复此邮件以寻求帮助..</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>谢谢!</xsl:text>   
    </xsl:template>
</xsl:stylesheet>

