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
    local $Test::Builder::Level = $Test::Builder::Level + 1;
    $tb->plan( tests => scalar keys %source );
    theme_ok( $_, $source{$_} ) for sort keys %source;
}

sub theme_ok {
    my @args = @_;
    my $tb   = __PACKAGE__->builder;
    local $Test::Builder::Level = $Test::Builder::Level + 1;

    # all subtests
    my $theme = $args[0];
    $tb->subtest(
        $theme,
        sub {
            $tb->subtest( "$theme fixme",    sub { subtest_fixme(@args); } );
            $tb->subtest( "$theme load",     sub { subtest_load(@args); } )
                or return;
            $tb->subtest( "$theme data",     sub { subtest_data(@args); } );
            $tb->subtest( "$theme format",   sub { subtest_format(@args); } );
            $tb->subtest( "$theme uniq",     sub { subtest_uniq(@args); } );
            $tb->subtest( "$theme length",   sub { subtest_length(@args); } );
            $tb->subtest( "$theme import",   sub { subtest_import(@args); } );
            $tb->subtest( "$theme noimport", sub { subtest_noimport(@args); } );
            $tb->subtest( "$theme theme",    sub { subtest_theme(@args); } );
            $tb->subtest( "$theme remote",   sub { subtest_remote(@args); } );
            $tb->done_testing;
        }
    );
}

#
# useful internal functions
#

# some starting points to look for theme modules
sub _starting_points {
    return 'blib/lib' if -e 'blib/lib';
    return 'lib';
}

# load the theme in a random namespace
{
    my $num = 0;

    sub _load {
        my ( $theme, $do_import ) = @_;
        my $module = "Acme::MetaSyntactic::$theme";
        my $pkg    = sprintf "Acme::MetaSyntactic::SCRATCH_%04d", $num++;
        my $code   = $do_import
            ? "package $pkg; use $module; 1;"
            : "package $pkg; use $module (); 1;";
        my $ok     = eval $code;
        return ( $pkg, !$ok && $@ );
    }
}

# return a list of [ AMS object, details ]
sub _theme_sublists {
    my ($theme) = @_;
    my @metas;

    # assume the module has already been loaded
    no strict 'refs';
    my $class = "Acme::MetaSyntactic::$theme";

    if( $class->isa('Acme::MetaSyntactic::Locale') ) {
        for my $lang ( "Acme::MetaSyntactic::$theme"->languages() ) {
            push @metas,
                [ "Acme::MetaSyntactic::$theme"->new( lang => $lang ),
                  "$theme, $lang locale" ];
        }
    }
    elsif( $class->isa('Acme::MetaSyntactic::MultiList') ) {
        for my $cat ( "Acme::MetaSyntactic::$theme"->categories() ) {
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

# return the list of all theme items
sub _theme_items {
    my ($theme) = @_;

    # assume the module has already been loaded
    no strict 'refs';
    my $class = "Acme::MetaSyntactic::$theme";
    my @items
        = $class->isa('Acme::MetaSyntactic::List')
        ? @{"$class\::List"}
        : $class->isa('Acme::MetaSyntactic::MultiList')
        ? map @$_, values %{"$class\::MultiList"}
        : ();
    return @items;
}

sub _check_file_lines {
    my ($theme, $file, $mesg, $cb ) = @_;
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => 1 );
    local $Test::Builder::Level = $Test::Builder::Level + 1;

SKIP: {
        my ($fh, $skip);
        if ( $file ) {
            open $fh, $file or do { $skip="Can't open $file: $!"; };
        }
        else {
            $skip = "This test needs the source file for $theme";
        }
        if( $skip ) {
            $tb->skip($skip);
            last SKIP;
        }

        my @lines = $cb->( <$fh> );
        $tb->is_num( scalar @lines, 0, $mesg );
        $tb->diag( "Failed lines:\n", map "  $_\n", @lines ) if @lines;
        close $fh;
    }
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
    my ( $pkg, $error ) = _load( $theme, 1 );
    $tb->ok( !$error, "use Acme::MetaSyntactic::$theme;" );
    $tb->diag($error) if $error;
}

# t/02fixme.t
sub subtest_fixme {
    my ( $theme, $file ) = @_;
    $file = '' if !defined $file;
    _check_file_lines(
        $theme, $file,
        "No FIXME found in $file",
        sub { grep /\bFIXME\b/, @_ }
    );
}

# t/08theme.t
sub subtest_theme {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => 2 );

    $tb->is_eq( eval { "Acme::MetaSyntactic::$theme"->theme },
        $theme, "theme() for Acme::MetaSyntactic::$theme" );
    $tb->is_eq( eval { "Acme::MetaSyntactic::$theme"->new->theme },
        $theme, "theme() for Acme::MetaSyntactic::$theme" );
}

# t/17import.t
sub subtest_import {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => my $tests = 2 );

SKIP: {
        if ( $theme =~ /^(?:any|random)$/ ) {
            $tb->skip("Not testing import for theme $theme") for 1 .. $tests;
            last SKIP;
        }
        else {
            my ($pkg) = _load( $theme, 1 );
            my %seen = map { $_ => 1 } _theme_items($theme);

            no strict 'refs';
            $tb->ok( exists ${"$pkg\::"}{"meta$theme"},
                "meta$theme exported" );

            my @names
                = eval qq{package $pkg; no strict 'refs'; "meta$theme"->();};
            $tb->ok( exists $seen{ $names[0] }, "meta$theme -> $names[0]" );
        }
    }
}

