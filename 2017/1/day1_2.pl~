#! perl

use strict;
use warnings;

my ($sInput) = @ARGV;

my $sInputString;

if(-e $sInput){
    
    open(my $rInputFileHandle, '<', $sInput) or die "couldn't open file $sInput, $!\n";

    $sInputString = <$rInputFileHandle>;
}
else{
    $sInputString = $sInput;
}


chomp $sInputString;

my @aDigits = split (//,$sInputString);

my $sFirst = $aDigits[0];
my $sPrevious = $aDigits[0];

my $sSum=0;

print "sPrevious, sDigit, sFirst, sSum, sCount \n";

for(my $sI=0; $sI < scalar @aDigits; $sI++){

    my $sDigit = $aDigits[$sI];

    next if($sI == 0);


    print "$sPrevious, $sDigit, $sFirst, $sSum, $sI \n";

    $sSum += $sPrevious if($sPrevious == $sDigit);

    $sSum += $sDigit if($sI +1 == scalar @aDigits  && $sFirst == $sDigit);

    print "$sPrevious, $sDigit, $sFirst, $sSum, $sI \n";
    $sPrevious=$sDigit;
}


print $sSum;
