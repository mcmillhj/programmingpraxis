#!/usr/bin/env perl

use strict;
use warnings;

use feature qw(say);

my %fibs = ( 0 => 0, 1 => 1 );
sub fib {
   my $n = shift; 

   $fibs{$n} = fib($n - 1) + fib($n - 2)
      unless exists $fibs{$n};
   
   return $fibs{$n};
}

sub min {
   my ($a, $b) = @_;

   return $a < $b ? $a : $b;
}

sub fib_search {
   my ($x, @xs) = @_;

   my $k = 0;
   my $fib = 0;
   while ( $k < scalar @xs ) {
      $k = fib($fib++);
   }

   my $low = 0;
   my $high = $#xs;

   while ( $low <= $high ) {
      my $mid = min($low + fib($k - 1), $high);
      if ( $x < $xs[$mid] ) {
         $high = $mid;
         $k -= 2;
      }
      elsif( $xs[$mid] < $x ) {
         $low = $mid;
         $k -= 1;
      }
      else {
         return $mid;
      }
   }

   return -1;
}

my @primes = qw(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47);
say fib_search( 23, @primes );
