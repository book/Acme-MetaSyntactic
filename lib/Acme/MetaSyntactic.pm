package Acme::MetaSyntactic;

use strict;
use warnings;
use Carp;
use List::Util qw( shuffle );

our $VERSION = '0.10';

# fill the structure with the themes data
our %META;
{
  my $key;
  local $/ = '#';
  <DATA>; # ignore the first "line"
  while(<DATA>) {
      chomp;
      my ($theme, @items) = grep { $_ } split /\s+/m;
      $META{$theme} = [ @items ];
  }
}
our $Theme = 'foo'; # the default functional theme

my $imported = 0;
my @callers = ();
sub import {
    my $class = shift;
    $Theme = shift if @_;

    my $callpkg = caller;
    push @callers, $callpkg;
    $imported++;

    for my $theme ( "name", keys %META ) {
        no strict 'refs';
        *{"$callpkg\::meta$theme"} = \&{"meta$theme"};
    }
}

sub new {
    my ( $class, $theme ) = ( @_, $Theme ); # same default everywhere

    # defer croaking until name() is actually called

    bless { theme => $theme, cache => {} }, $class;
}

# the functions actually hide an instance
my $meta = Acme::MetaSyntactic->new( $Theme );

# PRIVATE
sub _name {
    my ( $self, $theme, $count ) = @_;
    $count ||= 1;

    croak "Metasyntactic list $theme does not exist!"
      unless exists $META{$theme};

    my $list = $self->{cache}{$theme} ||= [];
    push @$list, shuffle @{ $META{$theme} } while @$list < $count;

    splice( @$list, 0, $count );
}

sub name {
    my $self = shift; 
    $self->_name( $self->{theme}, @_ );
}
sub metaname { $meta->_name( $Theme, @_ ) };

# CLASS METHOD
sub add_theme {
    my $class  = shift;
    my %themes = @_;

    for my $theme ( keys %themes ) {
        $META{$theme} = $themes{$theme};
        _add_method( $theme );
    }
}

sub themes { wantarray ? ( sort keys %META ) : scalar keys %META }

# PRIVATE HELPER SUB
sub _add_method {
    my $theme = shift;
    no strict 'refs';
    *{$theme} = sub {
        my $self = shift; 
        $self->_name( $theme, @_ );
    };
    *{"meta$theme"} = sub { $meta->_name( $theme, @_ ) };
    if( $imported ) {
        for my $pkg ( @callers ) {
            *{"$pkg\::meta$theme"} = \&{"meta$theme"};
        }
    }
}

# create the default methods
_add_method( $_ ) for keys %META;

1;

=head1 NAME

Acme::MetaSyntactic - Themed metasyntactic variables names

=head1 SYNOPSIS

    use Acme::MetaSyntactic;

    my $meta = Acme::MetaSyntactic->new( 'shadok' );
    
    print $meta->name;            # return a single name
    my @names = $meta->name( 4 ); # return 4 distinct names (if possible)

    # you can temporarily switch theme (NOT RECOMMENDED)
    my $foo = $meta->foo;       # return 1 name from theme foo
    my @foo = $meta->foo(2);    # return 2 names from theme foo


    # but why would you need an instance variable?
    use Acme::MetaSyntactic 'batman';

    print metaname;
    my @names = metaname( 4 );

    # the convenience functions are still here:
    print join $/, metabatman( 5 );

    # but a one-liner is even better
    perl -MAcme::MetaSyntactic=batman -le 'print metaname'

=head1 DESCRIPTION

When writing code examples, it's always easy at the beginning:

    my $foo = "bar";
    $foo .= "baz";   # barbaz

But one gets quickly stuck with the same old boring examples.
Does it have to be this way? I say "No".

Here is Acme::MetaSyntactic, designed to fulfill your metasyntactic needs.
Never again will you scratch your head in search of a good variable name!

=head1 METHODS & FUNCTIONS

Acme::MetaSyntactic has an object-oriented interface, as well as a
functionnal one.

=head2 Methods

If you choose to use the OO interface, the following methods are
available:

=over 4

=item new( $theme )

Create a new instance of Acme::MetaSyntactic with the theme C<$theme>.
If C<$theme> is omitted, the default theme is C<foo>.

