package Acme::MetaSyntactic::pokemon;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();

our %Remote = (
    source =>
        'http://en.wikipedia.org/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number',
    extract => sub {
        return    # support for Unicode female/male symbols
            map { tr/-'. /_/s; s/\xe2\x99\x80/female/; s/\xe2\x99\x82/male/; $_ }
            $_[0] =~ m!<td>(?:\d+|&#160;\?\?\?)</td>\s*<td><a href="/wiki/[^"]+" title="[^"]+">([^<]+)</a></td>!gm;
    },
);

1;

=head1 NAME

Acme::MetaSyntactic::pokemon - The Pokémon theme

=head1 DESCRIPTION

List of all Pokémon characters that are officially known to exist in the
franchise, by national Pokédex number. The English names are used in this
module.

This list is based on the following wikipedia article:
L<http://en.wikipedia.org/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number>.

=head1 CONTRIBUTOR

Abigail

Introduced in version 0.56, published on January 9, 2006.

Updated in version 0.57, published on January 16, 2006.

Updated in version 0.59, published on January 30, 2006.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>,

=cut

__DATA__
# names
Bulbasaur Ivysaur Venusaur Charmander Charmeleon Charizard Squirtle
Wartortle Blastoise Caterpie Metapod Butterfree Weedle Kakuna Beedrill
Pidgey Pidgeotto Pidgeot Rattata Raticate Spearow Fearow Ekans Arbok
Pikachu Raichu Sandshrew Sandslash Nidoran_male Nidoran_female Nidorina
Nidoqueen Nidorino Nidoking Clefairy Clefable Vulpix Ninetales Jigglypuff
Wigglytuff Zubat Golbat Oddish Gloom Vileplume Paras Parasect Venonat
Venomoth Diglett Dugtrio Meowth Persian Psyduck Golduck Mankey Primeape
Growlithe Arcanine Poliwag Poliwhirl Poliwrath Abra Kadabra Alakazam
Machop Machoke Machamp Bellsprout Weepinbell Victreebel Tentacool
Tentacruel Geodude Graveler Golem Ponyta Rapidash Slowpoke Slowbro
Magnemite Magneton Farfetch_d Doduo Dodrio Seel Dewgong Grimer Muk
Shellder Cloyster Gastly Haunter Gengar Onix Drowzee Hypno Krabby Kingler
Voltorb Electrode Exeggcute Exeggutor Cubone Marowak Hitmonlee Hitmonchan
Lickitung Koffing Weezing Rhyhorn Rhydon Chansey Tangela Kangaskhan Horsea
Seadra Goldeen Seaking Staryu Starmie Mr_Mime Scyther Jynx Electabuzz
Magmar Pinsir Tauros Magikarp Gyarados Lapras Ditto Eevee Vaporeon
Jolteon Flareon Porygon Omanyte Omastar Kabuto Kabutops Aerodactyl
Snorlax Articuno Zapdos Moltres Dratini Dragonair Dragonite Mewtwo Mew
Chikorita Bayleef Meganium Cyndaquil Quilava Typhlosion Totodile Croconaw
Feraligatr Sentret Furret Hoothoot Noctowl Ledyba Ledian Spinarak Ariados
Crobat Chinchou Lanturn Pichu Cleffa Igglybuff Togepi Togetic Natu Xatu
Mareep Flaaffy Ampharos Bellossom Marill Azumarill Sudowoodo Politoed
Hoppip Skiploom Jumpluff Aipom Sunkern Sunflora Yanma Wooper Quagsire
Espeon Umbreon Murkrow Slowking Misdreavus Unown Wobbuffet Girafarig
Pineco Forretress Dunsparce Gligar Steelix Snubbull Granbull Qwilfish
Scizor Shuckle Heracross Sneasel Teddiursa Ursaring Slugma Magcargo
Swinub Piloswine Corsola Remoraid Octillery Delibird Mantine Skarmory
Houndour Houndoom Kingdra Phanpy Donphan Porygon2 Stantler Smeargle
Tyrogue Hitmontop Smoochum Elekid Magby Miltank Blissey Raikou Entei
Suicune Larvitar Pupitar Tyranitar Lugia Ho_oh Celebi Treecko Grovyle
Sceptile Torchic Combusken Blaziken Mudkip Marshtomp Swampert Poochyena
Mightyena Zigzagoon Linoone Wurmple Silcoon Beautifly Cascoon Dustox
Lotad Lombre Ludicolo Seedot Nuzleaf Shiftry Taillow Swellow Wingull
Pelipper Ralts Kirlia Gardevoir Surskit Masquerain Shroomish Breloom
Slakoth Vigoroth Slaking Nincada Ninjask Shedinja Whismur Loudred
Exploud Makuhita Hariyama Azurill Nosepass Skitty Delcatty Sableye
Mawile Aron Lairon Aggron Meditite Medicham Electrike Manectric Plusle
Minun Volbeat Illumise Roselia Gulpin Swalot Carvanha Sharpedo Wailmer
Wailord Numel Camerupt Torkoal Spoink Grumpig Spinda Trapinch Vibrava
Flygon Cacnea Cacturne Swablu Altaria Zangoose Seviper Lunatone Solrock
Barboach Whiscash Corphish Crawdaunt Baltoy Claydol Lileep Cradily Anorith
Armaldo Feebas Milotic Castform Kecleon Shuppet Banette Duskull Dusclops
Tropius Chimecho Absol Wynaut Snorunt Glalie Spheal Sealeo Walrein
Clamperl Huntail Gorebyss Relicanth Luvdisc Bagon Shelgon Salamence
Beldum Metang Metagross Regirock Regice Registeel Latias Latios Kyogre
Groudon Rayquaza Jirachi Deoxys Munchlax Bonsly Lucario
