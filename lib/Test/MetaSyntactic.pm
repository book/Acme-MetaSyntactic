package Test::MetaSyntactic;
use strict;
use warnings;
use Acme::MetaSyntactic ();

use base 'Test::Builder::Module';

our @EXPORT = qw( all_themes_ok theme_ok );

#
# exported functions
#

sub all_themes_ok {
    my (@lib) = @_;
    @lib = _starting_points() if !@lib;
    my %source = Acme::MetaSyntactic->_find_themes( @lib );

    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => scalar keys %source );
    $tb->subtest( $_, sub { theme_ok( $_, $source{$_}) } ) for sort keys %source;
}

sub theme_ok {
    my @args = @_;
    my $tb   = __PACKAGE__->builder;

    # all subtests
    my $theme = $args[0];
    $tb->subtest( "load $theme",   sub { subtest_load(@args); } );
    $tb->subtest( "format $theme", sub { subtest_format(@args); } );
    $tb->subtest( "uniq $theme",   sub { subtest_uniq(@args); } );
    $tb->subtest( "length $theme", sub { subtest_length(@args); } );
    $tb->subtest( "data $theme",   sub { subtest_data(@args); } );
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
    eval "require Acme::MetaSyntactic::$theme;"
        or __PACKAGE__->builder->diag("$theme $@");

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

# t/01load.t
# t/51useall.t
sub subtest_load {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    $tb->plan( tests => 1 );
    `$^X -Mblib -MAcme::MetaSyntactic::$theme -e1`;
    $tb->is_num( $?, 0, $theme );
}

# t/21format.t
sub subtest_format {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    my @metas = _theme_sublists( $theme );
    $tb->plan( tests => scalar @metas );

    for my $test (@metas) {
        my ($ams, $theme) = @$test;
        my @items = $ams->name( 0 );
        my @failed;
        my $ok = 0;
        ( /^[A-Za-z_]\w*$/ && ++$ok ) || push @failed, $_ for @items;
        $tb->is_num( $ok, scalar @items, "All names correct for $theme" );
        $tb->diag( "Bad names: @failed" ) if @failed;
    }
}

# t/22uniq.t
sub subtest_uniq {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

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
        $tb->diag( "Duplicates: $dupes" ) if $dupes;
    }

}

# t/23length.t
sub subtest_length  {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    my @metas = _theme_sublists( $theme );
    $tb->plan( tests => scalar @metas );

    for my $t (@metas) {
        my ($ams, $theme) = @$t;
        my @items = $ams->name( 0 );
        my @failed;
        my $ok = 0;
        ( length($_) <= 251 && ++$ok ) || push @failed, $_ for @items;
        $tb->is_num( $ok, scalar @items, "All names correct for $theme" );
        $tb->diag( "Names too long: @failed" ) if @failed;
    }
}

# t/24data.t
sub subtest_data {
    my ( $theme, $file ) = @_;
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => 1 );

SKIP: {
        if ( !$file ) {
            $tb->skip( "This test needs the source file for $theme", 1 );
            last SKIP;
        }
        open my $fh, $file or do {
            $tb->skip( "Can't open $file: $!", 1 );
            last SKIP;
        };

        my ( $fail, $in_data ) = ( 0, 0 );
        my @lines;
        while (<$fh>) {
            $in_data++ if /^__DATA__$/;
            next if !$in_data;
            $fail++, push @lines, $.
                if /^#/ && !/^# ?(?:names(?: +[-\w]+)*|default)\s*$/;
        }
        $tb->is_num( $fail, 0, "__DATA__ section for $file" );
        $tb->diag("Failed lines: @lines") if @lines;
        close $fh;
    }
}

1;

__END__

=head1 NAME

Test::MetaSyntactic - Common tests for Acme::MetaSyntactic themes

=head1 SYNOPSIS

   # add this as t/meta.t
   use Test::MetaSyntatic;
   all_themes_ok();

=head1 DESCRIPTION

This module provides the minimum set of tests that any Acme::MetaSyntactic theme
should pass.

The goal is to make is easier for theme creators build a distribution and ensure
your theme will work correctly when installed.

=head1 EXPORTED FUNCTIONS

=head2 all_theme_ok( @lib )

Will find all themes under the directories listed in C<@lib>, and run C<theme_ok()>
on them.

C<@lib> is optional (it will try to find themes in F<blib/lib> or F<lib> if not provided).

=head2 theme_ok( $theme, $source )

Will run all tests on the given C<$theme>. Some tests require access to the source, but
thaye will be skipped if C<$source> is not provided.

=head1 SUBTESTS

The individual tests are run as subtests. They are:

=head2 subtest_load( $theme )

Tres to load the theme module.

=head2 subtest_format( $theme )

Checks that each metasyntactic name in the theme is a valid Perl
variable name.

=head2 subtest_uniq( $theme )

Checks that each name appears once in the theme.

=head2 subtest_length( $theme )

Checks that each name in the theme has valid length.

=head2 subtest_data( $theme, $source )

Checks that the C<__DATA__> section (if any) of the theme source is
properly formatted.

=head1 AUTHOR

Philippe Bruhat (BooK), C<< <book@cpan.org> >>

=head1 COPYRIGHT

 Copyright 2012 Philippe Bruhat (BooK), All Rights Reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