# t/18import.t
sub subtest_noimport {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;
    $tb->plan( tests => 1 );

    my ($pkg) = _load($theme);

    # meta$theme should not exist
    eval "package $pkg; meta$theme(1);";
    $tb->ok( $@ =~ /^Undefined subroutine &$pkg\::meta$theme called/,
        "meta$theme function not exported" );
}

# t/21format.t
sub subtest_format {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    my @metas = _theme_sublists($theme);
    $tb->plan( tests => scalar @metas );

    for my $test (@metas) {
        my ( $ams, $theme ) = @$test;
        my @items = $ams->name(0);
        my @failed;
        my $ok = 0;
        ( /^[A-Za-z_]\w*$/ && ++$ok ) || push @failed, $_ for @items;
        $tb->is_num( $ok, scalar @items, "All names correct for $theme" );
        $tb->diag("Bad names: @failed") if @failed;
    }
}

# t/22uniq.t
sub subtest_uniq {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    my @metas = _theme_sublists($theme);
    $tb->plan( tests => scalar @metas );

    for my $test (@metas) {
        my ( $meta, $name ) = @$test;
        my %items;
        my @items = $meta->name(0);
        $items{$_}++ for @items;

        $tb->is_num(
            scalar keys %items,
            scalar @items,
            "No duplicates for $name, ${\scalar @items} items"
        );
        my $dupes = join " ", grep { $items{$_} > 1 } keys %items;
        $tb->diag("Duplicates: $dupes") if $dupes;
    }
}

# t/23length.t
sub subtest_length {
    my ($theme) = @_;
    my $tb = __PACKAGE__->builder;

    my @metas = _theme_sublists($theme);
    $tb->plan( tests => scalar @metas );

    for my $t (@metas) {
        my ( $ams, $theme ) = @$t;
        my @items = $ams->name(0);
        my @failed;
        my $ok = 0;
        ( length($_) <= 251 && ++$ok ) || push @failed, $_ for @items;
        $tb->is_num( $ok, scalar @items, "All names correct for $theme" );
        $tb->diag("Names too long: @failed") if @failed;
    }
}

# t/24data.t
sub subtest_data {
    my ( $theme, $file ) = @_;
    $file = '' if !defined $file;
    _check_file_lines(
        $theme, $file,
        "__DATA__ section for $file",
        sub {
            my @lines;
            my $in_data;
            for my $line (@_) {
                $in_data++ if $line =~ /^__DATA__$/;
                next if !$in_data;
                push @lines, $line
                    if /^#/ && !/^# ?(?:names(?: +[-\w]+)*|default)\s*$/;
            }
            return @lines;
        }
    );
}

