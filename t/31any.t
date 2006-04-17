use Test::More;
use Acme::MetaSyntactic::any;
use t::NoLang;

# "alter" the shuffle method
{
    local $^W;
    my ( $i, $j ) = ( 0, 0 );
    *List::Util::shuffle = sub { sort @_ }; # item selection
    *Acme::MetaSyntactic::any::shuffle =    # theme selection
      sub { my @t = sort @_; push @t, shift @t for 1 .. $j; $j++; @t };
}

my @tests = (
    [qw(a b c)],                     # alphabet
    [qw(Amber)],                     # amber
    [qw(alces_alces antler caribou)],# antlers
    [qw(America Antares Aquarius)],  # apollo
    [qw(Barbabelle Barbalala)],      # barbapapa
    [qw(Barbarella Captain_Moon)],   # barbarella
    [qw(aieee aiieee awk awkkkkkk)], # batman
);

plan tests => scalar @tests;
for my $test (@tests) {
    my @names = metaany( scalar @$test );
    is_deeply( \@names, $test, 'Got names from a "random" theme' );
}

