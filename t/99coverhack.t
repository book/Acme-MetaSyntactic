# this test exists only so that I can have 100% coverage...
use Test::More tests => 1;
use Acme::MetaSyntactic;

$Acme::MetaSyntactic::META{coverhack} = 0;

my $meta = Acme::MetaSyntactic->new( 'coverhack' );
eval { my $name = $meta->name; };
like( $@, qr!^Can't locate Acme/MetaSyntactic/coverhack.pm!, "So there!" );

