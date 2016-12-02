#! perl

use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

die "usage: perl day4.pl <key>" if(scalar (@ARGV != 1));

my $sKey = shift;

my $sNumber = -1;

my $sDigest = '';

my $sCode = '';

while($sDigest !~ /^000000/){
    $sNumber++;
    die "Error! $sDigest - $sNumber - $sCode \n" if( $sNumber > 100000000);
    $sCode = $sKey . $sNumber;
#  print "Trying: $sCode - ";
    $sDigest = md5_hex("$sCode");
#  print "Digest: $sDigest\n";
}

print "Found: $sCode with $sNumber is the smallest number with 5 zeros: $sDigest\n";
