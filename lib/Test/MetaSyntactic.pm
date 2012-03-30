package Test::MetaSyntactic;
use strict;
use warnings;
use Acme::MetaSyntactic ();

use base 'Test::Builder::Module';

our @EXPORT = qw( all_themes_ok all_themes theme_ok );

#
# exported functions
#

sub all_themes_ok {
    my @themes = all_themes( @_ );
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => scalar @themes );
    $tb->subtest( $_, sub { theme_ok( $_ ) } ) for @themes;
}

sub all_themes {
    my (@lib) = @_;
    @lib = _starting_points() if !@lib;
    return Acme::MetaSyntactic->_find_themes( @lib );
}

sub theme_ok {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    # all subtests
    $tb->subtest( "uniq $theme", sub { subtest_uniq($theme); } );
    $tb->done_testing;
}

#
# useful internal functions
#

# some starting points to look for theme modules
sub _starting_points {
    return 'blib/lib' if -e 'blib/lib';
    return 'lib';
}

# return a list of [ AMS object, details ]
sub _theme_sublists {
    my ($theme) = @_;

    my @metas;
    no strict 'refs';
    my %isa = map { $_ => 1 } @{"Acme::MetaSyntactic::$theme\::ISA"};
    if( exists $isa{'Acme::MetaSyntactic::Locale'} ) {
        for my $lang ( "Acme::MetaSyntactic::$theme"->languages() ) {
            push @metas,
                [ "Acme::MetaSyntactic::$theme"->new( lang => $lang ),
                  "$theme, $lang locale" ];
        }
    }
    elsif( exists $isa{'Acme::MetaSyntactic::MultiList'} ) {
        for my $cat ( "Acme::MetaSyntactic::$theme"->categories(), ':all' ) {
            push @metas,
                [ "Acme::MetaSyntactic::$theme"->new( category => $cat ),
                  "$theme, $cat category" ];
        }
    }
    else {
        push @metas, [ "Acme::MetaSyntactic::$theme"->new(), $theme ];
    }

    return @metas;
}

#
# individual subtest functions
#

# t/22uniq.t
sub subtest_uniq {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    no strict 'refs';
    eval "require Acme::MetaSyntactic::$theme;";
    diag "$theme $@" if $@;

    my @metas = _theme_sublists( $theme );
    $tb->plan( tests => scalar @metas );

    for my $test (@metas) {
        my ($meta, $name) = @$test;
        my %items;
        my @items = $meta->name(0);
        $items{$_}++ for @items;

        $tb->is_num(
            scalar keys %items,
            scalar @items,
            "No duplicates for $name, ${\scalar @items} items"
        );
        my $dupes = join " ", grep { $items{$_} > 1 } keys %items;
        diag "Duplicates: $dupes" if $dupes;
    }

}

1;

__END__

