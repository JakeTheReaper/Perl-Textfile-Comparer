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

 Text File Similarity Measurement.
 Measure the overall similarity of two text files based on word
 content and report the similarity in percentage.

 *Be case-insensitive.
 *Ignore punctuations/symbols.
 *Ignore URLs.
 *Ignore all HTML tags.
 *Use regex to achieve requirements.
 *Create a similarity measurement algorithm.
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
				s/\n//g;

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
				s/\n//g;
	
				$_ = lc;
		
				@words2 = split(/ /, $_);
				push @newFile2, @words2;		
		}
		close $fh1;	
		close $fh2;

		print "File Similarity Report\n\n";

		print "File A: $file1\n";
		print "File B: $file2\n\n";

		#Create similarity report algorithm and output results. 
		print "Similarity Percentage \n";
		print "-----------------------------------\n";
		
		#Assign file arrays to a hash
		#iterate through the hash and count the number of recurring words.
		my $differences = 0;	
		my %hash;
		$hash{$_}++ for (@newFile1, @newFile2);
		my $wordCount =  0;
		foreach my $key (keys %hash){
			  $wordCount += $hash{$key};
				
				print "$key => $hash{$key}\n";
				
				if ($hash{$key} == 1){
						$differences++;
				}
		}


  	print "Combined Overall Word Count   | $wordCount\n";
		print "Total Overall Different Words | $differences\n";
		my $similarity = ($wordCount-$differences);
		print "Total Overall Similar Words   | $similarity \n\n";
		my $percentage = ($similarity/$wordCount*100);
		print "Similarity Percentage Between $file1 & $file2 is ";
		printf ("%.2f%%", $percentage);
		print "\n\n";
}
FileRead();
FileCompare();

