use strict;
use Test::More;
use File::Spec::Functions;
use DirHandle;

my @files;
{
    my $dh = DirHandle->new();
    opendir $dh, 't';
    @files = readdir $dh;
    close $dh;
}
my @batmancases    = map { catfile( 't', $_ ) } grep {/^batcase/} @files;
my @haddockcasesfr = map { catfile( 't', $_ ) } grep {/^haddockcase_fr/} @files;
my @haddockcasesen = map { catfile( 't', $_ ) } grep {/^haddockcase_en/} @files;

my @colourscases   = File::Glob::bsd_glob catfile(qw(t colcase*));
plan tests => 2
    * ( @batmancases + @haddockcasesfr + @haddockcasesen + @colourscases );

BATMAN: {
    use Acme::MetaSyntactic::batman;
    my %items = map { $_ => 1 } @Acme::MetaSyntactic::batman::List;

    for (@batmancases) {
        my $result = `$^X "-Mblib" "-Mstrict" -w $_`;
        is( $? >> 8, 0, "$_ ran successfully" );
        ok( exists $items{$result},
            "'$result' is an item from the batman theme" );
    }
}

HADDOCK: {
    use Acme::MetaSyntactic::haddock;
    my %items_en = map { $_ => 1 } @{$Acme::MetaSyntactic::haddock::Locale{en}};
    my %items_fr = map { $_ => 1 } @{$Acme::MetaSyntactic::haddock::Locale{fr}};

    for (@haddockcasesfr) {
        my $result = `$^X -Mblib -Mt::NoLang -Mstrict -w $_`;
        is( $? >> 8, 0, "$_ ran successfully" );
        ok( exists $items_fr{$result},
            "'$result' is an item from the haddock theme" );
    }

    for (@haddockcasesen) {
        my $result = `$^X -Mblib -Mt::NoLang -Mstrict -w $_`;
        is( $? >> 8, 0, "$_ ran successfully" );
        ok( exists $items_en{$result},
            "'$result' is an item from the haddock theme" );
    }
}

COLOURS: {
    use Acme::MetaSyntactic::colours;
    my %items = map { $_ => 1 } Acme::MetaSyntactic::colours->new( category => ':all' )->name( 0 );

    for (@colourscases) {
        my $result = `$^X "-Mblib" "-Mstrict" -w $_`;
        is( $? >> 8, 0, "$_ ran successfully" );
        ok( exists $items{$result},
            "'$result' is an item from the colo(u)rs theme" );
    }
}
