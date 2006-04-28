package Acme::MetaSyntactic::planets;
use strict;
use Acme::MetaSyntactic::Locale;
our @ISA = qw( Acme::MetaSyntactic::Locale );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::planets - The planets theme

=head1 DESCRIPTION

The nine planets of our solar system.

The status of the newly discovered Kuiper belt object (2003 UB313) is
still not determined (and therefore, not officially named), and hence,
not classified as a planet.

=head1 CONTRIBUTOR

Abigail

Introduced in version 0.63, published on February 27, 2006.

Made multilingual in version 0.73, published on May 8, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::Locale>.

=cut

__DATA__
# default
en
# names en
Mercury Venus Earth Mars Jupiter Saturn Uranus Neptune Pluto
# names fr
Mercure Venus Terre Mars Jupiter Saturne Uranus Neptune Pluton
# names de
Merkur Venus Erde Mars Jupiter Saturn Uranus Neptun Pluto
# names it
Mercurio Venere Terra Marte Giove Uranio Nettuno Plutone
# names pt
Mercurio Venus Terre Marte Jupiter Urano Netuno Plutao
# names es
Mercurio Venus Tierra Marte Jupiter Urano Neptuno Pluton
