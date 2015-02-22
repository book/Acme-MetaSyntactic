=encoding iso-8859-1

=head1 NAME

Acme::MetaSyntactic::contributors - Acme::MetaSyntactic contributors

=head1 DESCRIPTION

The following people contributed to L<Acme::MetaSyntactic>,
either by proposing theme ideas, updating existing themes,
sending bug reports, running the test suite on their machine
and sending me the report or sending complete lists of items
for new or existing themes. Thanks for all the work I didn't
have to do!

They are listed below in chronological order (of when I actually
used their contributions), with the details of their contributions
(to L<Acme::MetaSyntactic> up to version 0.99, and to
L<Acme::MetaSyntactic::Themes> up to version 1.028 afterwards).

=cut

package Acme::MetaSyntactic::contributors;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
our $VERSION = '1.002';

{
    my %seen;
    __PACKAGE__->init(
        {   names => join ' ',
            grep    { !$seen{$_}++ }
                map { s/_+/_/g; $_ }
                map { Acme::MetaSyntactic::RemoteList::tr_nonword($_) }
                map { Acme::MetaSyntactic::RemoteList::tr_accent($_) }
                map { /^=head2 (.*)/ ? $1 : () }
                split /\n/ => <<'=cut'} );

=pod

=head2 Vahe Sarkissian

Ideas: L<Acme::MetaSyntactic::donmartin>.

=head2 David Landgren

Ideas:

=head2 Sébastien Aperghis-Tramoni

=head2 Mike Castle

=head2 anonymous

=head2 Scott Lanning

=head2 Michel Rodriguez

=head2 Rafael Garcia-Suarez

=head2 Aldo Calpini

=head2 Jérôme Fenal

=head2 Ricardo Signes

=head2 Hakim Cassimally

=head2 Max Maischein

=head2 Offer Kaye

=head2 Cédric Bouvier

=head2 Jean Forget

=head2 Guy Widloecher

=head2 Xavier Caron

=head2 Paul-Christophe Varoutas

=head2 Gábor Szabó

=head2 Mark Fowler

=head2 Miss Barbie

=head2 Martin Vorländer

=head2 Alberto Manuel Brandão Simões

=head2 Nicholas Clark

=head2 Gaal Yahas

=head2 Estelle Souche

=head2 Abigail

=head2 Antoine Hulin

=head2 Michael Scherer

=head2 Jan Pieter Cornet

=head2 Flavio Poletti

=head2 Leon Brocard

=head2 Anja Krebber

=head2 Yanick Champoux

=head2 Gisbert W. Selke

=head2 José Castro

=head2 David Golden

=head2 Matthew Musgrove

=head2 David H. Adler

=head2 Éric Cholet

=head2 Elliot Shank

=head2 Simon Myers

=head2 Olivier Mengué

=head2 Éric Cassagnard

=cut

}

1;

__END__

=pod

Thank you all for making Acme::MetaSyntactic such a successful module!

=head1 CONTRIBUTOR

Philippe Bruhat.

=head1 CHANGES

=over 4

=item *

2015-  -  - v1.002

Listed everyone's contributions to L<Acme::Syntactic>.

=item *

2012-05-14 - v1.001

Added Olivier Mengué as a contributor.
Published in Acme-MetaSyntactic v1.001.

=item *

2012-05-07 - v1.000

Introduced in Acme-MetaSyntactic version 1.000.

=back

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

