#! perl

use strict;
use warnings;

use Switch;

use Data::Dumper;

#1000x1000 grid
sub initLights {
    my ($raLights, $sSizeX, $sSizeY) = @_;
    
    for(my $sX = 0; $sX < $sSizeX; $sX++){
        for (my $sY = 0; $sY < $sSizeY; $sY++){
            $$raLights[$sX][$sY] = 0;
        }
    }
}

sub printLights {
    my ($raLights) = @_;

    foreach my $raArray (@{$raLights}){
        foreach my $sLight (@$raArray){
            print $sLight;
        }
        print "\n";
    }
    print "\n";    
}

sub countLightsOn {
    my ($raLights) = @_;
    my $sCount = 0;
    foreach my $raArray (@{$raLights}){
        foreach my $sLight (@$raArray){
            $sCount += $sLight;
        }
    }
    print "Lights On/Brightness: $sCount\n";
}

die "usage: perl $0 <input> <X> <Y>" if scalar @ARGV != 1 && scalar @ARGV != 3;

my ($sInput, $sSizeX, $sSizeY) = @ARGV;

if (! defined $sSizeX && ! defined $sSizeY){
    $sSizeX = 1000;
    $sSizeY = 1000;
}

my @aLights;

print "initlights\n";
initLights(\@aLights, $sSizeX, $sSizeY);
print "done init lights\n";
#printLights(\@aLights);

open (my $rInputHandle, '<', $sInput) or die "couldn't open for read, $!";
my $sLinesProcessed=0;
while ( defined ( my $sLine = <$rInputHandle>)){
    $sLinesProcessed++;
    print "$sLinesProcessed\n" if ($sLinesProcessed % 10 == 0);
    chomp $sLine;
    next if $sLine =~ /^\s*$/;

    my ($sCommand, $sA, $sB, $sC, $sD) = $sLine =~ /(toggle|turn off|turn on)\s(\d+),(\d+)\sthrough\s(\d+),(\d+)/;

    print $sCommand, $sA, $sB, $sC, $sD , "\n";
    for(my $sX = $sA; $sX <= $sC; $sX++){
        for (my $sY = $sB; $sY <= $sD; $sY++){
            my $sCurrValue = $aLights[$sX][$sY];
            switch($sCommand){
                case "turn on" {
                    $aLights[$sX][$sY] = $sCurrValue + 1;
                }
                case "turn off" {
                    $aLights[$sX][$sY] = $aLights[$sX][$sY] - 1 if($sCurrValue > 0);
                    
                }
                case "toggle" {
                $aLights[$sX][$sY] = $sCurrValue + 2;
                }
                else {
                    die "shouldn't be here: $sCommand";
                }
            }
        }
    }
#    printLights(\@aLights);
}

countLightsOn(\@aLights);
#printLights(\@aLights);


#print Dumper(\@aLights);
