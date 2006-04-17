use Test::More tests => 1;
use strict;
use File::Spec::Functions;
use FileHandle;

# count the contributors listed in CONTRIBUTORS
my $contributors = 0;
my $fh           = FileHandle->new();
open $fh, 'CONTRIBUTORS' or die "Can't open CONTRIBUTORS: $!";
while (<$fh>) {
    $contributors++ if /^\*/;
}
close $fh;

# check the total in Acme::MetaSyntactic
my $total = 0;
my $file  = catfile(qw{ lib Acme MetaSyntactic.pm });
open $fh, $file or die "Can't open $file: $!";
while (<$fh>) {
    /contributors \((\d+) in this version\)/ && do {
        $total = $1;
        last;
    };
}
close $fh;

# make sure the doc doesn't contradict the CONTRIBUTORS file
is( $contributors, $total, "CONTRIBUTORS and the doc agree" );

