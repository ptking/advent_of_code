#! perl

use strict;
use warnings;

die "usage: perl day3.pl <input>" if(scalar @ARGV != 1);

my $sInputFile = shift;

my %hGrid = ();

my $XSanta = 0;
my $YSanta = 0;

my $XRobot = 0;
my $YRobot = 0;

$hGrid{'0'}{'0'} = 2;

open (my $rInputHandle, '<', $sInputFile) or die "couldn't open file: $sInputFile, $!";

my $sData = '';
while( defined (my $sLine = <$rInputHandle>)){
    
    chomp $sLine;
    $sData  .= $sLine;
}

print $sData, "\n";

my @aCmd = split (//,$sData);

my $sSwitch = 0;

foreach my $sCmd (@aCmd){
    $sCmd = lc($sCmd);

    my $X = 0;
    my $Y = 0;

    if ($sSwitch == 0){
        print "Santa's Turn! - ";
        $X = $XSanta;
        $Y = $YSanta;
    }
    else{
        print "Robot's Turn! - ";
        $X = $XRobot;
        $Y = $YRobot;
    }

    if($sCmd eq '>'){
        $X++;
    }
    elsif($sCmd eq 'v'){
        $Y--;
    }
    elsif($sCmd eq '<'){
        $X--;
    }
    elsif($sCmd eq '^'){
        $Y++;
    }
    else{
        die "Invalid command: $sCmd\n";
    }

    print "XY: $X $Y\n";

    my $sCount = 0;
    if( exists $hGrid{$X}{$Y} ){
        $sCount = $hGrid{$X}{$Y};
    }
    $sCount++;

    $hGrid{$X}{$Y} = $sCount;

    if( $sSwitch == 0){
        $XSanta = $X;
        $YSanta = $Y;
        $sSwitch = 1;
    }
    else{
        $XRobot = $X;
        $YRobot = $Y;
        $sSwitch = 0;
    }
}

use Data::Dumper;

print Dumper(\%hGrid);

my $sHouses = 0;
foreach my $sKey ( keys %hGrid){
    my $sXHouses = scalar (keys %{$hGrid{$sKey}});
    print "Number of houses on X: $sKey == $sXHouses , \n";
    $sHouses += $sXHouses;
}

print "Total Houses visited: $sHouses\n";
