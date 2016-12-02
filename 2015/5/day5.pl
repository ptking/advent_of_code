
#! perl

use strict;
use warnings;
use Data::Dumper;


die "usage: perl day5.pl <Input>" if (scalar @ARGV != 1);

my $sInput = shift;


sub contains3Vowels {
  my $sWord = shift;
  
  return 1 if( $sWord =~ /.*[aeiou].*[aeiou].*[aeiou]/);
  return 0;

}


sub contains2Consecutive {
  my $sWord = shift;

  my @aLetters = split(//,$sWord);

  my $sPrevLetter = $aLetters[0];

  my $sCount = scalar (@aLetters);

  for(my $I = 1; $I < $sCount; $I++){
      my $sCurrent = $aLetters[$I];
      return 1 if $sPrevLetter eq $sCurrent;
      $sPrevLetter = $sCurrent;
  }
  return 0;
}

sub notContain{
    my $sWord = shift;
    return 0 if($sWord =~ /ab|cd|pq|xy/);
    return 1;
}

sub pair {
    my $sWord = shift;

    my %hPairs = ();

    my @aLetters = split(//,$sWord);
    my $sCount = scalar (@aLetters);

    for(my $I = 0; $I+1 < $sCount; $I++){

        my $sPair = $aLetters[$I] . $aLetters[$I+1];

        my $sNumPairs = 0;
        $sNumPairs = $hPairs{$sPair}{'NUM'} if(exists $hPairs{$sPair});
        #print "NumPairs: $sNumPairs \n";
        $sNumPairs++;

        #print "NumPairs: $sNumPairs \n";

        $hPairs{$sPair}{'NUM'} = $sNumPairs;        
        $hPairs{$sPair}{$sNumPairs} = $I;
    }

    foreach my $sPair (keys %hPairs){

        my $sNumPairs = $hPairs{$sPair}{'NUM'};
        if( $sNumPairs > 1){
            
           for(my $I = 1; $I < $sNumPairs; $I++){
               my $sPrev = $hPairs{$sPair}{$I};
               my $sCurrent = $hPairs{$sPair}{$I+1};

               if ($sPrev != $sCurrent && $sPrev + 1 != $sCurrent){
                   #print "Pair: $sPair\n";
                   return 1;
               }
               elsif($sNumPairs > 2){
                   #print "Pair: $sPair\n";
                   return 1;
               }
           } 
            
           
        }
    }
    return 0;
}

sub triple {
    my $sWord = shift;

    my @aLetters = split(//,$sWord);
    my $sCount = scalar (@aLetters);

    for(my $I = 0; $I+2 < $sCount; $I++){

        my $sTriple = $aLetters[$I] . $aLetters[$I+1] . $aLetters[$I+2];

        return 1 if( $aLetters[$I] eq  $aLetters[$I+2]);
    }

    return 0;
}


my $sNiceCount = 0;

open (my $rInputFileHandle, '<', $sInput) or die "Couldn't open file $sInput, $!";

while (defined(my $sLine = <$rInputFileHandle>)){
    chomp $sLine;
    #my $sCheck1 = contains3Vowels($sLine);
    #my $sCheck2 = contains2Consecutive($sLine);
    #my $sCheck3 = notContain($sLine);
    #$sNiceCount++ if($sCheck1 && $sCheck2 && $sCheck3);

    my $sCheck1 = pair($sLine);
    my $sCheck2 = triple($sLine);

    $sNiceCount++ if($sCheck1 && $sCheck2);
}


print "We have: $sNiceCount Nice strings!\n";