=item name( $count )

Return C<$count> items from the theme given in the constructor.

=back

There are also some class methods:

=over 4

=item add_theme( theme => [ @items ], ... )

This class method adds a new theme to the list.
It also creates all the convenience methods needed.

=item themes( )

Return the sorted list of all available themes.

=back

Convenience methods also exists for all the themes. The methods are named
after the theme.

=head2 Functions

The functional interface provides the following functions:

=over 4

=item metaname( $count )

See C<name()>. The default is the same as for the OO interface.

=item metabatman

=item metabrowser

=item metabuffy

=item metacrypto

=item metadilbert

=item metadonmartin

=item metaflintstones

=item metafoo

=item metajamesbond

=item metaphonetic

=item metapynchon

=item metarobin

=item metashadok

=item metasimpsons

=item metatld

=item metatoto

=item metaviclones

The convenience functions are exported as expected.

If new themes are added with the C<add_theme()> class method, the
convenience functions will be created (and exported) as well.

=back

=head1 THEMES

The following themes are available in this version:

=over 4

=item batman

The fight sound effects from the 60s serial.

=item browser

Some famous web browsers.

=item buffy

The characters from London.pm's favorite serial.
Courtesy of L<http://buffyology.johnhorner.nu/>.

=item crypto

The classic characters from crypto and protocol
communications texts.

=item dilbert

Characters from the Dilbert daily strip.

=item donmartin

The sound effects from Don Martin's comics.

=item flintstones

The characters from the popular serial.

=item foo

The classic. This is the default theme.

=item jamesbond

The list of James Bond movies.

=item phonetic

The NATO official phonetic alphabet.

=item pynchon

Character names from Thomas Pynchon's books.

=item robin

