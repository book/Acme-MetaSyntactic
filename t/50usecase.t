use strict;
use Test::More;
use File::Spec::Functions;

my @cases = glob catfile(qw(t batcase*));
plan tests => 2 * @cases;

use Acme::MetaSyntactic::batman;
my %items = map { $_ => 1 } @Acme::MetaSyntactic::batman::List;

for (@cases) {
    my $result = `$^X -Mblib -Mstrict -w $_`;
    is( $? >> 8, 0, "$_ ran successfully" );
    ok( exists $items{$result}, "'$result' is an item from the batman theme" );
}

__END__

SKIP: {
    eval { require Test::Cmd; };
    skip "Test::Cmd required to test use cases", scalar @cases if $@;

    my $t = Test::Cmd->new();
}
