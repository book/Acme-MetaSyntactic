package Acme::MetaSyntactic::test;
use strict;
use Test::More;
use Acme::MetaSyntactic;

plan tests => 2;

$_ = 'canari';
my $data = Acme::MetaSyntactic->load_data('Acme::MetaSyntactic::test');
is( $_, 'canari', "load_data does not stomp the canari" );
is_deeply(
    $data,
    {   foo   => "bar",
        names => {
            en => "name on 3 lines",
            fr => "et en français",
        },
        long =>
            { chain => { empty => '', not => { empty => 'zlonk powie' } } },
    },
    "read DATA correctly"
);

__DATA__

# foo
bar
# names en
name
on 3
lines
# long chain empty
# long chain not empty
zlonk powie
# names fr
   et en
français

