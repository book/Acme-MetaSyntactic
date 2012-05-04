use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Acme::MetaSyntactic',
    AUTHOR              => 'Philippe Bruhat (BooK) <book@cpan.org>',
    VERSION_FROM        => 'lib/Acme/MetaSyntactic.pm',
    ABSTRACT_FROM       => 'lib/Acme/MetaSyntactic.pm',
    PL_FILES            => {},
    BUILD_REQUIRES => {
        'Test::More' => 0.94,
    },
    PREREQ_PM => {
        'File::Glob' => 0,
        'List::Util' => 0,
    },
    META_MERGE => {
        resources => {
            repository => 'http://github.com/book/Acme-MetaSyntactic',
        },
    },
    LICENSE             => 'perl',
    EXE_FILES           => [ 'script/meta', 'script/metafy' ],
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Acme-MetaSyntactic-*' },
);
