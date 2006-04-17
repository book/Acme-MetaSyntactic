package Acme::MetaSyntactic::planets;
use strict;
use Acme::MetaSyntactic::List;
use vars qw( @ISA );
@ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::planets - The planets theme

=head1 DESCRIPTION

The nine planets of our solar system.

The status of the newly discovered Kuiper belt object is still not
determined (and therefore, not officially named), and hence, not
classified as a planet.

=head1 CONTRIBUTOR

Abigail

Introduced in version 0.63, published on February 27, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
