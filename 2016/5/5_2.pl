#! perl

use strict;
use warnings;

use Digest::MD5 qw(md5 md5_hex md5_base64);
# $digest = md5($data);
# $digest = md5_hex($data);
# $digest = md5_base64($data);

BEGIN { $| =1 }

sub printRandomCode{
    my ($raArray) = @_;
    foreach my $sVal (@{$raArray}){
        if($sVal eq '_'){
            print map { sprintf q|%X|, rand(16) } 1;
        }
        else{
            print $sVal;
        }
        
    }
    
}

die "usage: perl $0 <input>" if (scalar @ARGV != 1);

my $sInput = shift;

print "Door ID: $sInput\n";
print "Decrypting....\n";
print "        ";
my @aCode = ('_','_','_','_','_','_','_','_' );

my $sIndex = -1;
my $sCount =0;
while(1){
  $sIndex++;

#  print "$sIndex\n" if($sIndex % 100000 == 0);

  my $sCombined = "${sInput}${sIndex}";
  my $sHashed = md5_hex("$sCombined");

  if ($sHashed =~ /^00000(\d)(\d|\w)/) {
    my $sPos = $1;
    my $sChar = $2;

    next if $sPos > 7;
    if ($aCode[$sPos] eq "_"){
        $sCount++;
        $aCode[$sPos] = $sChar;
        last if $sCount == 8;
    }
  }  
  if($sIndex % 1000 == 0){
      print "\b\b\b\b\b\b\b\b";
      printRandomCode(\@aCode);
  }

}
print "\b\b\b\b\b\b\b\b";
print join ('',@aCode);
print "\n";
