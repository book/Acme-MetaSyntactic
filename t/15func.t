use Test::More;
use strict;
use Acme::MetaSyntactic;

plan tests => 1 + scalar keys %Acme::MetaSyntactic::META;

my @names = metaname();
my %seen = map { $_ => 1 } @{ $Acme::MetaSyntactic::META{foo} };
ok( exists $seen{$names[0]}, "metaname" );

for my $name ( keys %Acme::MetaSyntactic::META ) {
    no strict 'refs';
    @names = "meta$name"->();
    %seen = map { $_ => 1 } @{ $Acme::MetaSyntactic::META{$name} };
    ok( exists $seen{$names[0]}, "meta$name" );
}

