use Test::More tests => 3;
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

@fab = sort $fab4->name( 0 );
no warnings;
my @all = sort @Acme::MetaSyntactic::beatles::List;
is_deeply( \@fab, \@all, "All items" );
