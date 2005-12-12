package Acme::MetaSyntactic::Locale;
use strict;
use Acme::MetaSyntactic (); # do not export metaname and friends
use Acme::MetaSyntactic::RemoteList;
use List::Util qw( shuffle );
use Carp;

our @ISA = qw( Acme::MetaSyntactic::RemoteList );

sub init {
    my ($self, $data) = @_;
    my $class = caller(0);

    $data ||= Acme::MetaSyntactic->load_data($class);
    croak "The optional argument to init must be a hash reference"
      if ref $data ne 'HASH';

    no strict 'refs';
    no warnings;
    for my $lang ( keys %{ $data->{names} } ) {
        @{${"$class\::Locale"}{$lang}} = split /\s+/, $data->{names}{$lang};
    }
    croak "$class defines no default language" unless $data->{default};
    ${"$class\::Default"} = $data->{default};
    ${"$class\::Theme"}   = ( split /::/, $class )[-1];

    *{"$class\::import"} = sub {
        my $callpkg = caller(0);
        my $theme   = ${"$class\::Theme"};
        my $meta    = $class->new();
        *{"$callpkg\::meta$theme"} = sub { $meta->name(@_) };
      };

    ${"$class\::meta"} = $class->new();
}

sub name {
    my ( $self, $count ) = @_;
    my $class = ref $self;

    if( ! $class ) { # called as a class method!
        $class = $self;
        no strict 'refs';
        $self = ${"$class\::meta"};
    }

    if ( defined $count && $count == 0 ) {
        no strict 'refs';
        return wantarray
          ? shuffle @{ ${"$class\::Locale"}{ $self->{lang} } }
          : scalar @{ ${"$class\::Locale"}{ $self->{lang} } };
    }

    $count ||= 1;
    my $list = $self->{cache};
    {
        no strict 'refs';
        if( @{ ${"$class\::Locale"}{ $self->{lang} } } ) {
            push @$list, shuffle @{ ${"$class\::Locale"}{ $self->{lang} } }
              while @$list < $count;
        }
    }
    splice( @$list, 0, $count );
}


sub new {
    my $class = shift;

    no strict 'refs';
    my $self = bless { @_, cache => [] }, $class;

    # compute some defaults
    if( ! exists $self->{lang} ) {
        $self->{lang} = $ENV{LANGUAGE} || $ENV{LANG} || '';
        if( !$self->{lang} && $^O eq 'MSWin32' ) {
            eval { require Win32::Locale; };
            $self->{lang} = Win32::Locale::get_language() unless $@;
        }
    }
    $self->{lang} = ${"$class\::Default"} unless $self->{lang};
    ($self->{lang}) = $self->{lang} =~ /^([-a-z]+)/;

    # fall back to last resort
    $self->{lang} = ${"$class\::Default"}
      if !exists ${"$class\::Locale"}{ $self->{lang} };

    return $self;
}

sub lang { $_[0]->{lang} }

sub languages {
    my $class = shift;
    $class = ref $class if ref $class;

    no strict 'refs';
    return keys %{"$class\::Locale"};
}

sub theme {
    my $class = ref $_[0] || $_[0];
    no strict 'refs';
    return ${"$class\::Theme"};
}

1;

__END__

=head1 NAME

Acme::MetaSyntactic::Locale - Base class for multilingual themes

=head1 SYNOPSIS

    package Acme::MetaSyntactic::digits;
    use Acme::MetaSyntactic::Locale;
    our @ISA = ( Acme::MetaSyntactic::Locale );
    __PACKAGE__->init();
    1;

    =head1 NAME
    
    Acme::MetaSyntactic::digits - The numbers theme
    
    =head1 DESCRIPTION
    
    You can count on this module. Almost.

    =cut
    
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

=head1 DESCRIPTION

C<Acme::MetaSyntactic::Locale> is the base class for all themes that are
meant to return a random excerpt from a predefined list I<that depends
on the language>.

The language is selected at construction time from:

=over 4

=item 1.

the given C<lang> parameter,

=item 2.

the current locale, as given by the environment variables C<LANGUAGE>,
C<LANG> or (under Win32) Win32::Locale.

=item 3.

the default language for the selected theme.

=back

The language codes should conform to the RFC 3066 and ISO 639 standard.

=head1 METHODS

Acme::MetaSyntactic::Locale offers several methods, so that the subclasses
are easy to write (see full example in L<SYNOPSIS>):

=over 4

=item new( lang => $lang )

The constructor of a single instance. An instance will not repeat items
until the list is exhausted.

If no C<lang> parameter is given, Acme::MetaSyntactic::Locale will try
to find the user locale (with the help of environment variables
C<LANGUAGE>, C<LANG> and Win32::Locale).

C<$lang> is a two-letter (or three (or more)) language code (taken from
the official lists of RFC 3066 and ISO 369 standards). If the list is
not available in the requested language, the default is used.

=item init()

init() must be called when the subclass is loaded, so as to read the
__DATA__ section and fully initialise it.

=item name( $count )

Return $count names (default: C<1>).

Using C<0> will return the whole list in list context, and the size of the
list in scalar context (according to the C<lang> parameter passed to the
constructor).

=item lang()

Return the selected language for this instance.

=item languages()

Return the languages supported by the theme.

=item theme()

Return the theme name.

=back

=head1 SEE ALSO

I<Codes for the Representation of Names of Languages>, at
L<http://www.loc.gov/standards/iso639-2/langcodes.html>.

=head1 AUTHOR

Philippe 'BooK' Bruhat, C<< <book@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2005 Philippe 'BooK' Bruhat, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

