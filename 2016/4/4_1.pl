#! perl

use strict;
use warnings;

use Data::Dumper;

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my $sSum = 0;

while (defined ( my $sLine = <$rInputHandle>)){
    chomp $sLine;
    my ($sName, $sRoomNumber, $sCheckSum) = $sLine =~ /(^.+)-(\d+)\[(\w+)\]$/;
    $sName =~ s/\-//g;

    my @aChars = split (//, $sName);
    @aChars = sort @aChars;

    my $sPrevChar = "";
    my %hCharCount = ();

    my $sFlag = 0;
    foreach my $sChar (@aChars){
        $sPrevChar = $sChar;

        if ($sFlag == 0){
            $sFlag++;
            $hCharCount{$sChar} = 1;
            next;
        }
        my $sCount = 0;
        $sCount = $hCharCount{$sChar} if(exists $hCharCount{$sChar});
        $hCharCount{$sChar} = $sCount+1 if($sChar eq $sPrevChar);
    }

    my @aCompare = ();
    # go through the list and sort them based on count
    foreach my $sChar ( sort {$hCharCount{$b} <=> $hCharCount{$a}} keys %hCharCount){
        my $sValue = $hCharCount{$sChar};
        my @aArray = ();
        @aArray = @{$aCompare[$sValue]} if( defined $aCompare[$sValue]);

        push @aArray, $sChar;
        $aCompare[$sValue] = \@aArray;
    }

    my $sCharString ="";
    my $sCount=0;
    foreach my $raArray (reverse @aCompare){
        next if !defined $raArray;
        my @aArray = @{$raArray};
        @aArray = sort @aArray;
        foreach my $sChar (@aArray){
            $sCount++;
            last if ($sCount >= 6);
            $sCharString .= $sChar;
        }
    }
    $sSum += $sRoomNumber if("$sCharString" eq "$sCheckSum");
}

print "SUM: $sSum\n";
