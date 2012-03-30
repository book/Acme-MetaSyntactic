package Test::MetaSyntactic;
use strict;
use warnings;
use Acme::MetaSyntactic ();

use base 'Test::Builder::Module';

my $CLASS = __PACKAGE__;

our @EXPORT = qw( all_themes_ok all_themes theme_ok );

#
# exported functions
#

sub all_themes_ok {
    my @themes = all_themes( @_ );
    my $tb = $CLASS->builder;
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
    my $tb = $CLASS->builder;

    # all subtest
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

1;

__END__

