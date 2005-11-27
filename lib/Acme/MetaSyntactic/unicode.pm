package Acme::MetaSyntactic::unicode;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );

{
    my $data = '';
    if ( $] >= 5.006 && $] < 5.007003  ) {
        $data = require 'unicode/Name.pl';
    }
    elsif ( $] >= 5.007003 ) {
        $data = require 'unicore/Name.pl';
    }
    $data = join ' ',
        map  { s/ \(.*\)//; y/- /_/; $_ }
        grep { $_ ne '<control>' }    # what's this for a character name?
        map  { my @F = split /\t/; $F[1] ? () : $F[2] }   # remove blocks
        split /\n/, $data;

    __PACKAGE__->init( { names => $data } );
}

1;

=head1 NAME

Acme::MetaSyntactic::unicode - The unicode theme

=head1 DESCRIPTION

The name of all Unicode characters known to Perl.

Note that since your Perl installation knows all these names, they
are not included in the source of this module (that's the whole point).

=head1 CONTRIBUTOR

Philippe "BooK" Bruhat.

Thanks to Sébastien Aperghis-Tramoni for his help in finding
F<unicore/Name.pl>.

Introduced in version 0.50, published on November 28, 2005.

Updated to support more Perl versions in version 0.51, published
on December 5, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

# yep, no __DATA__ this time!

