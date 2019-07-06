package App::CPANChangesCwaliteeUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Cwalitee::Common;

our %SPEC;

$SPEC{calc_cpan_changes_cwalitee} = {
    v => 1.1,
    summary => 'Calculate CPAN Changes cwalitee',
    args => {
        %Cwalitee::Common::args_calc,
        path => {
            schema => 'pathname*',
            pos => 0,
            # in our version, path is optional. we try to look at files named
            # Changes, ChangeLog, etc and use that.
        },
    },
};
sub calc_cpan_changes_cwalitee {
    require CPAN::Changes::Cwalitee;

    my %args = @_;

    my $path = delete $args{path};
    {
        last if defined $path;

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
    }
    unless ($path) {
        return [400, "Please specify path"];
    }

    CPAN::Changes::Cwalitee::calc_cpan_changes_cwalitee(
        path => $path,
        %args,
    );
}

1;
#ABSTRACT: CLI Utilities related to CPAN Changes cwalitee

=head1 DESCRIPTION

This distribution includes the following utilities:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<CPAN::Changes::Cwalitee>
