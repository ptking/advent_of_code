#! perl

use strict;
use warnings;

use Switch;
use Data::Dumper;

die "usage: perl $0 <input> (part [1|2] default is 2)" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my $sInstructionSet = <$rInputHandle>;

close($rInputHandle);

chomp $sInstructionSet;

$sInstructionSet =~ s/\s+//g;

my @aInstructions = split (/,/, $sInstructionSet);

my $sX = 0;
my $sY = 0;
my $sDirection = 0; # 0 == North, 1 == East, 2 == South, 3 == West.

my %hHistory = ();


foreach my $sCommand (@aInstructions){
    
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
            print "Blocks North/South: $sNewX , Blocks East/West: $sNewY\n";
            print "Total Distance ", abs($sNewX) + abs($sNewY) , "\n";
            exit;
        }
        $hHistory{$sNewX}{$sNewY} = 1;
    }
    $sX = $sNewX;
    $sY = $sNewY;
}

print "Blocks North/South: $sX , Blocks East/West: $sY\n";
print "Total Distance ", abs($sX) + abs($sY) , "\n";
