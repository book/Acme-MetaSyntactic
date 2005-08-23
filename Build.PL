use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Acme::MetaSyntactic',
    license             => 'perl',
    dist_author         => 'Philippe "BooK" Bruhat <book@cpan.org>',
    dist_version_from   => 'lib/Acme/MetaSyntactic.pm',
    requires => {
        'Test::More' => 0,
        'List::Util' => 0,
        'File::Glob' => 0,
        'List::Util' => 0,
    },
    script_files        => [ 'script/meta' ],
    add_to_cleanup      => [ 'Acme-MetaSyntactic-*' ],
);

$builder->create_build_script();
