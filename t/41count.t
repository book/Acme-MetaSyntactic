use Test::More;
use Acme::MetaSyntactic;

plan tests => 1;

my $count = $Acme::MetaSyntactic::VERSION;
$count =~ y/.//d;
$count += 4; # 4 as of version 0.70
             # 5 as of version 0.55
             # 6 as of version 0.38
             # 7 as of version 0.25

is( scalar Acme::MetaSyntactic->themes, $count, "$count themes" );

