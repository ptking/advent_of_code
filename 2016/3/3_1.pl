#! perl

use strict;
use warnings;

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my %hSquares = ();

my $sCount = 0;
my $sLineCount = 0;
while (defined (my $sLine = <$rInputHandle>)){
    $sLineCount++;

    print "Line: $sLineCount\n" if ($sLineCount % 100 == 0);
    my ($sA1, $sB1, $sC1) = $sLine =~ /(\d+)\s+(\d+)\s+(\d+)/;
    $sLine = <$rInputHandle>;
    my ($sA2, $sB2, $sC2) = $sLine =~ /(\d+)\s+(\d+)\s+(\d+)/;
    $sLine = <$rInputHandle>;
    my ($sA3, $sB3, $sC3) = $sLine =~ /(\d+)\s+(\d+)\s+(\d+)/;


    my @aArray = ($sA1, $sA2, $sA3 );
    @aArray = reverse sort {$b <=> $a} @aArray;
    $sA1 = $aArray[0];
    $sA2 = $aArray[1];
    $sA3 = $aArray[2];


    @aArray = ($sB1, $sB2, $sB3 );
    @aArray = reverse sort {$b <=> $a} @aArray;
    $sB1 = $aArray[0];
    $sB2 = $aArray[1];
    $sB3 = $aArray[2];

     @aArray = ($sC1, $sC2, $sC3 );
    @aArray = reverse sort {$b <=> $a} @aArray;
    $sC1 = $aArray[0];
    $sC2 = $aArray[1];
    $sC3 = $aArray[2];

    # my ($sT1Square, $sT2Square, $sT3Square);

    # if (exists $hSquares{$sT1}){
    #     $sT1Square = $hSquares{$sT1};
    # }
    # else{
    #     $sT1Square = $sT1 * $sT1;
    # }

    # if (exists $hSquares{$sT2}){
    #     $sT2Square = $hSquares{$sT2};
    # }
    # else{
    #     $sT2Square = $sT2 * $sT2;
    # }

    # if (exists $hSquares{$sT3}){
    #     $sT3Square = $hSquares{$sT3};
    # }
    # else{
    #     $sT3Square = $sT3 * $sT3;
    # }


    if( $sA1 + $sA2 > $sA3){
        $sCount++;
    }
    if( $sB1 + $sB2 > $sB3){
        $sCount++;
    }
    if( $sC1 + $sC2 > $sC3){
        $sCount++;
    }
}

print "Count: $sCount\n";
