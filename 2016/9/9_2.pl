#! perl

use strict;
use warnings;


die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);


open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

sub decompress {
    my ($sString, $sDup) = @_;

    #print "Decompress: $sString $sDup\n";
    
    my @aChars = split(//,$sString);

    my $sNextMarker=0;
    my $sNextChars='';
    my $sNextRepeats='';

    my $sPreString = '';
    my $sMatchString = '';
    my $sAfterString = '';

    my $sCount=0;
    foreach my $sChar(@aChars){

        #print "decom: $sChar - ";
        
        if($sChar eq '(' && $sNextMarker == 0){
            $sNextMarker=1;
            next;
            #print "marker found\n";
        }
        if($sNextMarker == 1){
            if($sChar =~ /\d/){
                $sNextChars .= $sChar;
                #print "nextchars found: $sNextChars\n";
                next;
            }
            if($sChar =~ /x/){
                $sNextMarker=2;
                #print "next marker found\n";
                next;
            }
        }
        if($sNextMarker == 2){
            if($sChar =~ /\d/){
                $sNextRepeats .= $sChar;
                #print "nextrepeats found: $sNextRepeats\n";
                next;
            }
            if($sChar =~ /\)/){
                $sNextMarker = 3;
                #print "END MARKER\n";
                next;
            }
        }

        if($sNextMarker == 0){
            $sPreString .= $sChar;
            #print "adding to prestring: $sPreString\n";
            next;
        }
        if ($sNextMarker == 3 && $sCount < $sNextChars){
            $sMatchString .= $sChar;
            $sCount++;
            #print "Adding to match $sMatchString\n";
            next;
        }
        if($sNextMarker == 3 && $sCount >= $sNextChars){
            $sAfterString .= $sChar;
            #print "adding to after $sAfterString\n";
            next;
        }
    }



    print "$sPreString $sMatchString $sAfterString\n";
    my $sPreSize =0;
    my $sMatchSize=0;
    my$sAfterSize=0;


    $sPreSize = length($sPreString) if("$sPreString" ne "");
    $sMatchSize = decompress($sMatchString,$sNextRepeats) if("$sMatchString" ne "");
    $sAfterSize = decompress($sAfterString,1) if("$sAfterString" ne "");

    print "$sDup * ( $sPreSize + $sMatchSize + $sAfterSize ) \n";
    return $sDup * ( $sPreSize + $sMatchSize + $sAfterSize);


}

#read char at a time
$/ = \1;

my $sSize = 0;

my $sMarker =0;
my $sMarkerSize = 0;
my $sNumChars = '';
my $sNumRepeats = '';

my $sCount=0;
my $sMarkerString='';

while (defined( my $sChar = <$rInputHandle> ) ){
    #print "$sChar - ";
  START:

    # (\d+x\d+)
    if( $sChar eq '(' && $sMarker == 0){
      $sMarker=1;
      #print "Marker open found\n";
      next;
    }

    if($sMarker == 1 ){
        if ($sChar =~ /\d/){
            $sNumChars .= $sChar;
            #print "numchars found; $sNumChars\n";
            next;
        }
        if ($sChar =~ /x/){
            $sMarker=2;
            #print "marker Divide found\n";
            next;
        }
    }
    if($sMarker == 2){
        if ($sChar =~ /\d/){
            $sNumRepeats .= $sChar;
            #print "num repeats found: $sNumRepeats\n";
            next;
        }
        if($sChar =~ /\)/){
            $sMarker=3;
            #print "end of marker\n";
            next;
        }
    }
    
    if($sMarker == 0 && $sChar !~ /\s/){
        print "just increment\n";
        $sSize++;
        next;
    }

    if($sMarker == 3 && $sCount < $sNumChars){
        $sMarkerString .= $sChar;
        $sCount++;
        #print "Add to marker String: $sMarkerString\n";
        next;
    }
    if($sMarker == 3 && $sCount >= $sNumChars){
        #print "decompress inner markerstring $sMarkerString $sNumRepeats\n";
        $sSize = $sSize + decompress($sMarkerString,$sNumRepeats);
        $sCount=0;
        $sNumRepeats='';
        $sNumChars='';
        $sMarkerString='';
        $sMarker=0;
        goto START;
    }
    
    #print "\n";

}

print "Size: $sSize\n";
