#!/usr/bin/perl

use strict; 
use warnings FATAL => 'all'; 

use Data::Dumper; 
use Memoize qw(memoize);

my %pieces_moves = (
   knight => [
      [4, 6], 
      [6, 8], 
      [7, 9], 
      [4, 8], 
      [3, 0, 9], 
      [],
      [1, 7, 0], 
      [2, 6], 
      [1, 3], 
      [2, 4]
   ],
   pawn => [
      [8], 
      [2, 4], 
      [1, 3, 5], 
      [2, 6], 
      [1, 5, 7], 
      [2, 4, 6, 8], 
      [3, 5, 9], 
      [4, 8], 
      [0, 5, 7, 9], 
      [6, 8]
   ],
   queen => [
      [2, 5, 7, 8, 9], 
      [2, 3, 4, 5, 7], 
      [0, 1, 3, 4, 5, 6, 8], 
      [1, 2, 5, 6, 9], 
      [1, 2, 5, 6, 7, 8], 
      [0, 1, 2, 3, 4, 6, 7, 8, 9], 
      [2, 3, 4, 5, 8, 9], 
      [0, 1, 4, 5, 8, 9], 
      [0, 2, 4, 5, 6, 7, 9], 
      [0, 3, 5, 6, 7, 8]
   ],
);

sub dp_count_ways { 
   my ($piece, $n, $position) = @_;

   # moves from the current position
   my @moves = @{$pieces_moves{$piece}};

   # create dp table, size of 10 x $n
   my $table = []; 
   push @$table, 
      [(0) x @moves] foreach 1..$n;

   # base case, there is only a single number possible when $n == 1
   foreach my $i ( 0 .. $#moves ) {
      $table->[1][$i] = 1;
   } 

   # fill in solution 1 cell at a time 
   foreach my $i ( 2 .. $n ) {
      foreach my $j ( 0 .. $#moves ) {
         foreach my $move ( @{$moves[$j]}  ) {
            $table->[$i][$j] += $table->[$i - 1][$move];
         }
      }
   }

   # number of $n digit numbers starting from $position
   return $table->[$n][$position];
}

memoize 'count_ways';
sub count_ways {
   my ($piece, $n, $pos) = @_;
   $pos //= 0;

   return 1 
      if $n == 1;
   
   my $sum = 0; 
   foreach my $move ( @{$pieces_moves{$piece}->[$pos]} ) {
      $sum += count_ways($piece, $n - 1, $move);
   }

   return $sum; 
}

foreach my $piece ( qw(knight queen pawn) ) {
   print "$piece\n";
   print "----------\n";
   print 'Memoized solution: ' . count_ways($piece, 10, 1)    . "\n";
   print 'DP solution      : ' . dp_count_ways($piece, 10, 1) . "\n";
   print "\n";
}
