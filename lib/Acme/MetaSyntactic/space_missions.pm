package Acme::MetaSyntactic::space_missions;
use strict;
use Acme::MetaSyntactic::MultiList;
our @ISA = qw( Acme::MetaSyntactic::MultiList );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::space_missions - The space missions theme

=head1 DESCRIPTION

This theme lists the names of various space missions flights.

=over 4

=item Apollo

As from Apollo 9, the command and lunar modules of Project Apollo were
given radio call signs. This list document them.

Source: I<A Man on the Moon>, by Andrew Chaikin.

=item Mercury

This list gives the names of the six Mercury spacecraft,
plus the name of the flight cancelled when Deke Slayton
was grounded for health reasons.

Source: I<The Right Stuff>, by Tom Wolfe.

=back

=head1 CONTRIBUTOR

Jean Forget

Introduced in version 0.41 as C<apollo>, published on September 26, 2005.

Augmented with other space missions and renamed C<space_missions> in
version 0.86, published on August 7, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::MultiList>.

=cut

__DATA__
# default
:all
# names apollo
Gumdrop Spider
Charlie_Brown Snoopy
Columbia Eagle
Yankee_Clipper Intrepid
Odyssey Aquarius
Kitty_Hawk Antares
Endeavour Falcon
Casper Orion
America Challenger
# names mercury
Freedom7
Liberty_Bell7
Friendship7
Delta7
Aurora7
Sigma7
Faith7
