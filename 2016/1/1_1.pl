#! perl

use strict;
use warnings;

use Switch;

my $sInput = shift;

die "usage: perl 1_1.pl <input>" if (scalar @ARGV != 1);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my $sInstructionSet = <$rInputHandle>;

close($rInputHandle);

chomp $sInstructionSet;

$sInstructionSet =~ s/\s+//g;

my @aInstructions = split (/,/, $sInstructionSet);

my $sX = 0;
my $sY = 0;
my $sDirection = 0; # 0 == North, 1 == East, 2 == South, 3 == West.

foreach my $sCommand (@aInstructions){
    print "$sCommand\n";

    next if $sCommand =~ /^\s+$/;

    

    $sCommand =~ /(R|L)(\d+)/;
    my $sTurn = $1;
    my $sBlocks = $2;
    
    if($sTurn eq "R"){
        $sDirection++;
    }
    else{
        $sDirection--;
    }

    $sDirection = $sDirection % 4;
    
    print "direction: $sDirection , $sBlocks\n";

    switch ($sDirection){
        case 0 { $sX += $sBlocks } # North
        case 1 { $sY += $sBlocks } # East
        case 2 { $sX -= $sBlocks } # South
        case 3 { $sY -= $sBlocks } # West
        else { die "shouldn't get here: $sDirection" }
    }
}

print "Blocks North/South: $sX Blocks East/West: $sY\n";
print "Total Distance: ", abs($sX) + abs($sY) , "\n";

