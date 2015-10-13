#!/usr/bin/env perl

use strict;
use warnings;

my $linked_list = { 
   val => 1, 
   next => { 
      val => 2, 
      next => { 
         val => 3, 
         next => { 
            val => 4, 
            next => { 
               val => 5, 
               next => undef 
            } 
         } 
      } 
   } 
};

sub next_to_last {
   my ($ll) = @_;

   my ($curr, $prev) = ($ll, undef);
   while ( my $next = $curr->{next} ) {
      if ( $curr->{next} ) {
         $prev = $curr;
         $curr = $next;
         next;
      }

      last;
   }

   $prev;
}

use Data::Dumper;
print Dumper next_to_last($linked_list);
