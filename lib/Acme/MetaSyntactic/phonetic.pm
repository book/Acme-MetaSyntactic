package Acme::MetaSyntactic::phonetic;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::phonetic - The phonetic theme

=head1 DESCRIPTION

The NATO official phonetic alphabet.

=head1 CONTRIBUTOR

Michel Rodriguez.

Introduced in version 0.08, published on February 7, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
alpha   bravo charlie  delta echo foxtrot golf  hotel  india juliet  kilo
lima    mike  november oscar papa quebec  romeo sierra tango uniform victor
whiskey xray  yankee   zulu
