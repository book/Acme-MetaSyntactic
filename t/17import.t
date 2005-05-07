use Test::More;
use strict;
use t::NoLang;
use Acme::MetaSyntactic ':all';

plan tests => keys(%Acme::MetaSyntactic::META) - 2;

for my $name ( sort grep { !/^(?:any|random)/ } keys %Acme::MetaSyntactic::META ) {
    no strict 'refs';
    my @names = "meta$name"->();
    my %isa = map { $_ => 1 } @{"Acme::MetaSyntactic::$name\::ISA"};
    my %seen;
    if ( exists $isa{'Acme::MetaSyntactic::List'} ) {
        %seen = map { $_ => 1 } @{"Acme::MetaSyntactic::$name\::List"};
    }
    elsif ( exists $isa{'Acme::MetaSyntactic::Locale'} ) {
        %seen =
          map { $_ => 1 }
          @{ ${"Acme::MetaSyntactic::$name\::Locale"}
              { ${"Acme::MetaSyntactic::$name\::Default"} } };
    }
    ok( exists $seen{ $names[0] }, "meta$name -> $names[0]" );
}

