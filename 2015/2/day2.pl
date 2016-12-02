#! perl

use strict;
use warnings;


die "Usage: perl day2.pl <input>\n" if(scalar @ARGV != 1);

my ($sFile) = @ARGV;

open (my $rHandle, '<', $sFile) or die "couldn't open file $sFile, $!";

my $sCount = 0;
my $sRibbon = 0;
while ( defined(my $sLine = <$rHandle>)){
    chomp $sLine;
    my @aDimensions = split(/x/,$sLine);

    my $sL = $aDimensions[0];
    my $sW = $aDimensions[1];
    my $sH = $aDimensions[2];

    print "Present dimensions: $sL, $sW, $sH\n";

    my $sTop = $sL*$sW;
    my $sSide = $sW*$sH;
    my $sFront = $sH*$sL;

    my $sSurfaceArea = (2 * $sTop) + (2 * $sSide) + (2 * $sFront);

    my @aSideArray = ( int($sTop), int($sSide), int($sFront));
    @aSideArray = sort {$a <=> $b} @aSideArray;

    my $sSmallest = $aSideArray[0];
    my $sMiddle = $aSideArray[1];
    my $sLargest = $aSideArray[2];

    my @aDimsArray = ( int($sL), int($sW), int($sH));
    @aDimsArray = sort {$a <=> $b} @aDimsArray;

    my $sSmallestD = $aDimsArray[0];
    my $sMiddleD = $aDimsArray[1];
    my $sLargestD = $aDimsArray[2];

    print "Top: $sTop Side: $sSide Front: $sFront\n";
    print "Smallest: $sSmallest Middle: $sMiddle Largest: $sLargest\n";
    print "SmallestD: $sSmallestD MiddleD: $sMiddleD LargestD: $sLargestD\n";

    my $sTotal = $sSurfaceArea + $sSmallest;
    print "Total required: $sTotal\n";

    $sCount += $sTotal;

    # ribbon calc
    
    my $sRibbonWrap = (2 * $sSmallestD) + (2 * $sMiddleD);
    my $sRibbonBow = $sL * $sW * $sH;

    my $sRibbonTotal = $sRibbonWrap + $sRibbonBow;
    print "Ribbon Wrap: $sRibbonWrap Bow: $sRibbonBow Total: $sRibbonTotal\n";
    $sRibbon += $sRibbonTotal;
    
}

close($rHandle);

print "Req paper sq.ft.: $sCount\n";
print "Req ribbon ft.: $sRibbon\n";
