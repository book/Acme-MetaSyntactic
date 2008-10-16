use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    DISTNAME  => 'Acme-MetaSyntactic-ThemePack-[% pack.name %]',
    AUTHOR    => q{[% pack.maintainer %]},
    VERSION   => q{[% pack.version %]},
    PL_FILES  => {},
    PREREQ_PM => {
        'Test::More'          => 0,
        'Acme::MetaSyntactic' => '[% ams.version %]'
    },
    dist => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Acme-MetaSyntactic-ThemePack-[% pack.name %]-*' },
);

