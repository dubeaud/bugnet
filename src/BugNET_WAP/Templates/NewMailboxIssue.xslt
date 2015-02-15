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
      <HostSetting_EnabledNotificationTypes/>
      <HostSetting_Pop3Username/>
      <HostSetting_Version/>
      <HostSetting_SMTPAuthentication/>
      <HostSetting_Pop3InlineAttachedPictures/>
      <HostSetting_AnonymousAccess/>
      <HostSetting_ApplicationDefaultLanguage/>
      <HostSetting_Pop3ReportingUsername/>
      <HostSetting_SMTPPassword />
      <HostSetting_SMTPDomain />
      <HostSetting_Pop3BodyTemplate/>
      <HostSetting_FileSizeLimit/>
      <HostSetting_RepositoryBackupPath />
      <HostSetting_Pop3DeleteAllMessages/>
      <HostSetting_EnableGravatar/>
      <HostSetting_EmailErrors/>
      <HostSetting_SMTPUseSSL/>
      <HostSetting_OpenIdAuthentication/>
      <HostSetting_SMTPPort/>
      <HostSetting_Pop3Port/>
      <HostSetting_SMTPEMailFormat/>
      <HostSetting_ADPassword />
      <HostSetting_Pop3Interval/>
      <HostSetting_Pop3ReaderEnabled/>
      <HostSetting_UserRegistration/>
      <HostSetting_Pop3Server/>
      <HostSetting_RepositoryRootPath/>
      <HostSetting_ADPath/>
      <HostSetting_Pop3Password/>
      <HostSetting_Pop3UseSSL/>
      <HostSetting_Pop3ProcessAttachments/>
      <HostSetting_RepositoryRootUrl/>
      <HostSetting_DefaultUrl/>
      <HostSetting_UserAccountSource/>
      <HostSetting_SvnHookPath />
      <HostSetting_ADUserName />
      <HostSetting_HostEmailAddress/>
      <HostSetting_SvnAdminEmailAddress />
      <HostSetting_EnableRepositoryCreation/>
      <HostSetting_ErrorLoggingEmailAddress/>
      <HostSetting_SMTPUsername/>
      <HostSetting_SMTPServer/>
      <HostSetting_AllowedFileExtensions/>
      <HostSetting_ApplicationTitle/>
      <HostSetting_SMTPEmailTemplateRoot/>
      <HostSetting_AdminNotificationUsername/>
      <HostSetting_WelcomeMessage/>
      <MailboxEntry>
        <Content/>
        <Date/>
        <Title/>
        <From/>
        <AttachmentsSavedCount/>
        <WasProcessed/>
        <IsHtml/>
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
        <Project>
          <Id/>
          <AllowIssueVoting/>
          <AttachmentStorageType/>
          <Code/>
          <ManagerId/>
          <CreatorUserName/>
          <CreatorDisplayName/>
          <Disabled/>
          <Name/>
          <Description/>
          <DateCreated/>
          <ManagerUserName/>
          <ManagerDisplayName/>
          <UploadPath/>
          <AccessType/>
          <AllowAttachments/>
          <SvnRepositoryUrl />
        </Project>
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