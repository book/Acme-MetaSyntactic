package Acme::MetaSyntactic::metro;
use strict;
use Acme::MetaSyntactic::MultiList;
our @ISA = qw( Acme::MetaSyntactic::MultiList );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::metro - The metro theme

=head1 DESCRIPTION

This theme lists all the active stations of several subway lines.

=head2 List of cities included

All themes are divided into lines, according to the local nomenclature,
e.g. C<fr/paris/ligne_5>.

This theme currently includes the stations for the following cities:

=over 4

=item *

C<fr/paris>: Paris, France, 16 lines.

=item *

C<fr/lyon>: Lyon, France, 4 lines.

=item *

C<fr/marseille>: Marseille, France, 2 lines.

=item *

C<fr/rennes>: Rennes, France, 1 line.

=item *

C<fr/lille>: Lille, France, 2 lines.

=back

=head1 CONTRIBUTOR

Philippe 'BooK' Bruhat

Introduced in version 0.83, published on July 17, 2006.

Updated with station names for Lyon, Marseille, Lille, Rennes (with
stations grouped by line) in version 0.88, published on August 21, 2006.

=head1 DEDICATION

This module is dedicated to the Paris subway, which was opened to the
public on July 19, 1900.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::MultiList>.

=cut

__DATA__
# default
fr/paris
# names fr/paris/ligne_1
La_Defense_Grande_Arche
Esplanade_de_la_Defense
Pont_de_Neuilly
Les_Sablons
Porte_Maillot
Argentine
Charles_de_Gaulle_Etoile
George_V
Franklin_D_Roosevelt
Champs_Elysees_Clemenceau
Concorde
Tuileries
Palais_Royal_Musee_du_Louvre
Louvre_Rivoli
Chatelet
Hotel_de_ville
Saint_Paul
Bastille
Gare_de_Lyon
Reuilly_Diderot
Nation
Porte_de_Vincennes
Saint_Mande
Berault
Chateau_de_Vincennes
# names fr/paris/ligne_2
Porte_Dauphine
Victor_Hugo
Charles_de_Gaulle_Etoile
Ternes
Courcelles
Monceau
Villiers
Rome
Place_de_Clichy
Blanche
Pigalle
Anvers
Barbes_Rochechouart
La_Chapelle
Stalingrad
Jaures
Colonel_Fabien
Belleville
Couronnes
Menilmontant
Pere_Lachaise
Philippe_Auguste
Alexandre_Dumas
Avron
Nation
# names fr/paris/ligne_3
Pont_de_Levallois_Becon
Anatole_France
Louise_Michel
Porte_de_Champerret
Pereire
Wagram
Malsherbes
Villiers
Europe
Saint_Lazare
Havre_Caumartin
Opera
Quatre_Septembre
Bourse
Sentier
Reaumur_Sebastopol
Arts_et_Metiers
Temple
Republique
Parmentier
Rue_Saint_Maur
Pere_Lachaise
Gambetta
Porte_de_Bagnolet
Gallieni
# names fr/paris/ligne_3bis
Porte_des_Lilas
Saint_Fargeau
Pelleport
Gambetta
# names fr/paris/ligne_4
Porte_de_Clignancourt
Simplon
Marcadet_Poissonniers
Chateau_Rouge
Barbes_Rochechouart
Gare_du_Nord
Gare_de_l_Est
Chateau_d_Eau
Strasbourg_Saint_Denis
Reaumur_Sebastopol
Etienne_Marcel
Les_Halles
Chatelet
Cite
Saint_Michel
Odeon
Saint_Germain_des_Pres
Saint_Sulpice
Saint_Placide
Montparnasse_Bienvenue
Vavin
Raspail
Denfert_Rochereau
Mouton_Duvernet
Alesia
Porte_d_Orleans
# names fr/paris/ligne_5
Bobigny_Pablo_Picasso
Bobigny_Pantin_Raymond_Queneau
Eglise_de_Pantin
Hoche
Porte_de_Pantin
Ourcq
Laumiere
Jaures
Stalingrad
Gare_du_Nord
Gare_de_l_Est
Jacques_Bonsergent
Republique
Oberkampf
Richard_Lenoir
Breguet_Sabin
Bastille
Quai_de_la_Rapee
Gare_d_Austerlitz
Saint_Marcel
Campo_Formio
Place_d_Italie
# names fr/paris/ligne_6
Charles_de_Gaulle_Etoile
Kleber
Boissiere
Trocadero
Passy
Bir_Hakeim
Dupleix
La_Motte_Picquet_Grenelle
Cambronne
Sevres_Lecourbe
Pasteur
Montparnasse_Bienvenue
Edgar_Quinet
Raspail
Denfert_Rochereau
Saint_Jacques
Glaciere
Corvisart
Place_d_Italie
Nationale
Chevaleret
Quai_de_la_Gare
Bercy
Dugommier
Daumesnil
Bel_Air
Picpus
Nation
# names fr/paris/ligne_7
La_Courneuve_8_Mai_1945
Fort_d_Aubervilliers
Aubervilliers_Pantin_Quatre_Chemins
Porte_de_la_Villette
Corentin_Cariou
Crimee
Riquet
Stalingrad
Louis_Blanc
Chateau_Landon
Gare_de_l_Est
Poissonniere
Cadet
Le_Peletier
Chaussee_d_Antin_La_Fayette
Opera
Pyramides
Palais_Royal_Musee_du_Louvre
Pont_Neuf
Chatelet
Pont_Marie
Sully_Morland
Jussieu
Place_Monge
Censier_Daubenton
Les_Gobelins
Place_d_Italie
Tolbiac
Maison_Blanche
Porte_d_Italie
Porte_de_Choisy
Porte_d_Ivry
Pierre_Curie
Mairie_d_Ivry
Le_Kremlin_Bicetre
Villejuif_Leo_Lagrange
Villejuif_Paul_Vaillant_Couturier
Villejuif_Louis_Aragon
# names fr/paris/ligne_7bis
Louis_Blanc
Jaures
Bolivar
Buttes_Chaumont
Botzaris
Place_des_Fetes
Pre_Saint_Gervais
# names fr/paris/ligne_8
Balard
Lourmel
Boucicaut
Felix_Faure
Commerce
La_Motte_Picquet_Grenelle
Ecole_Militaire
La_Tour_Maubourg
Invalides
Concorde
Madeleine
Opera
Richelieu_Drouot
Grands_Boulevards
Bonne_Nouvelle
Strasbourg_Saint_Denis
Republique
Filles_du_Calvaire
Saint_Sebastien_Froissart
Chemin_Vert
Bastille
Ledru_Rollin
Faidherbe_Chaligny
Reuilly_Diderot
Montgallet
Daumesnil
Michel_Bizot
Porte_Doree
Porte_de_Charenton
Liberte
Charenton_Ecoles
Ecole_Veterinaire_de_Maisons_Alfort
Maisons_Alfort_Stade
Maisons_Alfort_Les_Juilliottes
Creteil_l_Echat
Creteil_Universite
Creteil_Prefecture
# names fr/paris/ligne_9
Pont_de_Sevres
Billancourt
Marcel_Sembat
Porte_de_Saint_Cloud
Exelmans
Michel_Ange_Molitor
Michel_Ange_Auteuil
Jasmin
Ranelagh
La_Muette
Rue_de_la_Pompe
Trocadero
Iena
Alma_Marceau
Franklin_D_Roosevelt
Saint_Philippe_du_Roule
Miromesnil
Saint_Augustin
Havre_Caumartin
Chaussee_d_Antin_La_Fayette
Richelieu_Drouot
Grands_Boulevards
Bonne_Nouvelle
Strasbourg_Saint_Denis
Republique
Oberkampf
Saint_Ambroise
Voltaire
Charonne
Rue_des_Boulets
Nation
Buzenval
Maraichers
Porte_de_Montreuil
Robespierre
Croix_de_Chavaux
Mairie_de_Montreuil
# names fr/paris/ligne_10
Porte_d_Auteuil
Michel_Ange_Auteuil
Eglise_d_Auteuil
Boulogne_Pont_de_Saint_Cloud
Boulogne_Jean_Jaures
Michel_Ange_Molitor
Chardon_Lagache
Mirabeau
Javel_Andre_Citroen
Charles_Michels
Avenue_Emile_Zola
La_Motte_Picquet_Grenelle
Segur
Duroc
Vaneau
Sevres_Babylone
Mabillon
Odeon
Cluny_la_Sorbonne
Maubert_Mutualite
Cardinal_Lemoine
Jussieu
Gare_d_Austerlitz
# names fr/paris/ligne_11
Mairie_des_Lilas
Porte_des_Lilas
Telegraphe
Place_des_Fetes
Jourdain
Pyrenees
Belleville
Goncourt
Republique
Arts_et_Metiers
Rambuteau
Hotel_de_Ville
Chatelet
# names fr/paris/ligne_12
Porte_de_la_Chapelle
Marx_Dormoy
Marcadet_Poissonniers
Jules_Joffrin
Lamarck_Caulaincourt
Abbesses
Pigalle
Saint_Georges
Notre_Dame_de_Lorette
Trinite_d_Estienne_d_Orves
Saint_Lazare
Madeleine
Concorde
Assemblee_Nationale
Solferino
Rue_du_Bac
Sevres_Babylone
Rennes
Notre_Dame_des_Champs
Montparnasse_Bienvenue
Falguiere
Pasteur
Volontaires
Vaugirard
Convention
Porte_de_Versailles
Corentin_Celton
Mairie_d_Issy
# names fr/paris/ligne_13
Mairie_de_Saint_Ouen
Garibaldi
Porte_de_Saint_Ouen
Guy_Moquet
Saint_Denis_Universite
Basilique_de_Saint_Denis
Saint_Denis_Porte_de_Paris
Carrefour_Pleyel
Gabriel_Peri_Asnieres_Gennevilliers
Mairie_de_Clichy
Porte_de_Clichy
Brochant
La_Fourche
Place_de_Clichy
Liege
Saint_Lazare
Miromesnil
Saint_Philippe_du_Roule
Champs_Elysees_Clemenceau
Invalides
Varenne
Saint_Francois_Xavier
Duroc
Montparnasse_Bienvenue
Gaite
Pernety
Plaisance
Porte_de_Vanves
Malakoff_Plateau_de_Vanves
Malakoff_Rue_Etienne_Dolet
Chatillon_Montrouge
# names fr/paris/ligne_14
Saint_Lazare
Madeleine
Pyramides
Chatelet
Gare_de_Lyon
Bercy
Cour_Saint_Emilion
Bibliotheque_Francois_Mitterrand
# names fr/lyon/ligne_A
Perrache
Ampere_Victor_Hugo
Bellecour
Cordelier
Hotel_de_Ville
Foch
Massena
Charpennes
Republique
Gratte_Ciel
Flachet
Cusset
Laurent_Bonevay
# names fr/lyon/ligne_B
Stade_de_Gerland
Debourg
Place_Jean_Jaures
Jean_Mace
Saxe_Gambetta
Place_Guichard
Part_Dieu
Brotteaux
Charpennes
# names fr/lyon/ligne_C
Hotel_de_Ville
Croix_Paquet
Croix_Rousse
Henon
Cuire
# names fr/lyon/ligne_D
Gare_de_Venissieux
Parilly
Mermoz_Pinel
Laennec
Grange_Blanche
Monplaisir_Lumiere
Sans_Souci
Garibaldi
Saxe_Gambetta
Guillotiere
Bellecour
Vieux_Lyon
Gorge_de_Loup
Valmy
Gare_de_Vaise
# fr/marseille/ligne_1
La_Timone
Baille
Castellane
Estrangin_Prefecture
Vieux_Port_Hotel_de_ville
Colbert_Hotel_de_région
St_Charles
Reformes_Canebiere
Cinq_avenues_Longchamp
Chartreux
St_Just_Hotel_de_departement
Malpasse
Frais_Vallon
La_Rose
# fr/marseille/ligne_2
Bougainville
National
Desiree Clary
Joliette
Jules_Guesde
St_Charles
Noailles
Notre_Dame_du_Mont_Cours_Julien
Castellane
Perier
Rond_point_du_Prado
Sainte_Marguerite_Dromel
# fr/rennes
J_F_Kennedy
Villejean_Universite
Pontchaillou
Anatole_France
Ste_Anne
Republique
Charles_de_Gaulle
Gares
Jacques_Cartier
Clemenceau
Henri_Fréville
Italie
Triangle
Blosne
La_Poterie
# fr/lille/ligne_1
Quatre_Cantons
Cite_Scientifique
Triolo
Villeneuve_d_Ascq_Hotel_de_Ville
Pont_de_Bois
Lezennes
Hellemmes
Marbrerie
Fives
Caulier
Gare_Lille_Flandres
Rihour
Republique_Beaux_Arts
Gambetta
Wazemmes
Porte_des_Postes
CHR_Oscar_Lambret
CHR_B_Calmette
# fr/lille/ligne_2
St_Philibert
Bourg
Maison_des_Enfants
Mitterie
Pont_Superieur
Lomme_Lambersart
Canteleu
Bois_Blancs
Port_de_Lille
Cormontaigne
Montebello
Porte_des_Postes
Porte_d_Arras
Porte_de_Douai
Porte_de_Valenciennes
Lille_Grand_Palais
Mairie_de_Lille
Gare_Lille_Flandres
Gare_Lille_Europe
Saint_Maurice_Pellevoisin
Mons_Sarts
Mairie_de_Mons
Fort_de_Mons
Les_Pres
Jean_Jaures
Wasquehal_Pave_de_Lille
Wasquehal_Hotel_de_Ville
Croix_Centre
Croix_Marie
Epeule_Montesquieu
Roubaix_Charles_de_Gaulle
Euroteleport
Roubaix_Grand_Place
Gare_Jean_Lebas
Alsace
Mercure
Carliers
Tourcoing_Sebastopol
Tourcoing_Centre
Colbert
Phalempins
Pont_de_Neuville
Bourgogne
CH_Dron
