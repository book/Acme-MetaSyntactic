use Test::More;
use strict;
use Acme::MetaSyntactic ':all';

plan tests => keys(%Acme::MetaSyntactic::META) - 1;

for my $name ( sort grep { $_ ne 'any' } keys %Acme::MetaSyntactic::META ) {
    no strict 'refs';
    my @names = "meta$name"->();
    my %seen = map { $_ => 1 } @{"Acme::MetaSyntactic\::$name\::List"};
    ok( exists $seen{$names[0]}, "meta$name" );
}

