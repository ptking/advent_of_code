#! perl

use strict;
use warnings;

sub Initialize {
    my ($sX, $sY) = @_;

    my @aArray;
    
    for (my $sI = 0; $sI < $sX; $sI++){
        for(my $sJ=0; $sJ < $sY; $sJ++){
            $aArray[$sI][$sJ] = ' ';
        }
    }
    return \@aArray;
}

sub rectangle {
    my ($sX, $sY, $raArray) = @_;
    my @aArray = @{$raArray};

    my $sYSize = scalar @{$aArray[0]} -1;

    for(my $sJ=0; $sJ < $sY; $sJ++){
        my $sJAug = $sYSize-$sJ;
        for (my $sI =0; $sI< $sX; $sI++){       
            $aArray[$sI][$sJAug] = '#';
        }
    }

    return \@aArray;
}

sub rotateRow {
    my ($sYIndex, $sAmount, $raArray ) = @_;
    my @aArray = @{$raArray};

    my @aRow = ();

    my $sActualIndex = (0-$sYIndex-1) % scalar @{$aArray[0]};


    for(my $sI = 0; $sI < scalar @aArray; $sI++ ){
        $aRow[$sI] = $aArray[$sI][$sActualIndex];
    }

    for(my $sI = 0; $sI < $sAmount; $sI++){
        my $sValue = pop @aRow;
        unshift @aRow, $sValue;
    }

    for(my $sI = 0; $sI < scalar @aArray; $sI++ ){
        $aArray[$sI][$sActualIndex] = $aRow[$sI];
    }
    return \@aArray;
}

sub rotateColumn {
    my ($sXIndex, $sAmount, $raArray ) = @_;
    my @aArray = @{$raArray};

    my @aColumn = ();

    for(my $sI = 0; $sI < scalar @{$aArray[0]}; $sI++ ){
        $aColumn[$sI] = $aArray[$sXIndex][$sI];
    }

    for(my $sI = 0; $sI < $sAmount; $sI++){
        my $sValue = shift @aColumn;
        push @aColumn, $sValue;
    }

    for(my $sI = 0; $sI < scalar @{$aArray[0]}; $sI++ ){
        $aArray[$sXIndex][$sI] = $aColumn[$sI];
    }
    return \@aArray;
}



sub printScreen {
    my ($raArray) = @_;

    my @aArray = @{$raArray};

    #do Y first, and go in reverse order, as Y max is top, left to right is X min
    my $sYSize = scalar @{$aArray[0]};
    print "------\n";
    for(my $sJ=$sYSize-1; $sJ >= 0; $sJ--){
        for (my $sI =0; $sI< scalar @aArray; $sI++){        
            print $aArray[$sI][$sJ];
        }
        print "\n";
    }    
}

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

my $sX = 50;
my $sY = 6;

my @aScreen = @{Initialize($sX, $sY)};

printScreen(\@aScreen);


open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

while (defined(my $sLine = <$rInputHandle>)){
    chomp $sLine;

    if($sLine =~ /rect (\d+)x(\d+)/){
        my $sX = $1;
        my $sY = $2;

        @aScreen = @{rectangle($sX,$sY,\@aScreen)};
    }
    elsif($sLine =~ /rotate row y=(\d+) by (\d+)/){
        my $sYIndex = $1;
        my $sAmount = $2;

        @aScreen = @{rotateRow($sYIndex,$sAmount,\@aScreen)};
    }
    elsif($sLine =~ /rotate column x=(\d+) by (\d+)/){
        my $sXIndex =$1;
        my $sAmount = $2;

        @aScreen = @{rotateColumn($sXIndex,$sAmount,\@aScreen)};
    }
    else{
        die "cannot understand command; $sLine\n";
    }
    printScreen(\@aScreen);
}

my $sCount = 0;
for (my $sI = 0; $sI < scalar @aScreen; $sI++){
    for(my $sJ=0; $sJ < scalar @{$aScreen[0]}; $sJ++){
        $sCount++ if ($aScreen[$sI][$sJ] eq '#');
    }
}

print "Count: $sCount\n";
