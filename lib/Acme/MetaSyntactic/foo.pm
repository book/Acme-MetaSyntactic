package Acme::MetaSyntactic::foo;
use strict;
use Acme::MetaSyntactic::List;
use vars qw( @ISA );
@ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::foo - The foo theme

=head1 DESCRIPTION

The classic. This is the default theme.

=head1 CONTRIBUTOR

Philippe "BooK" Bruhat.

Introduced in version 0.01, published on January 14, 2005.

=head2 References

=over 4

=item RFC 3092 - I<Etymology of "Foo">

=back

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
foo    bar   baz  foobar fubar qux  quux corge grault
garply waldo fred plugh  xyzzy thud
