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
    {
        foo   => "bar",
        names => {
            en => "name on 3 lines",
            fr => "et en français",
        },
        empty => { but => { long => { chain => "" } } },
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
# empty but long chain
# names fr
   et en
français

