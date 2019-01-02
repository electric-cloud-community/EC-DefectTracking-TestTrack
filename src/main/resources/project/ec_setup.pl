my $projPrincipal = "project: $pluginName";
my $baseProj = '$[/plugins/EC-DefectTracking/project]';
if ($promoteAction eq 'promote') {
    $batch->setProperty("/plugins/EC-DefectTracking/project/defectTracking_types/@PLUGIN_KEY@", 'TestTrack');
    my $xpath = $commander->getAclEntry("user", $projPrincipal, {projectName => $baseProj});
    if ($xpath->findvalue('//code') eq 'NoSuchAclEntry') {
        $batch->createAclEntry('user', $projPrincipal, {projectName => $baseProj, executePrivilege => 'allow'});
    }
} elsif ($promoteAction eq 'demote') {
    $batch->deleteProperty("/plugins/EC-DefectTracking/project/defectTracking_types/@PLUGIN_KEY@");
    my $xpath = $commander->getAclEntry('user', $projPrincipal, {projectName => $baseProj});
    if ($xpath->findvalue('//principalName') eq $projPrincipal) {
        $batch->deleteAclEntry('user', $projPrincipal, {projectName => $baseProj});
    }
}

# Data that drives the create step picker registration for this plugin.
my $defectSystem = "TestTrack";
my %createStep = (
    label       => "$defectSystem - Create Defects",
    procedure   => "CreateDefects",
    description => "Create $defectSystem defects based on test failures in a job.",
    category    => "Defect Tracking"
);
my %linkStep = (
    label       => "$defectSystem - Link Defects",
    procedure   => "LinkDefects",
    description => "Link existing $defectSystem defects to a job.",
    category    => "Defect Tracking"
);
my %updateStep = (
    label       => "$defectSystem - Update Defects",
    procedure   => "UpdateDefects",
    description => "Automatically update defects in $defectSystem.",
    category    => "Defect Tracking"
);
my %fileDefect = (
    label       => "$defectSystem - File Defect",
    procedure   => "FileDefect",
    description => "...",
    category    => "Defect Tracking"
);
my %fileDefectProcedure = (
    label       => "$defectSystem - File Defect Procedure",
    procedure   => "FileDefectProcedure",
    description => "...",
    category    => "Defect Tracking"
);
$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestTrack - Create Defects");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestTrack - Link Defects");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestTrack - File Defect");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestTrack - File Defect Procedure");

@::createStepPickerSteps = (\%createStep, \%linkStep, \%updateStep, \%fileDefect, \%fileDefectProcedure);
