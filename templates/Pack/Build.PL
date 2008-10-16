use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    dist_name    => 'Acme-MetaSyntactic-ThemePack-[% pack.name %]',
    license      => 'perl',
    dist_author  => q{[% pack.maintainer %]},
    dist_version => q{[% pack.version %]},
    requires     => {
        'Test::More'          => 0,
        'Acme::MetaSyntactic' => '[% ams.version %]',
    },
    add_to_cleanup => ['Acme-MetaSyntactic-ThemePack-[% pack.name %]-*'],
);

$builder->create_build_script();

