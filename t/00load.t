use Test::More;

my @modules = qw(
    Acme::MetaSyntactic
    Acme::MetaSyntactic::List
);

plan tests => scalar @modules;
use_ok( $_ ) for @modules;
