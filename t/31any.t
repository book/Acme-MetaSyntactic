use Test::More;
use Acme::MetaSyntactic::any;

# "alter" the shuffle method
{
    no warnings;
    my ( $i, $j ) = ( 0, 0 );
    *List::Util::shuffle =
      sub { my @t = sort @_; push @t, shift @t for 1 .. $i; $i++; @t };
    *Acme::MetaSyntactic::any::shuffle =
      sub { my @t = sort @_; push @t, shift @t for 1 .. $j; $j++; @t };
}

my @tests = (
    [qw(aieee)],                    # batman
    [qw(arachne camino)],           # browser
    [qw(Anya Buffy Cordelia)],      # buffy
    [qw(doris eve fred ginger)],    # crypto
);

plan tests => scalar @tests;
for my $test (@tests) {
    my @names = metaany( scalar @$test );
    is_deeply( \@names, $test, "Got names from a theme" );
}

