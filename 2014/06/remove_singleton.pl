#!/usr/bin/perl

use strict;
use warnings; 

use feature qw(say);

sub remove_singleton {
   my ($s, $c) = @_;

   $s =~ s/(?<!$c)($c)(?!$c)//g;
   return $s; 
}

say remove_singleton('XabXXcdX','X'); 