# t/90up2date.t
my ($has_lwp_simple, $has_test_diff, $has_network);
BEGIN {
    $has_lwp_simple = eval { require LWP::Simple;       1; };
    #$has_test_diff  = eval { require Test::Differences; 1; };
    $has_network    = $has_lwp_simple
        && LWP::Simple::get('http://www.google.com/intl/en/');
}

sub subtest_remote {
    my ($theme) = @_;
    my $class = "Acme::MetaSyntactic::$theme";

    # find out if we're in one of the many cases for skipping
    my $why
        = !$ENV{AUTHOR_TESTING}   ? 'Remote list test is AUTHOR_TESTING'
        : $ENV{AUTOMATED_TESTING} ? "Remote list test isn't AUTOMATED_TESTING"
        : !$class->has_remotelist ? "Theme $theme does not have a remote list"
        : !$has_lwp_simple        ? 'Remote list test needs LWP::Simple'
        : !$has_network           ? 'Remote list test needs network'
        :                           '';

    my $tb    = __PACKAGE__->builder;
    my @metas = _theme_sublists($theme);
    $tb->plan( tests => scalar @metas );

SKIP: {
        if ($why) {
            $tb->skip($why) for 1 .. @metas;
            last SKIP;
        }


        for my $test (@metas) {
            my ( $ams, $theme ) = @$test;

            no warnings 'utf8';
            my $current = [ sort $ams->name(0) ];
            my $remote  = [ sort $ams->remote_list() ];

            if ( !@$remote ) {
                $tb->skip("Fetching remote items for $theme probably failed");
                next;
            }

            # compare both lists
            my %seen;
            $seen{$_}++ for @$remote;
            $seen{$_}-- for @$current;
            $tb->ok( !grep( $_, values %seen ),
                "Local and remote lists are identical for $theme" )
                or $tb->diag("Differences between local and remote list:");
            $tb->diag( $seen{$_} > 0 ? "+ $_" : "- $_" )
                for grep $seen{$_}, sort keys %seen;
        }
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
theirs themes will work as expected when installed.

=head1 EXPORTED FUNCTIONS

=head2 all_themes_ok( @lib )

Will find all themes under the directories listed in C<@lib>, and run C<theme_ok()>
on them.

C<@lib> is optional (it will try to find themes in F<blib/lib> or F<lib> if not provided).

=head2 theme_ok( $theme, $source )

Will run all tests on the given C<$theme>. Some tests require access to the source, but
they will be skipped if C<$source> is not provided.

If the C<subtest_load()> test fails, no further test will be run.

=head1 SUBTESTS

The individual tests are run as subtests. All substests but C<subtest_load()>
assume that the module can be successfully loaded.

=head2 subtest_fixme( $theme, $source )

Checks that the theme source file does not contain the word "FIXME".

=head2 subtest_load( $theme )

Tries to load the theme module.

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

=head2 subtest_import( $theme )

Checks that the exported C<meta$theme> function returns an item from
C<$theme>.

=head2 subtest_noimport( $theme )

Checks that C<use Acme::MetaSyntactic::I<$theme> ()> does not export
the C<meta$theme> function.

=head2 subtest_theme( $theme )

Checks that the C<theme()> function returns the theme name.

=head2 subtest_remote( $theme )

For themes with a remote list, checks that the remote list (if any)
is identical to the current list of items in the theme.

This subtest will only be run if C<AUTHOR_TESTING> is true and
C<AUTOMATED_TESTING> is false. Requires L<LWP::Simple>.

=head1 AUTHOR

Philippe Bruhat (BooK), C<< <book@cpan.org> >>

=head1 COPYRIGHT

 Copyright 2012 Philippe Bruhat (BooK), All Rights Reserved.

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

