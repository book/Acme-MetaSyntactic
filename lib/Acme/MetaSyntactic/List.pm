package Acme::MetaSyntactic::List;
use strict;
use Acme::MetaSyntactic (); # do not export metaname and friends
use List::Util qw( shuffle );

sub init {
    my $class = caller(0);
    my $data  = Acme::MetaSyntactic->load_data( $class );
    no strict 'refs';
    no warnings;
    @{"$class\::List"} = split /\s+/, $data->{names};

    # export the function
    my $callpkg = caller(1); # init is called from the subclass
    my $theme   = (split/::/, $class)[-1];
    my $meta    = $class->new;
    *{"$callpkg\::meta$theme"} = sub { $meta->name( @_ ) };
}

sub import {
}

sub name {
    my ( $self, $count ) = @_;
    my $class = ref $self;

    if( defined $count && $count == 0 ) {
        no strict 'refs';
        return
          wantarray ? shuffle @{"$class\::List"} : scalar @{"$class\::List"};
    }

    $count ||= 1;
    my $list = $self->{cache};
    {
      no strict 'refs';
      push @$list, shuffle @{"$class\::List"} while @$list < $count;
    }
    splice( @$list, 0, $count );
}

sub new {
    my $class = shift;

    bless { cache => [] }, $class;
}

1;

__END__

=head1 NAME

Acme::MetaSyntactic::List - Base class for simple lists of names

=head1 SYNOPSIS

    package Acme::MetaSyntactic::beatles;
    use Acme::MetaSyntactic::List;
    our @ISA = ( Acme::MetaSyntactic::List );
    __PACKAGE__->init();
    1;

    =head1 NAME
    
    Acme::MetaSyntactic::beatles - The fab four theme
    
    =head1 DESCRIPTION
    
    Ladies and gentlemen, I<The Beatles>. I<(hysteric cries)>

    =cut
    
    __DATA__
    # names
    john paul
    george ringo

=head1 DESCRIPTION

C<Acme::MetaSyntactic::List> is the base class for all themes that are
meant to return a random excerpt from a predefined list.

=head1 METHOD

Acme::MetaSyntactic::List offers several methods, so that the subclasses
are easy to write (see full example in L<SYNOPSIS>):

=over 4

=item new()

The constructor of a single instance. An instance will not repeat items
until the list is exhausted.

=item init()

init() must be called when the subclass is loaded, so as to read the
__DATA__ section and fully initialise it.

=item name( $count )

Return $count names (default: C<1>).

=back

=head1 AUTHOR

Philippe 'BooK' Bruhat, C<< <book@cpan.org> >>

=head1 COPYRIGHT & LICENSE

Copyright 2005 Philippe 'BooK' Bruhat, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

