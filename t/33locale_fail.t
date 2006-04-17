package Acme::MetaSyntactic::digits;
use Test::More;
use strict;

plan tests => 1;

use Acme::MetaSyntactic::Locale;
use vars qw( @ISA );
@ISA = ('Acme::MetaSyntactic::Locale');
eval { __PACKAGE__->init(); };
like( $@, qr/^Acme::MetaSyntactic::digits defines no default language at /,
      "No default" );

1;

__DATA__
# names en
zero one two three four five six seven eight nine
# names fr
zero un deux trois quatre cinq six sept huit neuf
# names it
zero uno due tre quattro cinque sei sette otto nove
# names yi
nul eyn tsvey dray fir finf zeks zibn akht nayn
