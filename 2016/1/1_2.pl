#! perl

use strict;
use warnings;

use Switch;

sub end {
    my ($sX, $sY) = @_;
    print "Blocks North/South: $sX , Blocks East/West: $sY\n";
    print "Total Distance ", abs($sX) + abs($sY) , "\n";
    exit;
}

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

#all on one line
my $sInstructionSet = <$rInputHandle>;
close($rInputHandle);

#remove trailing newline
chomp $sInstructionSet;
#get rid of whitespace
$sInstructionSet =~ s/\s+//g;

#split up the instructions
my @aInstructions = split (/,/, $sInstructionSet);

my $sX = 0;
my $sY = 0;
my $sDirection = 0; # 0 == North, 1 == East, 2 == South, 3 == West.

my %hHistory = ();

foreach my $sCommand (@aInstructions){
    #skip whitespace only commands (could be at the end)
    next if $sCommand =~ /^\s+$/;

    my ($sTurn, $sBlocks) = $sCommand =~ /(R|L)(\d+)/; 
    
    if($sTurn eq 'R'){
        $sDirection ++;
    }
    else{
        $sDirection --;
    }

    #new direction
    $sDirection = $sDirection % 4;

    my $sNewX = $sX;
    my $sNewY = $sY;
    for (my $sI = 0; $sI < $sBlocks; $sI++){
        switch($sDirection){
            #North
            case 0 {
                $sNewX++;
            }
            #East
            case 1 {
                $sNewY++;
            }
            #South
            case 2 {
                $sNewX--;
            }
            #West
            case 3 {
                $sNewY--;
            }
            else { 
                die "we shouldn't get here: $sDirection";
            }
        }
        
        if(exists $hHistory{$sNewX}{$sNewY} && $sPart == 2){
            print "We've been here before!\n";
            end($sNewX, $sNewY);
        }
        $hHistory{$sNewX}{$sNewY} = 1;
    }
    $sX = $sNewX;
    $sY = $sNewY;
}

end($sX,$sY);
