use Test::More tests => 1;

BEGIN {
use_ok( 'Acme::MetaSyntactic' );
}

diag( "Testing Acme::MetaSyntactic $Acme::MetaSyntactic::VERSION" );
diag( "Available themes: @{[ sort keys %Acme::MetaSyntactic::META ]}" );
