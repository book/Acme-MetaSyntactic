use Test::More tests => 2;
use strict;
use Acme::MetaSyntactic;

Acme::MetaSyntactic->add_theme(
    beatles => [ qw(john paul george ringo) ]
);

my $fab4 = Acme::MetaSyntactic::beatles->new();

my @fab = $fab4->name; 
is( @fab, 1, "Single item" );
@fab = $fab4->name( 4 );
is( @fab, 4, "Four items" );

