use Test::More;
use Acme::MetaSyntactic;

plan tests => 1;

my $count = $Acme::MetaSyntactic::VERSION;
$count =~ s/^0\.//;
$count += 7;

is( scalar Acme::MetaSyntactic->themes, $count, "$count themes" );

