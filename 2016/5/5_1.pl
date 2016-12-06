#! perl

use strict;
use warnings;

use Digest::MD5 qw(md5 md5_hex md5_base64);
# $digest = md5($data);
# $digest = md5_hex($data);
# $digest = md5_base64($data);

BEGIN { $| =1 }

die "usage: perl $0 <input>" if (scalar @ARGV != 1);

my $sInput = shift;


print "code is: ";

my $sIndex = -1;
my $sCount =0;
while(1){
  $sIndex++;

#  print "$sIndex\n" if($sIndex % 100000 == 0);

  my $sCombined = "${sInput}${sIndex}";
  my $sHashed = md5_hex("$sCombined");

  if ($sHashed =~ /^00000(\d|\w)/) {
    print "$1";
    $sCount++;

    last if $sCount == 8;
  }
}

print "\n";
