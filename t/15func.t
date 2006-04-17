use Test::More;
use strict;
use Acme::MetaSyntactic;

plan tests => 2;

# the default list
local $^W;
my @names = metaname();
my %seen = map { $_ => 1 } @Acme::MetaSyntactic::foo::List;
ok( exists $seen{$names[0]}, "metaname" );

is_deeply(
    [ sort grep { /^meta\w+$/ } keys %:: ],
    [qw( metaname )],
    "Default exported function"
);

