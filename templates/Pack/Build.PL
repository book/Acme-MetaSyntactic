use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    dist_name    => 'Acme-MetaSyntactic-ThemePack-%%%',
    license      => 'perl',
    dist_author  => 'FIXME',
    dist_version => 'FIXME',
    requires     => {
        'Test::More'          => 0,
        'Acme::MetaSyntactic' => '1.00',
    },
    add_to_cleanup => ['Acme-MetaSyntactic-ThemePack-*'],
);

$builder->create_build_script();

