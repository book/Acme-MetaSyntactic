package Acme::MetaSyntactic::RemoteList;
use strict;
use warnings;
use Carp;

# method that extracts the items from the remote content and returns them
sub extract {
    my $class = ref $_[0] || $_[0];
    no strict 'refs';
    my $func  = ${"$class\::Remote"}{extract};

    # provide a very basic default
    my $meth = ref $func eq 'CODE'
        ? sub { my %seen; return grep { !$seen{$_}++ } $func->( $_[1] ); }
        : sub { return $_[1] };    # very basic default

    # put the method in the subclass symbol table (at runtime)
    *{"$class\::extract"} = $meth;

    # now run the function^Wmethod
    goto &$meth;
}

# methods related to the source URL
sub source {
    my $class = ref $_[0] || $_[0];
    no strict 'refs';
    return ${"$class\::Remote"}{source};
}

sub has_remotelist { return defined $_[0]->source(); }

# main method: return the list from the remote source
sub remote_list {
    my $class = ref $_[0] || $_[0];
    return unless $class->has_remotelist();

    # check that we can access the network
    eval { require LWP::UserAgent; };
    if ($@) {
        carp "LWP::UserAgent not available: $@";
        return;
    }

    # fetch the content
    my $src = $class->source();
    my $ua  = LWP::UserAgent->new( env_proxy => 1 );
    my $res = $ua->request( HTTP::Request->new( GET => $src ) );
    if ( ! $res->is_success() ) {
        carp "Failed to get content at $src (" . $res->status_line() . ")";
        return;
    }

    # extract, cleanup and return the data
    my @items = $class->extract( $res->content() );

    return @items;
}

#
# transformation subroutines
#
sub tr_nonword {
    my $str = shift;
    $str =~ tr/a-zA-Z0-9_/_/c;
    $str;
}

sub tr_accent {
    my $str = shift;
    $str =~ tr{ÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙÚÛÜÝàáâãäåçèéêëìíîïñòóôõöøùúûüýÿ}
              {AAAAAACEEEEIIIINOOOOOOUUUUYaaaaaaceeeeiiiinoooooouuuuyy};
    return $str;
}

1;

__END__

=head1 NAME

Acme::MetaSyntactic::RemoteList - Retrieval of a remote source for a theme

=head1 SYNOPSIS

    package Acme::MetaSyntactic::contributors;
    use strict;
    use Acme::MetaSyntactic::List;
    our @ISA = qw( Acme::MetaSyntactic::List );
    
    # data regarding the remote source
    our %Remote = (
        source =>
            'http://search.cpan.org/dist/Acme-MetaSyntactic/CONTRIBUTORS',
        extract => sub {
            my $content = shift;
            my @items   =
                map { Acme::MetaSyntactic::RemoteList::tr_nonword($_) }
                map { Acme::MetaSyntactic::RemoteList::tr_accent($_) }
                $content =~ /^\* (.*?)\s*$/gm;
            return @items;
        },
    );

    __PACKAGE__->init();

    1;

    # and the usual documentation and list definition

=head1 DESCRIPTION

This base class adds the capability to fetch a fresh list of items from a
remote source to any theme that requires it.

To be able to fetch remote items, an C<Acme::MetaSyntactic> theme must
define the package hash variable C<%Remote> with the appropriate keys.

The keys are:

=over 4

=item C<source>

The URL where the data is available.

=item C<extract>

A reference to a subroutine that extracts a list of items from a string.
The string is meant to be the content available at the URL stored in
the C<source> key.

=back

C<LWP::Simple> is used to download the remote data.

All existing C<Acme::MetaSyntactic> behaviours
(C<Acme::MetaSyntactic::List> and C<Acme::MetaSyntactic::Locale> are
subclasses of C<Acme::MetaSyntactic::RemoteList>.

=head1 METHODS

As an ancestor, this class adds the following methods to an
C<Acme::MetaSyntactic> theme:

=over 4

=item remote_list()

Returns the list of items available at the remote source, or an empty
list in case of error.

=item has_remotelist()

Return a boolean indicating if the C<source> key is defined (and therefore
if the theme actually has a remote list).

=item source()

Return the source URL.

=item extract( $content )

Return a list of items from the C<$content> string. C<$content> is
expected to be the content available at the URL given by C<source()>.

=back

=head1 TRANSFORMATION SUBROUTINES

The C<Acme::MetaSyntactic::RemoteList> class also provides a few helper
subroutines that simplify the normalisation of items:

=over 4

=item tr_nonword( $str )

Return a copy of C<$str> with all non-word characters turned into
underscores (C<_>).

=item tr_accent( $str )

Return a copy of C<$str> will all iso-8859-1 accented characters turned
into basic ASCII characters.

=back

=head1 AUTHOR

Philippe 'BooK' Bruhat, C<< <book@cpan.org> >>.

=head1 ACKNOWLEDGEMENTS

Thanks to Michael Scherer for his help in finding the name of this
module on C<#perlfr>. Welcome in F<CONTRIBUTORS>, Michael! C<:-)>

    #perlfr Tue Nov  1 19:33 CET 2005
    <@BooK> bon, je sais toujours pas comment appeler mon module moi
    <@BooK> AMS::RemoteSource ?
    < misc> RemoteListing ?
    <@BooK> RemoteList, même

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>,
L<Acme::MetaSyntactic::Locale>.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Philippe 'BooK' Bruhat, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

