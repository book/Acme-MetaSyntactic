package Acme::MetaSyntactic::test;
use strict;
use Test::More;
use Acme::MetaSyntactic;

plan tests => 1;

my $data = Acme::MetaSyntactic->load_data( 'Acme::MetaSyntactic::test' );
is_deeply(
    $data,
    {
        foo   => "bar\n",
        names => {
            en => "name\non 3\nlines\n",
            fr => "et en\nfrançais\n",
        },
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
# names fr
et en
français
