package Acme::MetaSyntactic::jamesbond;
use strict;
use Acme::MetaSyntactic::MultiList;
use vars qw( @ISA );
@ISA = qw( Acme::MetaSyntactic::MultiList );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::jamesbond - The James Bond theme

=head1 DESCRIPTION

Items related to the James Bond movies.

This list contains 3 categories: C<films>, C<actors> and C<girls>.
The default category is C<films>.

=head1 CONTRIBUTOR

Philippe "BooK" Bruhat.

Introduced in version 0.07 (heh), published on January 31, 2005.

Updated in version 0.45, published on October 24, 2005.

Updated in version 0.70 (that's 0.07 shifted left) with actors names
and "girls" names. Both lists were provided by Abigail. Theme published
on April 17, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::MultiList>.

=cut

__DATA__
# default 
films
# names films
Dr_No From_Russia_With_Love Goldfinger Thunderball
You_Only_Live_Twice On_Her_Majesty_s_Secret_Service Diamonds_Are_Forever
Live_and_Let_Die The_Man_With_the_Golden_Gun The_Spy_Who_Loved_Me
Moonraker For_Your_Eyes_Only Octopussy A_View_to_a_Kill
The_Living_Daylights Licence_To_Kill GoldenEye Tomorrow_Never_Dies
The_World_is_Not_Enough Die_Another_Day Casino_Royale
# names actors
Sean_Connery George_Lazenby Roger_Moore
Timothy_Dalton Pierce_Brosnan Daniel_Craig
# names girls
Ursula_Andress Eunice_Gayson Zena_Marshall Daniela_Bianchi Eunice_Gayson
Honor_Blackman Shirley_Eaton Tania_Mallet Claudine_Auger Luciana_Paluzzi
Molly_Peters Karin_Dor Mie_Hama Akiko_Wakabayashi Jill_St_John Lana_Wood
Kim_Basinger Barbara_Carrera Diana_Rigg Gloria_Hendry Jane_Seymour
Madeline_Smith Maud_Adams Britt_Ekland Barbara_Bach Caroline_Munro
Sue_Vanner Emily_Bolton Lois_Chiles Corine_Clery Carole_Bouquet
Lynn_Holly_Johnson Cassandra_Harris Maud_Adams Kristina_Wayborn
Fiona_Fullerton Grace_Jones Tanya_Roberts Maryam_D_Abo Carey_Lowell
Talisa_Soto Famke_Janssen Izabella_Dorota_Scorupco Daphne_Deckers
Teri_Hatcher Cecilie_Thomsen Michelle_Yeoh Maria_Grazia_Cucinotta
Sophie_Marceau Denise_Richards Halle_Berry Rachel_Grant Rosamund_Pik
