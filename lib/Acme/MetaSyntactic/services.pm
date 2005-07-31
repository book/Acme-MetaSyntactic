package Acme::MetaSyntactic::services;
use strict;
use Acme::MetaSyntactic::List;
our @ISA = qw( Acme::MetaSyntactic::List );
__PACKAGE__->init();
1;

=head1 NAME

Acme::MetaSyntactic::services - The services theme

=head1 DESCRIPTION

The names of the services usually found in F</etc/services>.
This list comes from my Debian system and was extracted with:

    perl -lane '$_=$F[0];y/-/_/;!/#/&&!$s{$_}++&&print' /etc/services

Which was then golfed down to:

    perl -lane '$_=$F[0];y/-/_/;!/#/&&$s{$_}++||print' /etc/services
    perl -lane '$_=$F[0];y/-/_/;/#/||$s{$_}++||print' /etc/services
    perl -ne 's/\s.*//;y/-/_/;/#/||$s{$_}++||print' /etc/services
    perl -pe 's/[#\s].*//;y/-/_/;$s{$_}++&&goto LINE' /etc/services
    perl -ne 's/[#\s].*//;y/-/_/;$s{$_}++||print' /etc/services

A bigger services lists is used by B<nmap>:
L<http://www.insecure.org/nmap/data/nmap-services>.
A huge list of services can also be found at
L<http://www.graffiti.com/services>.

=head1 CONTRIBUTOR

Philippe "BooK" Bruhat.

Introduced in version 0.33, published on August 1, 2005.

=head1 SEE ALSO

L<Acme::MetaSyntactic>, L<Acme::MetaSyntactic::List>.

=cut

__DATA__
# names
tcpmux
echo
discard
systat
daytime
netstat
qotd
msp
chargen
ftp_data
ftp
fsp
ssh
telnet
smtp
time
rlp
nameserver
whois
tacacs
re_mail_ck
domain
mtp
tacacs_ds
bootps
bootpc
tftp
gopher
rje
finger
www
link
kerberos
supdup
hostnames
iso_tsap
acr_nema
csnet_ns
rtelnet
pop2
pop3
sunrpc
auth
sftp
uucp_path
nntp
ntp
pwdgen
loc_srv
netbios_ns
netbios_dgm
netbios_ssn
imap2
snmp
snmp_trap
cmip_man
cmip_agent
mailq
xdmcp
nextstep
bgp
prospero
irc
smux
at_rtmp
at_nbp
at_echo
at_zis
qmtp
z3950
ipx
imap3
pawserv
zserv
fatserv
rpc2portmap
codaauth2
clearcase
ulistserv
ldap
imsp
https
snpp
microsoft_ds
saft
isakmp
rtsp
nqs
npmp_local
npmp_gui
hmmp_ind
ipp
exec
biff
login
who
shell
syslog
printer
talk
ntalk
route
timed
tempo
courier
conference
netnews
netwall
gdomap
uucp
klogin
kshell
afpovertcp
remotefs
nntps
submission
ldaps
tinc
silc
kerberos_adm
webster
rsync
ftps_data
ftps
telnets
imaps
ircs
pop3s
socks
proofd
rootd
openvpn
rmiregistry
kazaa
nessus
lotusnote
ms_sql_s
ms_sql_m
ingreslock
prospero_np
datametrics
sa_msg_port
kermit
l2f
radius
radius_acct
unix_status
log_server
remoteping
rtcm_sc104
cvspserver
venus
venus_se
codasrv
codasrv_se
mon
dict
gpsd
gds_db
icpv2
mysql
nut
distcc
daap
svn
iax
radmin_port
rfe
sip
sip_tls
xmpp_client
xmpp_server
cfengine
postgresql
x11
x11_1
x11_2
x11_3
x11_4
x11_5
x11_6
x11_7
gnutella_svc
gnutella_rtr
afs3_fileserver
afs3_callback
afs3_prserver
afs3_vlserver
afs3_kaserver
afs3_volser
afs3_errors
afs3_bos
afs3_update
afs3_rmtsys
font_service
bacula_dir
bacula_fd
bacula_sd
amanda
hkp
bprd
bpdbm
bpjava_msvc
vnetd
bpcd
vopied
wnn6
rtmp
nbp
zip
kerberos4
kerberos_master
passwd_server
krb_prop
krbupdate
kpasswd
swat
kpop
knetd
zephyr_srv
zephyr_clt
zephyr_hm
eklogin
kx
iprop
supfilesrv
supfiledbg
linuxconf
poppassd
ssmtp
moira_db
moira_update
moira_ureg
spamd
omirr
customs
skkserv
predict
rmtcfg
wipld
xtel
xtelw
support
sieve
cfinger
ndtp
frox
ninstall
zebrasrv
zebra
ripd
ripngd
ospfd
bgpd
ospf6d
ospfapi
isisd
afbackup
afmbackup
xtell
fax
hylafax
distmp3
munin
enbd_cstatd
enbd_sstatd
pcrd
noclog
hostmon
rplay
rptp
nsca
mrtd
bgpsim
canna
sane_port
ircd
zope_ftp
webcache
tproxy
omniorb
clc_build_daemon
xinetd
mandelspawn
zope
kamanda
amandaidx
amidxtape
smsqp
xpilot
sgi_cmsd
sgi_crsd
sgi_gcd
sgi_cad
isdnlog
vboxd
binkp
asp
dircproxy
tfido
fido
