use Test::More;
use strict;
use Acme::MetaSyntactic ':all';

plan tests => scalar keys %Acme::MetaSyntactic::META;

for my $name ( keys %Acme::MetaSyntactic::META ) {
    no strict 'refs';
    my @names = "meta$name"->();
    my %seen = map { $_ => 1 } @{"Acme::MetaSyntactic\::$name\::List"};
    ok( exists $seen{$names[0]}, "meta$name" );
}

