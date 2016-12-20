#! perl

use strict;
use warnings;


die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);


open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my $sCount = 0;

#read char at a time
$/ = \1;

my $sMarker=0;
my $sMarkerDivide=0;
my $sMarkerRange=0;
my $sMarkerStart=0;
my $sMarkerCount=0;

my $sNumChars = '';
my $sNumRepeats = '';

my $sSize=0;
my $sExtra=0;

while (defined( my $sChar = <$rInputHandle> ) ){
    print "$sChar - ";
    if($sMarkerStart==1 && $sExtra < $sNumChars){
        $sExtra++;
        print "increment extra\n";
        next;
    }

    if($sMarkerStart==1 && $sExtra == $sNumChars){
        $sSize = $sSize+($sNumChars*$sNumRepeats);
        print "add to size; $sNumChars \* $sNumRepeats :  $sSize reset vars\n";
        $sExtra = 0;
        $sMarkerStart=0;
        $sNumChars='';
        $sNumRepeats='';

    }

    # (\d+x\d+)
    if( $sChar eq '('){
        $sMarker=1;
        print "Marker open found\n";
        next;
    }
    
    if($sMarker == 1 ){
        if ($sChar =~ /\d/ && $sMarkerDivide == 0){
            $sNumChars .= $sChar;
            print "numchars found; $sNumChars\n";
            next;
        }
        if ($sChar =~ /x/){
            $sMarkerDivide=1;
            print "marker Divide found\n";
            next;
        }
        if ($sChar =~ /\d/ && $sMarkerDivide == 1){
            $sNumRepeats .= $sChar;
            print "num repeats found: $sNumRepeats\n";
            next;
        }
        if($sChar =~ /\)/){
            $sMarkerDivide=0;
            $sMarker=0;
            $sMarkerStart=1;
            print "end marker\n";
            next;
        }
    }

    if( ("$sNumRepeats" eq '' || "$sNumChars" eq '') && $sChar !~ /\s/){
        $sSize++ ;
        print "no marker block so increment size $sSize\n";
        next;
    }


}

print "Size: $sSize\n";
