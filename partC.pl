#!/usr/bin/env perl
#
#Student Name: Jake Duran Zerafa
#Student No: s3679109
#
#Uses dummy.txt & dummy2.txt for testing purposes.
#
use strict;
use warnings;
=pod

=head1 DESCRIPTION

 Advanced Text File Comparer.
 Write a script that processes the content of files directly,
 without using any external commands.

 *Be case-insensitive.
 *Ignore punctuations/symbols.
 *Ignore URLs.
 *Ignore all HTML tags.
 *Use regex to achieve requirements.
 *Report the number of words that differ.
=cut

#Test whether files are readable.
sub FileRead {
		my @fileList = @ARGV;

		for (my $i = 0; $i <= $#fileList; $i++) {
				if (-r $fileList[$i]){
						print "File $fileList[$i] is readable \n";	
				}else {
						print "File $fileList[$i] is not readable \n";
						die;
				}	
		}
		print "\n";
}

#Compare 2 text files. 
sub FileCompare{
		my $file1 = $ARGV[0];
		my $file2 = $ARGV[1];
		my @newFile1;
		my @newFile2;
		my @words1;
		my @words2;
		open(my $fh1, $file1) or die;
		open(my $fh2, $file2) or die;
		
		while (<$fh1>) {
				s/<.+?>//g;
				s/\A\s+//g;
				s/([.])//g;
				s/htt(p|ps)\:\/\/\w+//g;	
				s/([!@#$%^&*()-=_+|;,<>?])//g;
				
				$_ = lc;
				
				@words1 = split(/ /, $_);			
				push @newFile1, @words1;
				
		}
	  foreach my $word(@newFile1){
				print "$word ";
		}
		
		print "\n";
		while (<$fh2>) {
				s/<.+?>//g;
				s/\A\s+//g;
				s/([.])//g;
				s/htt(p|ps)\:\/\/\w+//g;	
				s/([!@#$%^&*()-=_+|;,<>?])//g;
				
				$_ = lc;
				@words2 = split(/ /, $_);
				push @newFile2, @words2;
		}
		foreach my $word2(@newFile2){
				print "$word2 ";
		}
		print "\n";

		close $fh1;	
		close $fh2;
	  	
		print "File Comparison Report\n\n";

		print "File A: $file1\n";
		print "File B: $file2\n\n";
		
		#Output differences between both files ignoring punctuation,
		#case and also html/url tags.
		print "Differences \n";
		print "-----------------------------------\n";
		my $differences = 0;
		for(my $line = 0; $line <= $#newFile1; $line++){
				if($newFile1[$line] ne $newFile2[$line]){			
						my $word = $line +1;
						$differences++;
						print "Word $word: ";
						print $newFile1[$line] . "\n";
						print "Word $word: ";
						print $newFile2[$line] . "\n";
						
				} 			
		}
		print "\n";
		print "Total Differences: $differences \n";
}
FileRead();
FileCompare();

