package Acme::MetaSyntactic::any;
use strict;
use List::Util 'shuffle';
use Acme::MetaSyntactic ();

sub import {
    # export the metaany function
    my $callpkg = caller;
    my $meta    = Acme::MetaSyntactic::any->new;
    no strict 'refs';
    *{"$callpkg\::metaany"} = sub { $meta->name( @_ ) };
}

sub name {
    my $self  = shift;
    my $theme =
      ( shuffle( grep { $_ ne 'any' } Acme::MetaSyntactic->themes ) )[0];
    Acme::MetaSyntactic::metaname( $theme, @_ );
}

sub new { bless {}, shift }

1;

=head1 NAME

Acme::MetaSyntactic::any - Items from any theme.

=head1 DESCRIPTION

This theme simply selects a theme at random from all available
themes, and returns names from it.

=head1 METHODS

=over 4

=item new()

Create a new instance.

=item name( $count )

Implement the name() method for this class.

=back

=head1 CONTRIBUTOR

Philippe Bruhat, upon request of Sébastien Aperghis-Tramoni.

Introduced in version 0.12, published on March 7, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>

=cut

