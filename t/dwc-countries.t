use strict;
use warnings;
use utf8;

use DwC;

use Test::More tests => 7;
BEGIN { use_ok('DwC::Plugin::Countries') };

my $dwc = DwC->new({ countryCode => "NO" });
DwC::Plugin::Countries->clean($dwc);
ok($$dwc{country} eq "Norway");

$dwc = DwC->new({ country => "Norway" });
DwC::Plugin::Countries->clean($dwc);
ok($$dwc{countryCode} eq "NO");
ok($$dwc{continent} eq "EU");

$dwc = DwC->new({ country => "納豆", countryCode => "XX" });
DwC::Plugin::Countries->validate($dwc);
like($$dwc{warning}[0][0], qr/Country code does not/);

$dwc = DwC->new({ country => "Norway", continent => "Africa" });
DwC::Plugin::Countries->clean($dwc);
DwC::Plugin::Countries->validate($dwc);
ok($$dwc{countryCode} eq "NO");
like($$dwc{warning}[0][0], qr/Continent does not match/);

