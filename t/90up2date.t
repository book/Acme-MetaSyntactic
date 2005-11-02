use Test::More;
use Acme::MetaSyntactic ();

my @themes =
    grep { eval "require $_;"; $_->has_remotelist() }
    map {"Acme::MetaSyntactic::$_"} Acme::MetaSyntactic->themes();
my $tests = 2 * @themes;

plan tests => $tests;

SKIP: {

    # this test must be explicitely requested
    skip "Set AMS_REMOTE environment variable to true to test up-to-dateness",
        $tests
        unless $ENV{AMS_REMOTE};

    # need LWP
    eval { require LWP::Simple; };
    skip "LWP::Simple required for testing up-to-dateness", $tests if $@;

    # need the network too
    skip "Network looks down - couldn't reach Google", $tests
        unless 'http://www.google.com/intl/en/';

    # need Test::Differences
    eval { require Test::Differences; };
    skip "Test::Differences required for testing up-to-dateness", $tests
        if $@;

    # a little warning
    diag "Testing @{[scalar @themes]} themes using the network (may take a while)";

    # compare each theme data with the network
    for my $theme (@themes) {
        my $current = [ sort map {lc} $theme->name(0) ];
        my $online  = [ sort map {lc} $theme->remote_list() ];

        SKIP: {
            skip "Fetching remote items for $theme probably failed", 2
                if @$online == 0;

            # count
            is( scalar @$current,
                scalar @$online,
                "$theme has @{[scalar @$online]} items"
            );

            # details
            Test::Differences::eq_or_diff(
                $current, $online,
                "$theme is up to date",
                { context => 1 }
            );
        }
    }

}
