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

my $sSum=0;

print "sCompare, sDigit, sFirst, sSum, sCount \n";

my $sSize = scalar @aDigits;

my $sSteps = $sSize/2;



for(my $sI=0; $sI < $sSize; $sI++){

    my $sDigit = $aDigits[$sI];
    
    my $sCompareIndex = ($sI+$sSteps)%$sSize;

    my $sCompare = $aDigits[$sCompareIndex];

    $sSum += $sDigit if($sDigit == $sCompare);

}


print $sSum;
