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
        <h1>欢迎使用 <xsl:value-of select="HostSetting_ApplicationTitle" />!</h1>
		<p>你好, <xsl:value-of select="NotificationUser/DisplayName" disable-output-escaping="yes" />.  你收到此邮件，因为你在 <xsl:value-of select="HostSetting_ApplicationTitle" />注册了新用户. 在登录之前, 
		请访问如下链接激活该账户: </p>
		<p>
      <a href="{string}" target="_blank">
        <xsl:value-of select="string" />
      </a>
		</p>
		<p>激活之后，您就可以访问网站的服务!</p>
		<p>如果您遇到任何问题, 您都可以回复此邮件以寻求帮助.</p>
		<p>谢谢!</p>
    </xsl:template>
</xsl:stylesheet>
