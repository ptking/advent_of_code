#! perl

use strict;
use warnings;

my ($sFile) = @ARGV;

die "Please provide a file" if ( ! $sFile);

open (my $rHandle, '<', $sFile) or die "couldn't open $sFile, $!";

my $sLine = <$rHandle>;

my @aChars = split (//,$sLine);

close ($rHandle);

my $sFloor = 0;

my $sCount = 0;

foreach my $sChar (@aChars){
  $sCount++;

    $sFloor++ if( "$sChar" eq "(");
    $sFloor-- if( "$sChar" eq ")");

    if($sFloor < 0){
      print "Floor: $sFloor count: $sCount\n";
      die;
    }

    print "Floor: $sFloor char: $sChar\n";

   
}



