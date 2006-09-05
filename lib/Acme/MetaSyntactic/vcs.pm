package Acme::MetaSyntactic::vcs;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::vcs - The vcs theme

=head1 DESCRIPTION

This theme lists popular (and not so popular) Version Control systems.

=head1 CONTRIBUTOR

Éric Cholet

Introduced in version 0.91, published on September 11, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
aegis
arch
bitkeeper
clearcase
cvs
darcs
git
mercurial
monotone
Perforce
RCS
sccs
svk
Subversion
Visual_SourceSafe
