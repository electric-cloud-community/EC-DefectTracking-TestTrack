####################################################################
#
# ECDefectTracking::TestTrack::Cfg: Object definition of a TestTrack Defect Tracking configuration.
#
####################################################################
package ECDefectTracking::TestTrack::Cfg;
@ISA = (ECDefectTracking::Base::Cfg);
if (!defined ECDefectTracking::Base::Cfg) {
    require ECDefectTracking::Base::Cfg;
}

####################################################################
# Object constructor for ECDefectTracking::TestTrack::Cfg
#
# Inputs
#   cmdr  = a previously initialized ElectricCommander handle
#   name  = a name for this configuration
####################################################################
sub new {
    my $class = shift;
    my $cmdr = shift;
    my $name = shift;
    my($self) = ECDefectTracking::Base::Cfg->new($cmdr,"$name");
    bless ($self, $class);
    return $self;
}

####################################################################
# TestTrackPORT
####################################################################
sub getTestTrackPORT {
    my ($self) = @_;
    return $self->get('TestTrackPORT');
}

sub setTestTrackPORT {
    my ($self, $name) = @_;
    print "Setting TestTrackPORT to $name\n";
    return $self->set('TestTrackPORT', "$name");
}

####################################################################
# Credential
####################################################################
sub getCredential {
    my ($self) = @_;
    return $self->get('Credential');
}
sub setCredential {
    my ($self, $name) = @_;
    print "Setting Credential to $name\n";
    return $self->set('Credential', "$name");
}

####################################################################
# validateCfg
####################################################################
sub validateCfg {
    my ($class, $pluginName, $opts) = @_;
    foreach my $key (keys % {$opts}) {
        print "\nkey=$key, val=$opts->{$key}\n";
    }
}

1;
