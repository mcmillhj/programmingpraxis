#!/usr/bin/env perl

use strict;
use warnings;

sub make_shell_archive {
   my ($filenames) = @_;

   open my $outfile_fh, '>', 'extract_files.sh'
      or die "Unable to open 'extract_files.sh' for writing: $!";
   
   foreach my $filename ( @$filenames ) {
      my $file_contents = do {
         open my $infile_fh, '<:encoding(UTF-8)', $filename 
            or die "Unable to open file '$filename' for reading: $!";
         <$infile_fh>;
      };

      print {$outfile_fh} "echo -n '$file_contents' > $filename\n";
   }
   close $outfile_fh;

   return;
}
make_shell_archive(\@ARGV);
