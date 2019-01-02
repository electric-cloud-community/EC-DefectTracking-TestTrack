package ttsoapcgi;

my $url = "http://localhost";

sub SOAP::Serializer::as_int {
    my $self = shift;
    my($value, $name, $type, $attr) = @_;

    return [$name, {'xsi:type' => 'xsd:boolean', %$attr}, 'true'] if ($name =~ /^(is|has|affects|betasite)/ && $value == 1);
    return [$name, {'xsi:type' => 'xsd:boolean', %$attr}, 'false'] if ($name =~ /^(is|has|affects|betasite)/ && $value == 0);

    for (qw(eventaddorder showorder testconfigtype)) {
        return [$name, {'xsi:type' => 'xsd:short', %$attr}, $value] if $name eq $_;
    }

    for (qw(recordid cookie)) {
        return [$name, {'xsi:type' => 'xsd:long', %$attr}, $value] if $name eq $_;
    }

    return [$name, {'xsi:type' => 'xsd:int', %$attr}, $value];
}

sub SOAP::Serializer::as_dateTime {
    my $self = shift;
    my($value, $name, $type, $attr) = @_;
    return [$name, {'xsi:type' => 'xsd:dateTime', %$attr}, $value];
}


sub ttpro {
   my $self = shift;
   $url = shift;
   my $schema = 'http://www.w3.org/2001/XMLSchema';
   $self->typelookup->{dateTime} = [15, sub {$_[0] =~ /^\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d-\d\d:\d\d$/ }, 'as_dateTime'];
   $self->xmlschema($schema)->readable(1);
   return $self;
}


