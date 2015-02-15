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
    <!-- this is the data structure that is passed in -->
    <!--root>
    <MailboxEntry>
      <Content />
      <Date/>
      <Title/>
      <From/>
      <ProjectMailbox>
        <Id/>
        <Mailbox/>
        <ProjectId/>
        <AssignToId/>
        <IssueTypeId/>
        <AssignToDisplayName/>
        <AssignToUserName/>
        <IssueTypeName/>
      </ProjectMailbox>
    </MailboxEntry>
  </root-->
    <p>The following issue has been added via the Mailbox Reader.</p>
    <table border="0">
      <tr>
        <td width="90px" valign="top">
          <b>Mailbox:</b>
        </td>
        <td width="90px" valign="top">
          <xsl:value-of select="MailboxEntry/ProjectMailbox/Mailbox" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td width="90px" valign="top">
          <b>From:</b>
        </td>
        <td width="90px" valign="top">
          <xsl:value-of select="MailboxEntry/From" disable-output-escaping="yes" />
        </td>
      </tr>
      <tr>
        <td width="90px" valign="top">
          <b>Delivered On:</b>
        </td>
        <td width="90px" valign="top">
          <xsl:value-of select="helpers:FormatShortDateAnd12HTime(MailboxEntry/Date)" disable-output-escaping="yes" />
        </td>
      </tr>
    </table>
    <hr/>
    <p>
      <xsl:value-of select="MailboxEntry/Content" disable-output-escaping="yes" />
    </p>
  </xsl:template>
</xsl:stylesheet>