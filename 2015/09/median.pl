#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/say/;

sub median {
   my @array = @_;
   my @freqs = (0) x 256;

   foreach my $elem ( @array ) {
      $freqs[$elem]++;
   }

   my ($low, $high) = (0, 255);
   my ($low_count, $high_count) = (0, 0);
   my $len = @array;
   while ( 1 ) {
      if ( $low_count < ($len / 2) ) {
         $low_count += $freqs[$low++];
      }
      elsif ( $high_count < ($len / 2) ) {
         $high_count += $freqs[$high--];
      }
      else {
         last;
      }
   }
   
   return ($low + $high) / 2;
}

say median(qw(2 4 5 7 3 6 1)); # 4
say median(qw(5 2 1 6 3 4));   # 3.5
