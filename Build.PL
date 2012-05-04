use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Acme::MetaSyntactic',
    license           => 'perl',
    dist_author       => 'Philippe Bruhat (BooK) <book@cpan.org>',
    dist_version_from => 'lib/Acme/MetaSyntactic.pm',
    build_requires    => { 'Test::More' => '0.94', },
    requires          => {
        'File::Glob' => 0,
        'List::Util' => 0,
    },
    meta_merge => {
        resources =>
            { repository => 'http://github.com/book/Acme-MetaSyntactic', },
    },
    recommends => { 'LWP::UserAgent' => '5.802' },
    script_files   => [ 'script/meta', 'script/metafy' ],
    add_to_cleanup => ['Acme-MetaSyntactic-*'],
);

$builder->create_build_script();