Robin's exclamations, from the Batman 60's serial
(this serial's a great source of metasyntac^Wsilly stuff).

=item shadok

The whole shadok vocabulary. 4 words.

=item simpsons

The cast of the animated series.

=item tld

The list of top-level domainnames.

=item toto

The traditional French metasyntactic names.

=item viclones

A list of B<vi> clones, as maintained by Sven Guckes on
L<http://www.saki.com.au/mirror/vi/clones.php3>.

=back

=head1 AUTHOR

Philippe 'BooK' Bruhat, C<< <book@cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-acme-metasyntactic@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.  I will be notified, and then you'll automatically
be notified of progress on your bug as I make changes.

If you think this modules lacks a particular set of metasyntactic
variables, please send me a list, as well as a generation algorithm
(either one of the built-ins any, list, combine, or a new one from your
invention)

=head1 ACKNOWLEDGEMENTS

This module could not have been possible without:

=over 4

=item Some sillyness

See L<http://use.perl.org/~BooK/journal/22301>,
the follow-up L<http://use.perl.org/~BooK/journal/22710>,
and the announce L<http://use.perl.org/~BooK/journal/22732>.

=item The Batman serial from the 60s (it was shown in France in the 80s).

All the bat sounds come from this page:
L<http://www.usfamily.net/web/wpattinson/otr/batman/batfight.htm>

The list of Robin's exclamations comes from this page:
L<http://members.tripod.com/~AdamWest/robin.htm>

Robin's exclamations are also recorded here, with additional details:
L<http://www.usfamily.net/web/wpattinson/otr/batman/batholy.htm>

=item RFC 3092 - I<Etymology of "Foo">

=item Rafael Garcia-Suarez,

who apparently plans to use it. Especially now that it's usable in
one-liners.

=item Vahe Sarkissian,

who suggested the sound effects from Don Martin's comic-books,
and provided a link to a comprehensive list:

L<http://www.collectmad.com/madcoversite/dmd-alphabetical.html>

=item Sébastien Aperghis-Tramoni,

who compiled a short list of Dilbert-related names.

=item David Landgren,

who not only named all the machines in the C<mongueurs.net> (C<stencil>,
C<sferics> and C<profane>) after characters from Thomas Pynchon's books,
but also provided a first list.

The C<pynchon> list will probably grow in future versions, as
he goes through his books.

=item anonymous,

who suggested Alice, Bob and friends. A little Googling provided 
a partial list.

=back

=head1 COPYRIGHT & LICENSE

Copyright 2005 Philippe 'BooK' Bruhat, All Rights Reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

__DATA__
# foo
foo    bar   baz  foobar fubar qux  quux corge grault
garply waldo fred plugh  xyzzy thud
# shadok
ga bu zo meu
# flintstones
fred wilma pebbles dino barney betty bammbamm hoppy 
# batman
aieee       aiieee    awk         awkkkkkk
bam         bang      bang_eth    bap
biff        bloop     blurp       boff
bonk        clange    clank       clank_est
clash       clunk     clunk_eth   crash
crr_aaack   crraack   cr_r_a_a_ck crunch
crunch_eth  eee_yow   flrbbbbb    glipp
glurpp      kapow     kayo        ker_plop
ker_sploosh klonk     krunch      ooooff
ouch        ouch_eth  owww        pam
plop        pow       powie       qunckkk
rakkk       rip       slosh       sock
spla_a_t    splatt    sploosh     swa_a_p
swish       swoosh    thunk       thwack
thwacke     thwape    thwapp      touche
uggh        urkk      urkkk       vronk
whack       whack_eth wham_eth    whamm
whap        zam       zamm        zap
zapeth      zgruppp   zlonk       zlopp
zlott       zok       zowie       zwapp
z_zwap      zzzzzwap
# toto
toto titi tata tutu pipo
# robin
holy_uncanny_photographic_mental_processes
holy_priceless_collection_of_Etruscan_snoods
holy_contributing_to_the_delinquency_of_minors
holy_journey_to_the_center_of_the_earth
holy_agility                       holy_alphabet
holy_Alps                          holy_alter_ego
holy_anagrams                      holy_apparition
holy_armadilloes                   holy_armour_plate
holy_ashtray                       holy_asp
holy_astringent_plum_like_fruit    holy_astronomy
holy_autobon                       holy_backfire
holy_ball_and_chain                holy_bank_deposits
holy_bankruptcy                    holy_banks
holy_bargain_basements             holy_barracuda
holy_bat_logic                     holy_bat_trap
holy_Benedict_Arnold               holy_bijou
holy_Bill_of_Rights                holy_birthday_cake
holy_Blackbeard                    holy_blackout
holy_blank_cartridge               holy_blizzard
holy_bluebeard                     holy_bouncing_boiler_plated_fits
holy_bulls_eye                     holy_bunyons
holy_caffeine                      holy_camouflage
holy_Caruso                        holy_catastrophe
holy_cats                          holy_chicken_coop
holy_chillblaines                  holy_chocolate_eclair
holy_Cinderella                    holy_cinemascope
holy_cliche                        holy_cliffhangers
holy_clockwork                     holy_cold_creeps
holy_complications                 holy_conflagration
holy_corpusles                     holy_cosmos
holy_crack_up                      holy_crossfire
holy_crucial_moment                holy_cryptology
holy_crystal_ball                  holy_dart
holy_Davey_Jones                   holy_dead_end
holy_deposit_slip                  holy_detonation
holy_detonator                     holy_deviltry
holy_dilemna                       holy_disappearing_act
holy_distortion                    holy_diversionary_tactics
holy_eggshells                     holy_Einstein
holy_encore                        holy_epicure
holy_epigrams                      holy_escape_hatch
holy_explosion                     holy_false_front
holy_fate_worse_than_death         holy_felony
holy_finishing_touches             holy_fireworks
holy_firing_squad                  holy_fishbowl
holy_flight_plan                   holy_flip_flop
holy_floodgate holy_floor_covering holy_flypaper
holy_fly_trap                      holy_fog
holy_forecast                      holy_fork_in_the_road
holy_Fourth_Amendment              holy_Fourth_of_July
holy_Frankenstein                  holy_fratricide
holy_fruit_salad                   holy_fugitives
holy_funny_bone                    holy_gall
holy_gambles                       holy_gemini
holy_geography                     holy_ghost_writer
holy_giveaways                     holy_Golden_Gate
holy_graft_zepplin                 holy_grammar
holy_graveyard                     holy_greed
holy_green_card                    holy_guacamole
holy_gullibility                   holy_gunpowder
holy_haberdashery                  holy_hailstorms
holy_hairdo                        holy_hallelujah
holy_hamburger                     holy_Hamlet
holy_hamstrings                    holy_handiwork
holy_happenstance                  holy_hardest_metal_in_the_world
holy_harem                         holy_haziness
holy_headache                      holy_headlines
holy_heartbreak                    holy_heart_failure
holy_helmets                       holy_helplessness
holy_here_we_go_again              holy_hidal_burn
holy_hieroglyphics                 holy_high_wire
holy_hijack                        holy_hijackers
holy_history                       holy_hoaxes
holy_hole_in_a_donut               holy_Hollywood
holy_holocaust                     holy_homecoming
holy_homework                      holy_homicide
holy_hood_wink                     holy_hoofbeats
holy_horseshoes                    holy_hostage
holy_hot_foot                      holy_hot_spot
holy_Houdini                       holy_human_collector_s_item
holy_human_pearls                  holy_human_pearls
holy_human_pressure_cookers        holy_human_surfboards
holy_hunting_horn                  holy_hurricane
holy_hutzpah                       holy_hydraulics
holy_hyperdermics                  holy_hypnotism
holy_hypotheses                    holy_iceberg
holy_icepicks                      holy_ice_skates
holy_impossibility                 holy_impregnability
holy_incantation                   holy_inquisition
holy_interplanetary_yard_stick     holy_interruptions
holy_iodine                        holy_IT_n_T
holy_Jack_in_the_Box               holy_jackpot
holy_jail_break                    holy_jawbreaker
holy_jelly_moulds                  holy_jet_set
holy_jetset                        holy_jigsaw_puzzle
holy_jitterbug                     holy_karate
holy_karats                        holy_keyhole
holy_keyring                       holy_kilowatts
holy_kindergarten                  holy_knit_one_pearl_two
holy_knockout_drops                holy_known_flying_objects
holy_Koufax                        holy_Las_Vegas
holy_levitation                    holy_living_end
holy_lodestone                     holy_looking_glass
holy_love_birds                    holy_Luthor_Burbank
holy_madness                       holy_magician
holy_mainframe                     holy_mashed_potatoes
holy_masked_potatoes               holy_masquerade
holy_matador                       holy_mechanical_armies
holy_mechanical_marvel             holy_memory_bank
holy_mermaid                       holy_mesmerism
holy_metronome                     holy_miracle
holy_miscast                       holy_missing_relatives
holy_molars                        holy_Motor_Von_Bon
holy_movie_moguls                  holy_mucelage
holy_multitudes                    holy_murder
holy_mush                          holy_naivete
holy_nerve_center                  holy_New_Year_s_Eve
holy_nick_of_time                  holy_nightmare
holy_non_sequiturs                 holy_oil_factory
holy_olee_o                        holy_olfactory
holy_one_track_batcomputer_mind    holy_ordeuvres
holy_oversight                     holy_oxygen
holy_paraffin                      holy_Parefski
holy_perfect_pitch                 holy_piano
holy_pin_cushions                  holy_polar_front
holy_polar_ice_sheet               holy_popcorn
holy_precision                     holy_pseudonym
holy_purple_cannibals              holy_puzzlers
holy_rainbow                       holy_rainbow
holy_rats_in_a_trap                holy_rat_trap
holy_ravioli                       holy_razor_s_edge
holy_recompense                    holy_red_herring
holy_red_snapper                   holy_reincarnation
holy_relief                        holy_remote_control_robot
holy_resourcefulness               holy_return_from_oblivion
holy_reverse_polarity              holy_rheostat
holy_ricochet                      holy_riot_ball
holy_Rip_Van_Winkle                holy_rising_headlights
holy_rising_hemlines               holy_roadblocks
holy_Robert_Louis_Stevenson        holy_rock_garden
holy_rocking_chair                 holy_Romeo_and_Juliet
holy_rudder                        holy_safari
holy_sarcophagus                   holy_schizophrenia
holy_seditives                     holy_self_service
holy_semantics                     holy_serpentine
holy_sewer_pipe                    holy_shamrocks
holy_Sherlock_Holmes               holy_showcase
holy_show_ups                      holy_shrinkage
holy_shucks                        holy_skull_tap
holy_skyrocket                     holy_slipped_disc
holy_smoke                         holy_smokestack
holy_snowball                      holy_sonic_booms
holy_special_delivery              holy_spiderwebs
holy_split_seconds                 holy_squirrel_cage
holy_stalactites                   holy_stampede
holy_standstills                   holy_stereo
holy_stewpot                       holy_stomach_ache
holy_straightjacket                holy_stratosphere
holy_stuffing                      holy_sub_orbit
holy_sudden_incapacitation         holy_sun_dial
holy_surprise_parties              holy_switcheroo
holy_Taj_Mahal                     holy_tartars
holy_taxadermy                     holy_taxation
holy_taxidermy                     holy_tee_shot
holy_ten_toes                      holy_terminology
holy_timebomb                      holy_tintanabulation
holy_tipoff                        holy_Titanic
holy_tome                          holy_toreador
holy_trampoline                    holy_transistors
holy_trasitor_s_bill               holy_travel_agent
holy_trickery                      holy_triple_feat
holy_trolls_and_goblins            holy_tuxedo
holy_understatements               holy_underwritten_metropolis
holy_unknown_flying_objects        holy_unlikelihood
holy_unrefillable_prescriptions    holy_vacuum
holy_Venuzuela                     holy_vertebra
holy_voltage                       holy_waste_of_energy
holy_Wayne_Manor                   holy_weaponry
holy_wedding_cake                  holy_whiskers
holy_wigs                          holy_Zorro
# donmartin
aaaagh aaak aaeefwofaaee aagh aahht aaht aak aarh ack aeek agh ahh ahh
ahhh ahhh_glukle ahhhhhhhhhh ahweeeeee_ak ak aling aooga aoooga applaud
araragh arargh arg argh argle arrargh arrarghnnarrgh arrargle arrgh awk
bahoo bak bam bam_bam bang bap bap_krak barf barramm bash b_b_b_borfft
bbblplast bbfrprafpghpp bbllbbllbbllbbllbbll beaugh beedoop beeyoop
bing bizzzt blam blamp blap blapple blatch bleeble bleegh bleep blib
blib_blib blidit blif blink blink bliomp blit blobble bloit blonk bloof
bloom bloombloom bloooot bloop blop blorf blorp blort blub bluka blut
boil bong boom booma booma_roomba boomer_room boong bplflt braghk brak
brap bravo brbbrbbring breebeep breedeet breep_breep breet breet_breet
bring brnngt broodoot broom broot brrrapp brrrnng bump bur_rp bwaughk
bweep bzownt bzznnt bzzownt bzzt bzzz bzzzt cak caw caw_caw_caw cha_gonk
chaka chaklak chakunk chakunk_ding_rip cheeomp cheep chika chika_chunk
chimp chip chirp chk chomp chompity_chomp chomple chonk chook chop
chop_chop chuckle chuga chuh chukkunk_clunk chunk chunka chunk_kashink
clack claka clang clank clap clap_clap clatta clatter clatter_clatter
click clik clik clik clik_clik_clik_clik clink clip_clap cloink clomp
clonk cook crackle crash crugazunch crunch crunchle daba dabwak da_flaf
dak dakdik dakka dakkadak dakkitydak dang dapada dapadda deebe deep dig
dik dikka dimpah din ding dingalina dingalinga dink dink_dink_dink_dink
dipada dipadda dit dit_clunk doink doip doip doit dokka domp dong
don_t dooba doobada doobadoobadooba doodle doom dooma doomp doonk doont
dooot doop doot dootbweet dripple droot dubba dugga durp eat ecch eck
eckeck eeaheeaheeaheeaheeah eech eeeaaagh eeeeeeeeeeeeeeeee eeeeeooow
etc faba fabadap faglork fagroon fagrooosh fagwasshhhh fagwoosh fak
fap fapadda faroolana farrappght fashklork fashunk fat fazzat ferrap
ferrip few ffffoooooooo fffpfwrap fffrrraapft ffpghftp fiddit fidip_fidip
fiff_frrep fink fip fip_fip fit fitz fitzrower fizzazzit fizzitz flabadap
fladat fladip flaf flaffliff flak flap flapf fleedle flibadip flif flif
fliff fliff flifflaff fliffle fliffle flik flik fling flink flip flit
flizaff floba_dap flof flok floof floof floofity floom floon floot
flop floploploplop florf flork flot fluk flut fomp_dabomp foof foom
foomp foon foop foosh foosht foowoom fop fowm fpfworpft frit froom
frugga fsssh fump funk funkada fursh furshglurk fush fushshklork fut
fwabadap fwach fwaddapp fwak fwam fwap fwapada fwask fwee fweee fweeee
fweeeee fweeeeeeeee fween fweep fwiffffff fwip fwip fwip fwipada fwisk
fwisk fwiskitty fwit fwit_thhat fwizz fwizzach fwizzap fwizzish fwof
fwoof fwoosh fwooshsh fwop fwump fxlgxtlkfxg gaah gack gadaff gadang
gadiff_gadiff gadink gadoing gadong gadoon gaflor gahak gahoff gahork gak
galink galoon galooom gamop gaplonk gaplork gark garoof garrargh garrgh
garunk gashklitz gashklitzka ga_shklurtz gashkutzga gashlikt ga_shloip
gashook gashplutzga gaskrooch gasmatch gasmitch gasp gasp gasploosh
ga_splortch gasplush ga_wiz gazap gazikka gazoont gazownt geeen geen ghomp
gigazing gikkadik ging ging gishklork gishklurk gladink glakkle glangadang
glank glap glargle glawk gleep gleet_gleet glik glika_glika glikle glink
glink glip glish glit glitch glit_glikity gloing gloip glomp glong glont
gloochle gloodle glook gloop gloople gloot_gloot glorgle glork glorkle
glorp glort gloydoip glug gluk glukkle glukkle_gluk glunk glup glurgle
glurk glurkle glut glutch going gonk googlooom gooma_doom goosh gorshle
goyng grak grasp grawk greedle_greedle gring groink groom groon growr
growrrooom growwwwmmm grrm grrown grrr grrrrrr grunch gukguk gurgle gurn
gush guwk gwap gyaaught ha haah hac hak hakkle har hee_de_hee_hee heh
help hic hic hit hmmmm hm_m_m_m ho ho_hum honk hooray hoot huff huffa
huffle_puffle hush hushle ing inkle_klink jugarum ka kaboff ka_bong
kaboomm kachaah kachonk kachoo kachugh kachunk kachunka kachunk_kachunk
kachunk_kachunka kadoonk kahak kaheeee kahikf kaka_splak kakkakkakak
kakroosh kalloon kaloong kapf kaplak_kak kaplam kapoooshshish karrak
kash kashook kashpritza katoof katoong katoonk katy_did katy_didn_t kawk
kazak kazash kazik kazop kchgghck k_chook kerackk kik kikatik king kipf
kiss kittoong kkchk kkkkkkkkkkkk kkksh kkkssh kladwak klak klak_klak
klakkle klang klank klik klik klik_chikaklak klik_klik klik_klik_chaklik
klik_klik_klik klikrunk klik_sproing kling klingdinggoon klink klink
klinkadink kloink klomp klong klonk kloobada kloon kloong kloonk klooonn
klop kluk klumble klump klunk klupada knock koff kookook koong kopf
krak krakkle krakle krarkle krash kreek kridit_kridit krik krik_krikit
krugazunch krunch krunchle ksshfwoom ksssh kuk kwapp kweee kweek kwoip
kwong kwonk kwop laflatch leddle m mabbit mamp map_map mcpwaf mimpah mmmmm
mmmmmm mmmmmmmm mmmp mmm_shlurk mmp mmph mop mowm muffle nnyeeownnt nok
not_a_sound oggock ogh onnnnnghk oof ooga ooh oomp oonk oont oooh oookk
ooooooiiiiiiyyyyy oot padap paf pak pam pat patwang patweeee pblrblpsft
pffft_frack pflap phelop phlakffa phoom phoon phooo phwam pik ping ping
pink pitooie pittoo pittooie pittooie pittween pittwoon plablablablab
plablablablabl plaf plak plam plap plapf plif plink plipple plobble ploip
ploip plonk ploobadoof ploof ploom ploomploomploom ploop ploosh plop plorf
plork plortch pluf plunk plurp poffisss poing poing poing poink poink
poink poit poit poit pok poong pop pop___sproing_ging pow prawk psssh
pssssh pucka puff puff puffa pull putt pwadak pwam pween pwof pwoing pwok
pwompf quack quack_quack quiet qwack rah_ooom rattle rawgh rip ripf ror
rowm rowr rrip rrroooom rrrrr rrrrreerrr rrrrrr rumble rumboom_blooma
sazzikk schklurt schlap schlep schlip schlit schloop schloot scrape
screeeezt shabamp shak sha_pap shash shashwik shazzatz shhh shhhsk
shiffle shif_shaf shik shika shika_shika shk shkalink shkaloink shklakle
shklazitch shklik shklik shkliksa shklink shklitza shklitza shklizich
shklizortch shklizzitz shklizzortch shkloort shklop shklorbbadorp
shklorp shklunk shklurch shklurk shkwitz shlak shlik shlikle shlipp
shlook shloop shlork shlorp shlurk shlurp shmuzorft shnikkle shnip
shnorkle shompah_bombah shooga shook shooka shooo shossh shpikkle
shpishle shplep shpliple shploip shpooosh shpork shtik shtoink shtork
shuffle shuka shusshh shwik shwika silence sit sittzle sitz sizzle
sizzotz skapasch skaplunch skaproing skazeech skazooch sklazoncho
sklerch sklik sklishitty sklishk sklitch sklizzorch skloosh sklop sklork
sklorsh sklortch skloshitty skluk sklukle sklurk sklush skniffle sknikle
sknitch sknosh skrak skrakit skrawk skrazatz skrazitz skreech skreee
skreeee skreeeee skreeeeee skreeeeeeek skreeeeek skreeeek skreeek
skreek skreekle skreeyeeek skreeyeeyeeyeeyeek skribble skrich skricha
skrink skritch skroik skroinch skronch skronk skroom skroook skrotch
skrunch skruncha skwa_ba_dap skwako skwappo skweek skwik skwonk slapth
slice slice slobble sloople slotch slurk slurp smack smak smash smek
snap snat snif sniff sniffle snikker snip snip snork snuffle sob spa
spa_dow spaloosh spamamp spamp spap spash spashle spatz spazat spazoosh
spitz spladish_spladish spladunk splak spla_map splap splapidy_splip
splapple splash splat splatch splazatch splazitch splazoosh splesh splish
splishidy_splash splishidy_splashidy splishle splitch sploit sploosh
splop splork splorp splorple splort splosh sploydoing splurp spmam spmamp
spmap spoof spoosh spoosht spop spopple sprat sprazot spritsits spritz
sprizawitz sprizzitz sproing sproing sproingachonk sproingdoink sproink
sprop sprowmmm spukkonk spush sput sputz sputz_spitza spwako spwang spwap
spwappo spwat ssat sslit ssssssss sssssssst sssst stamp stealth stoink
stoof stoong stoopft stroinggoink sut swap swat swif swipadda swish swit
swit_plop swit_plop swit_swit swizap swizzak swizzat_swat swoosh sworf tak
takka tap tap tap_tap_tap ta_tagak tattatattat tear teeoo tffp thaff thak
thap thaploof thhhht thhhut thhlorp thikoosh thiz thlbbadup thlik thlip
thloop thluck thlup thoip thoipoing thomp thoo thoof_foing thoom thoomp
thoonoonn thooo thop thork thot thubalup thud thugawunk thuk thump thunck
thurch thuthhhh thwa_dap thwak thwap thwat thwip thwip thwit thwizzik
thwock thwok thwop thwuk tik tika tika_tika tikatik_chirp tikka tikkak
tik_tik tik_tika ting ting ting_aling tingalinga tink tip_tippity toing
tok tong tonk tood toodle toof toomp toon toong toonk tooong tooooo
toowit toowoo tromp trump tubba tweedle tweee tween twok twong twop
twoyyoyyoing tzing tzong tzoong tzwang ugh uk ulp umble umpf umph unklik
urp urrsssh ursshhh uuuuurp varoom varroom voofen voom voomarooma vow vowm
vown vreen vroom vroom_spak vroon vrooon vwoo waak wak walk wam wamp wap
wawkle wee weeeeeee weeeoooo weeeoooowee weeeooooweeeooo weeeoooweeeooowee
weeoooeeeooo weeoooo weeooweeeoooo weeooweeoooo whak wham whap wheeah whir
whir whirr whisk whomp whoooooooo whoosh wink winkity wink_wink wiz wong
wonk wooosh woopwoopwoop wunk wunkada xmng yaach yaah yaaugh yaggak yahhah
yak yarg yarg yargh yea yeech ying yippee yip_yip yip_yip_yip yowyowyow
yug yuk yukkle zachitty zak zap zat zazik zazzik zeem zgluk zich zidit
zik zika_zika zikka zikkik zik_zik zikzikzik zikzikzikzikzikzik zingo
zip zit zit_sreek zit_zat_zat zit_zit_zit zitzizizizzzzzz ziz ziz ziz
zizazik zizzak zlitz zock zooka zooo zoot zot zowm zownt zunch zweech
zween zweet zwit zwit_sproing zwot zzip zzt_chomp zzt_znik zzz zzzz
zzzzoownt zzzzz zzzzzz zzzzzzz zzzzzzzz zzzzzzzzz zzzzzzzzzzz
# dilbert
dilbert dogbert catbert
ratbert bob dawn rex liz alice asok wally tina carol ted
mordac ted phil elbonia pointy_haired_boss
# pynchon
porpentine slothrop stencil profane   godolphin  yoyodyne
waste      sferics  oedipa  mondaugen eigenvalue schlozhauer
schoenmaker bongo_shaftsbury maijstral achtfaden sachsa mantissa
# crypto
alice bob charlie doris eve fred ginger harry irene janet 
# simpsons
bart lisa marge homer maggie moe mr_burns itchy scratchy grampa ned snowball
# browser
mozilla netscape msie mosaic links lynx w3m opera galeon konqueror safari
camino dillo amaya arachne omniweb planetweb voyager
# tld
ad ae af ag ai al am an ao aq ar as at au aw ax az ba bb bd be bf bg bh
bi bj bm bn bo br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co
cr cs cu cv cx cy cz de dj dk dm do dz ec ee eg eh er es et fi fj fk fm
fo fr fx ga gb gd ge gf gh gi gl gm gn gp gq gr gs gt gu gw gy hk hm hn
hr ht hu id ie il in io iq ir is it jm jo jp ke kg kh ki km kn kp kr kw
ky kz la lb lc li lk lr ls lt lu lv ly ma mc md mg mh mk ml mm mn mo mp
mq mr ms mt mu mv mw mx my mz na nc ne nf ng ni nl no np nr nu nz om pa
pe pf pg ph pk pl pm pn pr ps pt pw py qa re ro ru rw sa sb sc sd se sg sh
si sj sk sl sm sn so sr st su sv sy sz tc td tf tg th tj tk tl tm tn to tp
tr tt tv tw tz ua ug uk um us uy uz va vc ve vg vi vn vu wf ws ye yt yu za
zm zr zw biz com edu gov int mil net org pro aero arpa coop info name nato
# jamesbond
Die_Another_Day                 The_World_is_Not_Enough
Tomorrow_Never_Dies             GoldenEye             Licence_To_Kill
The_Living_Daylights            A_View_to_a_Kill      Octopussy           
For_Your_Eyes_Only              Moonraker             The_Spy_Who_Loved_Me 
The_Man_With_the_Golden_Gun     Live_and_Let_Die      Diamonds_Are_Forever  
On_Her_Majesty_s_Secret_Service You_Only_Live_Twice   Thunderball     
Goldfinger                      From_Russia_With_Love Dr_No
# phonetic
alpha   bravo charlie  delta echo foxtrot golf  hotel  india juliet  kilo
lima    mike  november oscar papa quebec  romeo sierra tango uniform victor
whiskey xray  yankee   zulu
# buffy
Adam Angel Anya Buffy Cordelia Darla Dawn Drusilla Faith Giles Glory
Jenny Jonathan Joyce Kendra Oz Snyder Prof_Walsh Riley Spike Tara
The_Master The_Mayor Warren Wesley Willow Xander
# viclones
BBStevie bedit Bvi calvin e3 Elvis exvi elwin javi jVi Lemmy levee nvi
Oak_Hill_vi PVIC trived tvi vigor vile vim Watcom_VI WinVi viper virus
xvi
