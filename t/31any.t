use Test::More;
use Acme::MetaSyntactic::any;
use t::NoLang;

# "alter" the shuffle method
{
    no warnings;
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
    [qw(aieee aiieee awk awkkkkkk)], # batman
    [qw(absinthe ale amaretto)],     # booze
);

plan tests => scalar @tests;
for my $test (@tests) {
    my @names = metaany( scalar @$test );
    is_deeply( \@names, $test, 'Got names from a "random" theme' );
}

