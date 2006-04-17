#!perl -w
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::MetaSyntactic',
    AUTHOR              => 'Philippe "BooK" Bruhat <book@cpan.org>',
    VERSION_FROM        => 'lib/Acme/MetaSyntactic.pm',
    ABSTRACT_FROM       => 'lib/Acme/MetaSyntactic.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'List::Util' => 0,
    },
    EXE_FILES           => [ 'script/meta' ],
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-MetaSyntactic-*' },
);
