package Acme::MetaSyntactic::booze;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::booze - The booze theme (not for tea-totalers)

=head1 DESCRIPTION

Types of alcoholic beverages.

=head1 CONTRIBUTOR

Nicholas Clark, after seeing BooK's talk at YAPC::Europe 2005 and amazed
that there was such an obvious omission.

Introduced in version 0.45, published on October 24, 2005.

=head1 BUGS

This list is incomplete. I try to drink my way further along, but I forget
where I get to. C<%-)>

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
beer
cider
perry
stout
porter
lager
wine
gin
rum
vodka
whisky
whiskey
port
sherry
absinthe

