use strict;
use Test::More;
use Acme::MetaSyntactic;

plan tests => 7;

my @bots = qw( purl url sarko bender );
my $meta = Acme::MetaSyntactic->new( 'bots' );

# existing themes
my @themes = Acme::MetaSyntactic->themes;

# yep, you can add the theme after creating the instance
Acme::MetaSyntactic->add_theme( bots => [ @bots ] );

my @names = $meta->name;
is( scalar @names, 1, "name() returned a single item" );

push @names, $meta->name(3);
is( scalar @names, 4, "name( 3 ) returned three more items" );

my %seen = map { $_ => 1 } @names;
is_deeply( \%seen, { map { $_ => 1 } @bots }, "Got the whole list");

# and the new method exists as well
$meta = Acme::MetaSyntactic->new( 'batman' );
@names = $meta->bots( 2 );

ok( exists( $seen{$_} ), "the bots() method" ) for @names;

is_deeply( [ sort @themes, "bots" ], [ Acme::MetaSyntactic->themes ],
  "Themes list updated" );

is(
    scalar Acme::MetaSyntactic->themes,
    scalar @{ [ Acme::MetaSyntactic->themes ] },
    "themes() works in scalar context"
);