my %methods = (
  deleteTaskByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTaskByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  editTestCaseByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestCaseByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  saveRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pRequirement', type => 'ttns:CRequirement', attr => {}),
    ],
  },
  getAttachmentTypes => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getAttachmentTypes',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getRequirementDocumentByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRequirementDocumentByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getRecordListForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRecordListForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'filtername', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'columnlist', type => 'ttns:ArrayOfCTableColumn', attr => {}),
    ],
  },
  formattedTextSupport => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'enableFormattedText', type => 'xsd:boolean', attr => {}),
    ],
  },
  getUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  saveFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pFolder', type => 'ttns:CFolder', attr => {}),
    ],
  },
  deleteUserByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteUserByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  addEntityToFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addEntityToFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'entityRecordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'entityTableName', type => 'xsd:string', attr => {}),
    ],
  },
  cancelSaveFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  cancelSaveLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'linkID', type => 'xsd:long', attr => {}),
    ],
  },
  addGlobalCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pUser', type => 'ttns:CGlobalUser', attr => {}),
    ],
  },
  deleteRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDeleteAssociatedRequirements', type => 'xsd:boolean', attr => {}),
    ],
  },
  getTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testRunNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getCustomerByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getCustomerByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  addTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTestConfig', type => 'ttns:CSystem', attr => {}),
    ],
  },
  getTestVariantTypes => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestVariantTypes',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'defectNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getRootPublicFolderPath => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRootPublicFolderPath',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  editTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  deleteTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testRunNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  editRequirementByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editRequirementByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  DatabaseLogoff => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#DatabaseLogoff',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getEventDefinitionList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getEventDefinitionList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
    ],
  },
  cancelSaveRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getProjectDataOptionList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
    ],
  },
  cancelSaveDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  editTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testCaseNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  addRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pRequirement', type => 'ttns:CRequirement', attr => {}),
    ],
  },
  saveDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pDefect', type => 'ttns:CDefect', attr => {}),
    ],
  },
  saveTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTask', type => 'ttns:CTask', attr => {}),
    ],
  },
  getReportRunResultsByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getReportRunResultsByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  deleteFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
    ],
  },
  getFolderPathSeparator => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFolderPathSeparator',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  GetLinkDefinitionValues => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#GetLinkDefinitionValues',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  saveRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pRequirementDocument', type => 'ttns:CRequirementDocument', attr => {}),
    ],
  },
  deleteTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
    ],
  },
  getTestRunStepsModes => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestRunStepsModes',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  addUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pUser', type => 'ttns:CUser', attr => {}),
    ],
  },
  saveTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTestRun', type => 'ttns:CTestRun', attr => {}),
    ],
  },
  deleteTestRunByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestRunByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getTaskByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTaskByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  deleteTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testCaseNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDeleteAssociatedTestRuns', type => 'xsd:boolean', attr => {}),
    ],
  },
  editTestRunByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestRunByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  addLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pLink', type => 'ttns:CLink', attr => {}),
    ],
  },
  saveCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'pCustomer', type => 'ttns:CUser', attr => {}),
    ],
  },
  addCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pCustomer', type => 'ttns:CUser', attr => {}),
    ],
  },
  getTableList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTableList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  editRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getFilterList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFilterList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  editDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'defectNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  deleteFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'folderPath', type => 'xsd:string', attr => {}),
    ],
  },
  getTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
    ],
  },
  editFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
    ],
  },
  addDefectWithLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addDefectWithLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pDefect', type => 'ttns:CDefect', attr => {}),
      SOAP::Data->new(name => 'testRunRecordID', type => 'xsd:long', attr => {}),
    ],
  },
  cancelSaveTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  removeEntityFromFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#removeEntityFromFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
      SOAP::Data->new(name => 'entity', type => 'ttns:CFolderItem', attr => {}),
    ],
  },
  getTestCaseByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestCaseByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  addFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pFolder', type => 'ttns:CFolder', attr => {}),
    ],
  },
  deleteRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  editTestConfigByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestConfigByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  ProjectLogon => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#ProjectLogon',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'pProj', type => 'ttns:CProject', attr => {}),
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
    ],
  },
  appendToRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#appendToRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'parentRequirementID', type => 'xsd:long', attr => {}),
    ],
  },
  getRequirementByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRequirementByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testCaseNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  deleteLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'linkID', type => 'xsd:long', attr => {}),
    ],
  },
  deleteDefectByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteDefectByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  editFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'folderPath', type => 'xsd:string', attr => {}),
    ],
  },
  addGlobalUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pUser', type => 'ttns:CGlobalUser', attr => {}),
    ],
  },
  changeRequirementType => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#changeRequirementType',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'newTypeName', type => 'xsd:string', attr => {}),
    ],
  },
  getTestRunByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestRunByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getDropdownFieldForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDropdownFieldForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
    ],
  },
  deleteCustomerByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteCustomerByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getRequirementIDsForDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRequirementIDsForDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentID', type => 'xsd:long', attr => {}),
    ],
  },
  getRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  deleteRequirementByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteRequirementByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getDocumentIDsForRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDocumentIDsForRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementID', type => 'xsd:long', attr => {}),
    ],
  },
  cancelSaveRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  DatabaseLogon => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#DatabaseLogon',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'dbname', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
    ],
  },
  getAttachment => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getAttachment',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'eventID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pszArchiveName', type => 'xsd:string', attr => {}),
    ],
  },
  generateTestRuns => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#generateTestRuns',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testVariants', type => 'ttns:ArrayOfCTestRunVariantField', attr => {}),
      SOAP::Data->new(name => 'testRunSet', type => 'xsd:string', attr => {}),
    ],
  },
  promoteCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'localCustomer', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'globalUser', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'loginname', type => 'xsd:string', attr => {}),
    ],
  },
  addDropdownFieldValuesForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addDropdownFieldValuesForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'fieldname', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'pValueList', type => 'ttns:ArrayOfCFieldValue', attr => {}),
    ],
  },
  getLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'linkID', type => 'xsd:long', attr => {}),
    ],
  },
  editRequirementDocumentByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editRequirementDocumentByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  cancelSaveCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getDropdownFieldValuesForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDropdownFieldValuesForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'fieldname', type => 'xsd:string', attr => {}),
    ],
  },
  editRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  deleteUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  editCustomerByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editCustomerByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  addTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTestCase', type => 'ttns:CTestCase', attr => {}),
    ],
  },
  getColumnsForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getColumnsForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
    ],
  },
  addDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pDefect', type => 'ttns:CDefect', attr => {}),
    ],
  },
  getFolder => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFolder',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'path', type => 'xsd:string', attr => {}),
    ],
  },
  getFolderTypeByName => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFolderTypeByName',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
    ],
  },
  getDefectAttachment => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDefectAttachment',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pszArchiveName', type => 'xsd:string', attr => {}),
    ],
  },
  cancelSaveTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getFolderTypeList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFolderTypeList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
    ],
  },
  getDatabaseList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDatabaseList',
    uri => 'urn:testtrack-interface',
    parameters => [
    ],
  },
  getEntityListForFolderByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getEntityListForFolderByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'publicFolder', type => 'xsd:boolean', attr => {}),
    ],
  },
  getReportRunResultsByName => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getReportRunResultsByName',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
    ],
  },
  deleteTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  deleteDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'defectNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
    ],
  },
  editTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'testRunNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  saveUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'pUser', type => 'ttns:CUser', attr => {}),
    ],
  },
  getGlobalCustomerList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getGlobalCustomerList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getUserLicenseList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getUserLicenseList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  createSnapshot => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#createSnapshot',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'documentID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'snapshot', type => 'ttns:CSnapshotInfo', attr => {}),
    ],
  },
  saveTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTestConfig', type => 'ttns:CSystem', attr => {}),
    ],
  },
  getDefectCustomFieldsDefinitionList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDefectCustomFieldsDefinitionList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  saveLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pLink', type => 'ttns:CLink', attr => {}),
    ],
  },
  editUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  getCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  cancelSaveUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveUser',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getDefectEventDefinitionList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDefectEventDefinitionList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  editTaskByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTaskByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getLinksForItem => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getLinksForItem',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'itemRecordID', type => 'xsd:long', attr => {}),
    ],
  },
  addRequirementDocument => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addRequirementDocument',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pRequirementDocument', type => 'ttns:CRequirementDocument', attr => {}),
    ],
  },
  promoteUser => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => '',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'localUser', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'globalUser', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'loginname', type => 'xsd:string', attr => {}),
    ],
  },
  cancelSaveTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  editDefectByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editDefectByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  cancelSaveTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#cancelSaveTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  editUserByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editUserByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  deleteTestConfigByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestConfigByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  createDefectForTestRun => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#createDefectForTestRun',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getGlobalUserList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getGlobalUserList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
  getDefectByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getDefectByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  getFilterListForTable => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getFilterListForTable',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
    ],
  },
  editTestConfig => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editTestConfig',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'name', type => 'xsd:string', attr => {}),
    ],
  },
  deleteRequirementDocumentByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteRequirementDocumentByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDeleteAssociatedRequirements', type => 'xsd:boolean', attr => {}),
    ],
  },
  editLink => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editLink',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'linkID', type => 'xsd:long', attr => {}),
    ],
  },
  getRequirement => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRequirement',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'requirementNumber', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'summary', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'bDownloadAttachments', type => 'xsd:boolean', attr => {}),
    ],
  },
  editCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#editCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  deleteTestCaseByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteTestCaseByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'bDeleteAssociatedTestRun', type => 'xsd:boolean', attr => {}),
    ],
  },
  getProjectList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getProjectList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'username', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'password', type => 'xsd:string', attr => {}),
    ],
  },
  getUserByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getUserByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getLinksForDefect => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getLinksForDefect',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'defectRecordID', type => 'xsd:long', attr => {}),
    ],
  },
  getCustomFieldsDefinitionList => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getCustomFieldsDefinitionList',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'tablename', type => 'xsd:string', attr => {}),
    ],
  },
  saveTestCase => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#saveTestCase',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTestCase', type => 'ttns:CTestCase', attr => {}),
    ],
  },
  addTask => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#addTask',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'pTask', type => 'ttns:CTask', attr => {}),
    ],
  },
  deleteCustomer => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#deleteCustomer',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'firstName', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'middleInitials', type => 'xsd:string', attr => {}),
      SOAP::Data->new(name => 'lastName', type => 'xsd:string', attr => {}),
    ],
  },
  getTestConfigByRecordID => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getTestConfigByRecordID',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
      SOAP::Data->new(name => 'recordID', type => 'xsd:long', attr => {}),
    ],
  },
  getRootPrivateFolderPath => {
    endpoint => "$url/cgi-bin/ttsoapcgi.exe",
    soapaction => 'urn:testtrack-interface#getRootPrivateFolderPath',
    uri => 'urn:testtrack-interface',
    parameters => [
      SOAP::Data->new(name => 'cookie', type => 'xsd:long', attr => {}),
    ],
  },
);

