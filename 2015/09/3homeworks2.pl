#!/usr/bin/env perl

use strict;
use warnings;

use Data::Dumper;

sub unique {
   my @array = @_;

   my %uniq_elements = map {; $_ => 1 } @array;
   return keys %uniq_elements;
}
print Dumper [unique(qw(3 2 4 2 7 3 5 1 3))];

sub is_perfectcube {
   my ($n) = @_;

   print '-' x 80, "\n";
   print "n**(1/3)      = " . ($n**(1/3)) . "\n";
   print "(n**(1/3))**3 = " . (($n**(1/3))**3) . "\n";
   return (($n**(1/3))**3) == $n; 
}

foreach my $n ( 1 .. 200 ) {
   print "$n is a perfect-cube? " . is_perfectcube($n) . "\n";
}
