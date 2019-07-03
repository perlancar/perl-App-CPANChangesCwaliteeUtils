package App::CPANChangesCwaliteeUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{calc_cpan_changes_cwalitee} = {
    v => 1.1,
    summary => 'Calculate CPAN Changes cwalitee',
    args => {
        path => {
            schema => 'pathname*',
            pos => 0,
        },
    },
};
sub calc_cpan_changes_cwalitee {
    require CPAN::Changes::Cwalitee;

    my %args = @_;

    my $path;
    for my $f (
        "Changes",
        "CHANGES",
        "ChangeLog",
        "CHANGELOG",
        (grep {/change|chn?g/i} glob("*")),
    ) {
        if (-f $f) {
            $path = $f;
            last;
        }
    }
    unless ($path) {
        return [400, "Please specify path"];
    }
    CPAN::Changes::Cwalitee::calc_cpan_changes_cwalitee(
        path => $path,
    );
}

1;
#ABSTRACT: CLI Utilities related to CPAN Changes cwalitee

=head1 DESCRIPTION

This distribution includes the following utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<CPAN::Changes::Cwalitee>
