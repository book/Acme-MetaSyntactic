package main;
$INC{"Win32/Locale"} = 1;
*Win32::Locale::get_language = sub {''};
delete $ENV{LANGUAGE};
delete $ENV{LANG};
1;
