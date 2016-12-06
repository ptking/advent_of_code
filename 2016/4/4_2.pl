#! perl

use strict;
use warnings;

use Data::Dumper;

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my $sSum = 0;

my %hValidRooms;

while (defined ( my $sLine = <$rInputHandle>)){
    chomp $sLine;
    my ($sName, $sRoomNumber, $sCheckSum) = $sLine =~ /(^.+)-(\d+)\[(\w+)\]$/;
    my $sPrename = $sName;
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
    $hValidRooms{$sPrename}=$sRoomNumber;
}

print "SUM: $sSum\n";

my @aAlphabet = ('a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');
my %hAlphabet = (
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,
    'i' => 8,
    'j' => 9,
    'k' => 10,
    'l' => 11,
    'm' => 12,
    'n' => 13,
    'o' => 14,
    'p' => 15,
    'q' => 16,
    'r' => 17,
    's' => 18,
    't' => 19,
    'u' => 20,
    'v' => 21,
    'w' => 22,
    'x' => 23,
    'y' => 24,
    'z' => 25
    );

sub shiftChar {
    my ($sChar, $sShiftAmount) = @_;

    return ' ' if($sChar eq '-');

    #modulo, as more than 26 shift is just a shift in 26 + X number of loops
    
    
    my $sCurrPos = $hAlphabet{$sChar};
    my $sNewPos = ($sCurrPos + $sShiftAmount) % 26;
    my $sNewChar = $aAlphabet[$sNewPos];

#    print "Char: $sChar, Curr pos: $sCurrPos, newPos: $sNewPos, newchar: $sNewChar\n";
    return $sNewChar;
    
}

foreach my $sRoomName (keys %hValidRooms){
    my @aChars = split (//,$sRoomName);
    my $sShiftAmount = $hValidRooms{$sRoomName};
    my @aNewChars = ();
    foreach my $sChar (@aChars){
        push @aNewChars, shiftChar($sChar,$sShiftAmount);
    }
    my $sDecodedName = join ('',@aNewChars);

    print "$sDecodedName - $sShiftAmount\n";
    die if($sDecodedName =~ /northpole/i);
}
