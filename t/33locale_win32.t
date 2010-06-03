use Test::More;
use Acme::MetaSyntactic::haddock;
use t::NoLang;

plan tests => 1;

# Windows or not, I do not care
unshift @INC, sub {
    my (undef, $file) = @_;

    if ($file eq 'Win32/Locale.pm') {
        my @code = ("0;");
        return sub { $_ = shift @code };
    }
};

$^O   = 'MSWin32';
$meta = Acme::MetaSyntactic::haddock->new;
is( $meta->lang, 'fr', "Correct default without Win32::Locale" );

