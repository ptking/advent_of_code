#! perl

use strict;
use warnings;

use Data::Dumper;

sub checkPattern{
    my ($sWord) = @_;

    my @aChars = split (//,$sWord);

    my @aPatterns = ();

    for(my $sI=0; $sI+2<scalar @aChars; $sI++){
        my $s1=$aChars[$sI];
        my $s2=$aChars[$sI+1];
        my $s3=$aChars[$sI+2];
        if($s1 eq $s3 && $s1 ne $s2){
            my $sPattern = "${s1}${s2}${s3}";
   #         print "Pattern: $sPattern\n";
            push @aPatterns, $sPattern;
        }
    }
    return \@aPatterns;
}

sub checkInverse{
    my ($sWord,$sCompare) = @_;

    my @aChars = split(//,$sWord);

    return 0 if(scalar @aChars < 3);

    for(my $sI=0; $sI+2<scalar @aChars; $sI++){
        my $s1=$aChars[$sI];
        my $s2=$aChars[$sI+1];
        my $s3=$aChars[$sI+2];
  #      print "check: ${s1}${s2}${s3}\n";
        my $sPattern = "${s1}${s2}${s3}";
        
        return 1 if($sPattern eq $sCompare);

    }
    return 0;

}

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";


my $sCount=0;
while(defined(my $sLine = <$rInputHandle>)){
    chomp $sLine;
    next if $sLine =~ /^\s+$/;
#    print "$sLine\n";
    $sLine =~ s/\]/\[/g;
    # outer,inner,outer,inner,outer etc.
    my @aParts = split(/\[/,$sLine);
    my @aOuter=();
    my @aInner=();

    my $sInner=-1;
    foreach my $sPart(@aParts){
        $sInner++;
        if($sInner % 2 == 0){
            push @aOuter, $sPart;
        }
        else{
            push @aInner, $sPart;
        }
    }

    foreach my $sOuterPart(@aOuter){

        my $raPatterns = checkPattern($sOuterPart);

        my @aPatterns = @{$raPatterns};

        next if scalar @aPatterns == 0;
 
       
        my $sInverseCheck = 0;
        foreach my $sPattern (@aPatterns){

 #           print "$sPattern\n";
            
            my @aCompChars = split(//,$sPattern);
            my $sInverse = $aCompChars[1] . $aCompChars[0]. $aCompChars[1];
            
#            print "$sInverse\n";
            
            foreach my $sInnerPart(@aInner){
                $sInverseCheck = checkInverse($sInnerPart,$sInverse);
                last if($sInverseCheck == 1);
            }
            if($sInverseCheck == 1){
                print "SUpports SSL, pattern: $sPattern -  $sLine\n";
                $sCount++;
                last;
            }
        }
        if($sInverseCheck == 1){
            last;
        }
    }
}

print "Count: $sCount\n";
