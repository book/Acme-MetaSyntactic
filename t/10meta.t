use strict;
use Test::More;
use Acme::MetaSyntactic;

plan tests => 8;

SHADOK: {
    my $meta = Acme::MetaSyntactic->new('shadok');
    my %seen;

    my @names = $meta->name;
    is( scalar @names, 1, "name() returned a single item" );

    push @names, $meta->name(3);
    is( scalar @names, 4, "name( 3 ) returned three more items" );

    $seen{$_}++ for @names;
    is_deeply(
        \%seen,
        { ga => 1, bu => 1, zo => 1, meu => 1 },
        "Got the whole list"
    );
}

NOTEXIST: {
    my $meta = Acme::MetaSyntactic->new('nonexistent');

    my @names = eval { $meta->name };
    like(
        $@,
        qr/Metasyntactic list nonexistent does not exist!/,
        "Non-existent theme"
    );
}

MORE: {
    my $meta = Acme::MetaSyntactic->new('shadok');
    my %seen;

    my %test;
    @test{ qw( ga bu zo meu ) } = (1) x 4;

    my @names;
    push @names, $meta->name( 5 );
    is( scalar @names, 5, "name() returned five items out of 4" );

    $test{$names[-1]}++;

    $seen{$_}++ for @names;
    is_deeply( \%seen, \%test, "Got one item twice" );
}

DEFAULT: {
    my $meta = Acme::MetaSyntactic->new();
    my %seen = map { $_ => 0 } @{ $Acme::MetaSyntactic::META{foo} };

    my @names = $meta->name;
    ok( exists $seen{$names[0]}, "From the default list" );

    %seen = map { $_ => 1 } $meta->shadok( 4 );
    is_deeply(
        \%seen,
        { ga => 1, bu => 1, zo => 1, meu => 1 },
        "Got the whole list"
    );
}

