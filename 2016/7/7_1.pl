#! perl

use strict;
use warnings;

use Data::Dumper;

sub checkPattern{
    my ($sWord) = @_;

    my @aChars = split (//,$sWord);

    #cant have a 4 char pattern without 4 chars!
    return 0 if (scalar @aChars < 4);



    for(my $sI=0; $sI+3<scalar @aChars; $sI++){
        my $s1=$aChars[$sI];
        my $s2=$aChars[$sI+1];
        my $s3=$aChars[$sI+2];
        my $s4=$aChars[$sI+3];
#        print "check: ${s1}${s2}${s3}${s4}\n";
        if($s1 eq $s4 && $s2 eq $s3 && $s1 ne $s2){
            print "Pattern: ${s1}${s2}${s3}${s4}\n";
            return 1;
        }
    }
}

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";


my $sCount=0;
while(defined(my $sLine = <$rInputHandle>)){
    chomp $sLine;
    next if $sLine =~ /^\s+$/;

#    my ($sFirst,$sSecond,$sThird) = $sLine =~ /(\w+)\[(\w+)\](\w+)/;

    $sLine =~ s/\]/\[/g;
    # outer,inner,outer,inner,outer etc.
    my @aParts = split(/\[/,$sLine);

    my $sOuterCheck=0;
    my $sInnerCheck=0;

    my $sInner=-1;
    foreach my $sPart(@aParts){
        $sInner++;
        if($sInner % 2 == 0){
            if($sOuterCheck == 0){
                $sOuterCheck = checkPattern($sPart);
            }
        }
        else{
            $sInnerCheck=checkPattern($sPart);
            last if($sInnerCheck==1);
        }
    }
    if($sOuterCheck == 1 && $sInnerCheck == 0){
        print "Supports TLS: $sLine\n";
        $sCount++;
    }
}

print "Count: $sCount\n";
