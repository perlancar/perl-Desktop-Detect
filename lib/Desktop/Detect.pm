package Desktop::Detect;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(detect_desktop); # detect_desktop_cached

#my $dd_cache;
#sub detect_desktop_cached {
#    if (!$dd_cache) {
#        $dd_cache = detect_desktop(@_);
#    }
#    $dd_cache;
#}

sub detect_desktop {
    my @dbg;
    my $info = {_debug_info=>\@dbg};

  DETECT:
    {
        if (($ENV{XDG_MENU_PREFIX}//'') =~ /^xfce-/) {
            push @dbg, "detect: xfce via XDG_MENU_PREFIX env";
            $info->{desktop} = 'xfce';
            last DETECT;
        }

        if (($ENV{XDG_DESKTOP_SESSION}//'') =~ /^kde-plasma/) {
            push @dbg, "detect: kde-plasma via XDG_DESKTOP_SESSION env";
            $info->{desktop} = 'kde-plasma';
            last DETECT;
        }
        if (($ENV{DESKTOP_SESSION}//'') =~ /^kde-plasma/) {
            push @dbg, "detect: kde-plasma via DESKTOP_SESSION env";
            $info->{desktop} = 'kde-plasma';
            last DETECT;
        }

        push @dbg, "detect: nothing detected";
        $info->{desktop} = '';
    } # DETECT

    $info;
}

1;
#ABSTRACT: Detect desktop environment currently running

=head1 SYNOPSIS

 use Desktop::Detect qw(detect_desktop);
 my $res = detect_desktop();
 say "We are running under XFCE" if $res->{desktop} eq 'xfce';


=head1 DESCRIPTION

This module uses several heuristics to find out what desktop environment
is currently running, along with extra information.


=head1 FUNCTIONS

=head2 detect_desktop() => HASHREF

Return a hashref containing information about running desktop environment and
extra information.

Detection is done from the cheapest methods, e.g. looking at environment
variables. Several environment variables are checked, e.g. C<DESKTOP_SESSION>,
C<XDG_DESKTOP_SESSION>, etc.

Result:

=over

=item * desktop => STR

Possible values: C<xfce>, C<kde-plasma>, or empty string (if can't detect any
desktop environment running).

=back


=head1 TODO

=over

=item * Window manager information

=item * XFCE: version

=item * Detect GNOME

=item * Detect MATE

=item * Detect Unity

=item * Detect LXDE

=item * Detect Cinnamon

=item * Detect JWM

=item * Detect Windows?

=back


=head1 SEE ALSO

=cut
