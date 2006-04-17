package Acme::MetaSyntactic::punctuation;
use strict;
use Acme::MetaSyntactic::List;
use vars qw( @ISA );
@ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::punctuation - The punctuation theme

=head1 DESCRIPTION

Names of various punctuation marks.

This list is based on a browsing session starting from:
L<http://en.wikipedia.org/wiki/Punctuation>.

=head1 CONTRIBUTOR

Philippe "BooK" Bruhat.

Introduced in version 0.29, published on July 4, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
apostrophe
brackets
parentheses round_brackets parens fingernails
square_brackets
curly_brackets braces
angle_brackets chevrons
corner_brackets
comma
dash emdash endash
ellipsis suspension_points
exclamation mark
full_stop period
hyphen
interrobang
question_mark
quotation_marks single_quotes double_quotes backquote
angle_quotes single_angle_quotes double_angle_quotes
quotation_dash
guillemets
semicolon
slash solidus
space
interpunct

