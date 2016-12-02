#! perl

use strict;
use warnings;

use Data::Dumper;

my $sInput = shift;
my $sLimit = shift;

my $sCount = 0;
my $sCurrentOutput = $sInput;
while($sCount < $sLimit){
  $sCount++;

  $sInput = $sCurrentOutput;
  $sCurrentOutput = '';

#  print "Count: $sCount\n";
#  print "Input: $sInput\n";

  my @aChars = split('', $sInput);
#  print Dumper(\@aChars);
  
  my $sCurrent = '';
  my $sNext = '';

  my $sCharCount = 0;
  for (my $I = 0; $I < scalar(@aChars) ; $I++){   

      $sCharCount++;
      
      $sCurrent = $aChars[$I];
      if( $I+1 < scalar(@aChars)){
          $sNext = $aChars[$I+1] ;
      }
      else{
          $sNext = '';
      }

#      print "Current: $sCurrent\n";
#      print "Next: $sNext\n";
#      print "CharCount: $sCharCount\n";

      if($sCurrent eq $sNext){
          next;
      }
      
      $sCurrentOutput .= "$sCharCount" . "$sCurrent";

#      print "Current Output inner: $sCurrentOutput \n";
      $sCharCount = 0;
  }
}

print "$sCurrentOutput";

