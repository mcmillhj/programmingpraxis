#!/usr/bin/perl

use strict; 
use warnings; 

use feature qw(say); 

use Algorithm::Permute; 
use Math::Prime::Util qw(factor);

my $p_iterator = Algorithm::Permute->new( [1..9] );
my $maxfactor  = 2**32; 
my $pandigital = undef; 
PERM:
while ( my $perm = join('', $p_iterator->next) ) {
   my $local_max = (factor($perm))[-1]; 
   next PERM 
      if $local_max >= $maxfactor;    

   $pandigital = $perm; 
   $maxfactor  = $local_max; 
}

say "$pandigital, $maxfactor";
