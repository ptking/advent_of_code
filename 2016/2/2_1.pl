#! perl

use strict;
use warnings;

use Switch;

#Y
# 1 2 3 
# 4 5 6
# 7 8 9
# # # # X
sub initKeyPad1 {
    my ($raPad) = @_;

    $$raPad[0][0] = 7;
    $$raPad[1][0] = 8;
    $$raPad[2][0] = 9;
    $$raPad[0][1] = 4;
    $$raPad[1][1] = 5;
    $$raPad[2][1] = 6;
    $$raPad[0][2] = 1;
    $$raPad[1][2] = 2;
    $$raPad[2][2] = 3;
}

# Y
# 
# 4|    1
# 3|  2 3 4
# 2|5 6 7 8 9
# 1|  A B C
# 0|    D
#  ----------
#   0 1 2 3 4
#  

sub initKeyPad2 {
    my ($raPad) = @_;

    $$raPad[0][0] = undef;
    $$raPad[1][0] = undef;
    $$raPad[2][0] = 'D';
    $$raPad[3][0] = undef;
    $$raPad[4][0] = undef;
    $$raPad[0][1] = undef;
    $$raPad[1][1] = 'A';
    $$raPad[2][1] = 'B';
    $$raPad[3][1] = 'C';
    $$raPad[4][1] = undef;
    $$raPad[0][2] = 5;
    $$raPad[1][2] = 6;
    $$raPad[2][2] = 7;
    $$raPad[3][2] = 8;
    $$raPad[4][2] = 9;
    $$raPad[0][3] = undef;
    $$raPad[1][3] = 2;
    $$raPad[2][3] = 3;
    $$raPad[3][3] = 4;
    $$raPad[4][3] = undef;
    $$raPad[0][4] = undef;
    $$raPad[1][4] = undef;
    $$raPad[2][4] = 1;
    $$raPad[3][4] = undef;
    $$raPad[4][4] = undef;
}


die "usage: perl $0 <input> (part [1|2])" if (scalar @ARGV != 1 && scalar @ARGV != 2);

my ($sInput, $sPart) = @ARGV;

$sPart = 2 if(! defined $sPart);

open (my $rInputHandle ,'<', $sInput) or die "couldn't open file for read, $!";

my @aKeyPad;
my ($sX, $sY);

if($sPart == 2){
    initKeyPad2(\@aKeyPad);
    $sX = 0;
    $sY = 2;
}
else{
    initKeyPad1(\@aKeyPad);
    # start at key 5
    $sX = 1;
    $sY = 1;

}

# all rows/columns should be the same length
my $sYSize = scalar @{$aKeyPad[0]};
my $sXSize = scalar @aKeyPad;

print "Size: $sYSize X $sXSize\n";
print "Starting at: $aKeyPad[$sX][$sY]\n";


while (defined ( my $sLine = <$rInputHandle>)){
    chomp $sLine;
    $sLine =~ s/\s+//g;
    my @aInstructions = split (//, $sLine);
    foreach my $sCommand (@aInstructions){
        switch($sCommand){
            case "U" {
                $sY++ if( $sY + 1 < $sYSize && defined $aKeyPad[$sX][$sY + 1]);
            }
            case "R" {
                $sX++ if( $sX + 1 < $sXSize && defined $aKeyPad[$sX + 1][$sY]);
            }
            case "D" {
                $sY-- if($sY > 0 && defined $aKeyPad[$sX][$sY -1]);

            }
            case "L" {
                $sX-- if($sX > 0 && defined $aKeyPad[$sX -1][$sY]);
            }
            else{
                die "shouldn't get here! $sCommand\n";
            }
        }
    }
    print $aKeyPad[$sX][$sY];
}

close($rInputHandle);