use SOAP::Lite;
use Exporter;
use Carp ();

use vars qw(@ISA $AUTOLOAD @EXPORT_OK %EXPORT_TAGS);
@ISA = qw(Exporter SOAP::Lite);
@EXPORT_OK = (keys %methods);
%EXPORT_TAGS = ('all' => [@EXPORT_OK]);

no strict 'refs';
for my $method (@EXPORT_OK) {
  my %method = %{$methods{$method}};
  *$method = sub {
    my $self = UNIVERSAL::isa($_[0] => __PACKAGE__) 
      ? ref $_[0] ? shift # OBJECT
                  # CLASS, either get self or create new and assign to self
                  : (shift->self || __PACKAGE__->self(__PACKAGE__->new))
      # function call, either get self or create new and assign to self
      : (__PACKAGE__->self || __PACKAGE__->self(__PACKAGE__->new));
    $self->proxy($method{endpoint} || Carp::croak "No server address (proxy) specified") unless $self->proxy;
    my @templates = @{$method{parameters}};
    my $som = $self
      -> endpoint($method{endpoint})
      -> uri($method{uri})
      -> on_action(sub{qq!"$method{soapaction}"!})
      -> call($method => map {@templates ? shift(@templates)->value($_) : $_} @_); 
    UNIVERSAL::isa($som => 'SOAP::SOM') ? wantarray ? $som->paramsall : $som->result 
                                        : $som;
  }
}

sub AUTOLOAD {
  my $method = substr($AUTOLOAD, rindex($AUTOLOAD, '::') + 2);
  return if $method eq 'DESTROY';

  die "Unrecognized method '$method'. List of available method(s): @EXPORT_OK\n";
}

1;
