use Test::More;
use t::NoLang;
use strict;
use Acme::MetaSyntactic;

END {
    my @langs = Acme::MetaSyntactic::digits->languages();

    plan tests => 4 * ( @langs + 1 ) + 1;

    is_deeply( [ sort @langs ], [ qw( en fr it yi ) ], "All languages" );

    for my $args ( [], map { [ lang => $_ ] } @langs ) {
        my $meta   = Acme::MetaSyntactic::digits->new(@$args);
        my $lang   = $args->[1] || 'en';
        my @digits = $meta->name;
        is( $meta->lang, $lang, "lang() is $lang" );
        is( @digits, 1, "Single item ($lang)" );
        @digits = $meta->name(4);
        is( @digits, 4, "Four items ($lang)" );

        @digits = sort $meta->name(0);
        no warnings;
        my @all = sort @{ $Acme::MetaSyntactic::digits::Locale{$lang} };
        is_deeply( \@digits, \@all, "All items ($lang)" );
    }
}

package Acme::MetaSyntactic::digits;
use Acme::MetaSyntactic::Locale;
our @ISA = ('Acme::MetaSyntactic::Locale');
__PACKAGE__->init();
1;

__DATA__
# default
en
# names en
zero one two three four five six seven eight nine
# names fr
zero un deux trois quatre cinq six sept huit neuf
# names it
zero uno due tre quattro cinque sei sette otto nove
# names yi
nul eyn tsvey dray fir finf zeks zibn akht nayn
