package Acme::MetaSyntactic;

use strict;
use warnings;
use Carp;
use List::Util qw( shuffle );

our $VERSION = '0.01';

our %META = (
    foo => [
        qw(
          foo    bar   baz  foobar fubar qux  quux corge grault
          garply waldo fred plugh  xyzzy thud )
    ],
    shadok      => [ qw( ga bu zo meu )],
    flintstones => [
        qw( fred wilme pebbles dino barney betty bammbamm hoppy )
    ],
    batman => [
        qw(
          aieee       aiieee    awk         awkkkkkk
          bam         bang      bang_eth    bap
          biff        bloop     blurp       boff
          bonk        clange    clank       clank_est
          clash       clunk     clunk_eth   crash
          crr_aaack   crraack   cr_r_a_a_ck crunch
          crunch_eth  eee_yow   flrbbbbb    glipp
          glurpp      kapow     kayo        ker_plop
          ker_sploosh klonk     krunch      ooooff
          ouch        ouch_eth  owww        pam
          plop        pow       powie       qunckkk
          rakkk       rip       slosh       sock
          spla_a_t    splatt    sploosh     swa_a_p
          swish       swoosh    thunk       thwack
          thwacke     thwape    thwapp      touche
          uggh        urkk      urkkk       vronk
          whack       whack_eth wham_eth    whamm
          whap        zam       zamm        zap
          zapeth      zgruppp   zlonk       zlopp
          zlott       zok       zowie       zwapp
          z_zwap      zzzzzwap
          )
    ],
    toto => [ qw( toto titi tata tutu pipo ) ],
);

sub new {
    my ( $class, $theme ) = ( @_, "foo" ); # dumb default

    # defer croaking until name() is actually called

    bless { theme => $theme, cache => {} }, $class;
}

# PRIVATE
sub _name {
    my ( $self, $theme, $count ) = @_;
    $count ||= 1;

    croak "Metasyntactic list $theme does not exist!"
      unless exists $META{$theme};

    my $list = $self->{cache}{$theme} ||= [];
    push @$list, shuffle @{ $META{$theme} } if @$list < $count;

    splice( @$list, 0, $count );
}

sub name {
    my $self = shift; 
    $self->_name( $self->{theme}, @_ );
}

# CLASS METHOD
sub add_theme {
    my $class  = shift;
    my %themes = @_;

    for my $theme ( keys %themes ) {
        $META{$theme} = $themes{$theme};
        _add_method( $theme );
    }
}

# PRIVATE HELPER SUB
sub _add_method {
    my $theme = shift;
    no strict 'refs';
    *{$theme} = sub {
        my $self = shift; 
        $self->_name( $theme, @_ );
    }
}

# create the default methods
_add_method( $_ ) for keys %META;

1;

__END__

=head1 NAME

Acme::MetaSyntactic - Themed metasyntactic variables

=head1 SYNOPSIS

    use Acme::MetaSyntactic;

    my $meta = Acme::MetaSyntactic->new( 'shadok' );
    
    $meta->name;      # return a single name (at random) from the theme
    $meta->name( 4 ); # return 4 distinct names

    # you can temporarily switch theme (NOT RECOMMENDED)
    $meta->foo;       # return 1 name from theme foo
    $meta->foo(2);    # return 2 names from theme foo

=head1 DESCRIPTION

When writing code examples, it's always easy at the beginning:

    my $foo = "bar";
    $foo .= "baz";   # barbaz

But one gets quickly stuck with the same old boring examples.
Does it have to be this way? I say "No".

Here is Acme::MetaSyntactic, designed to fulfill your metasyntactic needs.
No more will you scratch your head in search of a good variable name!

=head1 METHODS & FUNCTIONS

Acme::MetaSyntactic has an object-oriented interface, as well as a
functionnal one.

=head2 METHODS

If you choose to use the OO interface, the following methods are
available:

=over 4

=item new( $theme )

Create a new instance of Acme::MetaSyntactic with the theme C<$theme>.
If C<$theme> is omitted, the default theme is C<foo>.

=item name( $count )

Return C<$count> items from the theme given in the constructor.

There is also one class method:

=over 4

=item add_theme( theme => [ @items ], ... )

This class method adds a new theme to the list.
It also creates all the convenience methods needed.

=back

=back

Convenience methods also exists for all the themes. The methods are named
after the theme.

=head1 FUNCTIONS

The functional interface will be implemented in version 0.02.

=head1 THEMES

The following themes are available in this version:

=over 4

=item batman

The fight sound effects from the 60s serial.

=item flintstones

The characters from the popular serial.

=item foo

The classic theme. This is the default theem

=item shadok

The whole shadok vocabulary. 4 words.

=item toto

The French metasyntactic names.

=back

=head1 AUTHOR

Philippe 'BooK' Bruhat, C<< <book@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-acme-metasyntactic@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

If you think this modules lacks a particular set of metasyntactic
variables, please send me a list, as well as a generation algorithm
(either one of the built-ins any, list, combine, or a new one from your
invention)

=head1 ACKNOWLEDGEMENTS

This module could not have been possible without:

=over 4

=item The Batman serial from the 60s (it was shown in France in the 80s).

All the bat sounds come from this page:
L<http://www.usfamily.net/web/wpattinson/otr/batman/batfight.htm>

=item RFC 3092 - I<Etymology of "Foo">

=item Some sillyness

See L<http://use.perl.org/~BooK/journal/22301>.

=item Rafael Garcia-Suarez,

who apparently plans to use it.

=back

=head1 COPYRIGHT & LICENSE

Copyright 2005 Philippe 'BooK' Bruhat, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

