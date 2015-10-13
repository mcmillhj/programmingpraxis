#!/usr/bin/env perl

use strict;
use warnings;

# O(n) word frequency using ascii ordinal values
sub frequency {
   my ($s) = @_;

   my @ascii_table = (0) x 128;
   foreach my $char ( split //, $s ) {
      $ascii_table[ ord $char ]++;
   }

   return @ascii_table;
}

print join(',', frequency('hello')), "\n";
# 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
# 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
# 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
# 0,0,1,0,0,1,0,0,0,2,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
#    'e'   'h'     'l'   'o'

sub encrypt {
   my ($plaintext, $shift) = @_;

   my @letters = ('A' .. 'Z');

   return join '', map { ($_ ge 'A' && $_ le 'Z') ? $letters[(ord($_) + $shift - ord('A')) % @letters] : $_ } split //, $plaintext;
}

sub decrypt {
   my ($plaintext, $shift) = @_;

   return encrypt($plaintext, -$shift);
}

print decrypt(encrypt('ATTACK AT DAWN',5),5), "\n";
# ATTACK AT DAWN
