use strict;
use Test::More;
use Acme::MetaSyntactic;

my @themes = grep { !/^(?:any)/ } Acme::MetaSyntactic->themes;

plan tests => scalar @themes;

for my $theme (@themes) {
    my $items = metaname( $theme => 0 );
    my %items;
    $items{$_}++ for metaname( $theme => 0 );
    is( scalar keys %items, $items, "No duplicates for $theme ($items items)" );
    my $dupes = join " ", grep { $items{$_} > 1 } keys %items;
    diag "Duplicates: $dupes" if $dupes;
}
