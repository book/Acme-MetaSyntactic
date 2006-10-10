use strict;
use Test::More;
use File::Find;
use FileHandle;

my @files;
find( sub { push @files, $File::Find::name if /^[a-z].*\.pm$/ }, 'blib' );

plan tests => scalar @files;

for my $file (@files) {

SKIP: {
        my $fh = FileHandle->new();
        open $fh, $file or do {
            skip "Can't open $file: $!", 1;
        };
        my ($fail, $in_data) = (0, 0);
        my @lines;

        while (<$fh>) {
            $in_data++ if /^__DATA__$/;
            next       if !$in_data;
            $fail++, push @lines, $.
                if /^#/ && !/^# ?(?:names(?: +[-\w]+)*|default)\s*$/;
        }
        is( $fail, 0, "__DATA__ section for $file" );
        diag "Failed lines: @lines" if @lines;
        close $fh;
    }
}
