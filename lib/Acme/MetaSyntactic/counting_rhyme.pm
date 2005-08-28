package Acme::MetaSyntactic::counting_rhyme;
use strict;
use Acme::MetaSyntactic::Locale;
our @ISA = qw( Acme::MetaSyntactic::Locale );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::counting_rhyme - The counting rhyme theme

=head1 DESCRIPTION

Based on popular children counting rhymes, mostly used to decide roles
in games (who'll be the wolf?)

=head1 FULL VERSIONS

=head2 English

Eeny, meeny, miny, moe
Catch a tiger by the toe
If he hollers let him go,
Eeny, meeny, miny, moe.

=head2 French

Am, stram, gram,
Pique et pique et colégram
Bourre, bourre et ratatam
Am, stram, gram.

=head1 CONTRIBUTOR

Xavier Caron proposed the idea in French, and Paul-Christophe Varoutas
provided the English version.

Introduced in version 0.30, published on July 11, 2005.

Patched a typo in version 0.39, published on September 12, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# default
en
# names en 
eenie meeny miny moe
catch a tiger by the toe 
if he hollers let him go 
# names fr
am stram gram
pique et colegram
bourre ratatam
 
