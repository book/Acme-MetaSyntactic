use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    DISTNAME  => 'Acme-MetaSyntactic-ThemePack-%%%',
    AUTHOR    => 'FIXME',
    VERSION   => 'FIXME',
    PL_FILES  => {},
    PREREQ_PM => { 'Test::More' => 0, },
    dist      => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Acme-MetaSyntactic-ThemePack-*' },
);

