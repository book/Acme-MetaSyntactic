use strict;
use Test::More;
use Acme::MetaSyntactic;

my @themes = grep { !/^(?:any)/ } Acme::MetaSyntactic->themes;

plan tests => scalar @themes;

for my $theme (@themes) {
    my @items = metaname( $theme => 0 );
    my @failed;
    my $ok = 0;
    ( /^[A-Za-z_]\w*$/ && ++$ok ) || push @failed, $_ for @items;
    is( $ok, @items, "All names correct for $theme" );
    diag "Bad names: @failed" if @failed;
}
