use Test::More;
use Acme::MetaSyntactic;
use strict;

my @themes = Acme::MetaSyntactic->themes;

plan tests => scalar @themes;

for my $t (@themes) {
    eval "require Acme::MetaSyntactic::$t";
    my $a = "Acme::MetaSyntactic::$t"->new;
    is( eval { $a->theme }, $t, "theme() for Acme::MetaSyntactic::$t" );
}
