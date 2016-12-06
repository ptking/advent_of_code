#! perl

use strict;
use warnings;

use Data::Dumper;

die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";
my %hHash =();

my $sWidth = 0;
while(defined(my $sLine = <$rInputHandle>)){
    chomp $sLine;
    my @aChars = split //,$sLine;

    $sWidth = scalar @aChars if($sWidth == 0);
    for ( my $sI=0; $sI < $sWidth; $sI++){
        my $sCount = 0;
        my $sChar = $aChars[$sI];
        $sCount = $hHash{$sI}{$sChar} if(exists $hHash{$sI}{$sChar});
        $hHash{$sI}{$sChar} = $sCount +1;
    }
}

for (my $sI=0; $sI<$sWidth;$sI++){
    foreach my $sKey (sort { $hHash{$sI}{$a} <=> $hHash{$sI}{$b} } keys %{$hHash{$sI}}){
        print $sKey;
        last;
    }
}
