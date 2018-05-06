#!/usr/bin/env perl
#
#Student Name: Jake Duran Zerafa
#Student No: s3679109
#
#Uses file1.txt, file2.txt & file3.txt
#for testing purposes.
#
use strict;
use warnings;

=pod

=head1 DESCRIPTION

 Platform Independant Text File Comparer.
 Write a script that processes the content of files directly,
 without using any external commands.

 Provide metadata about the file pairs including how many lines,
 words and characters are in each of them.

 The calculated difference of these metadata between two files.

 Details of specific lines which differ, 
 including line numbers and the actual content of the lines.

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

#Compare 2 text files & display lines, words & bytes.
sub FileCompare{
		my $file1 = $ARGV[0];
		my $file2 = $ARGV[1];

		open(my $fh1, $file1) or die;
		open(my $fh2, $file2) or die;

		my ($lines1, $lines2) = (0, 0);
		my ($words1, $words2) = (0, 0);
		my ($chars1, $chars2) = (0, 0);

		while (<$fh1>) {
				$lines1++;
				$chars1 += length();
				$words1 += scalar(split(/\s+/, $_));	
		}

		while (<$fh2>) {
				$lines2++;
				$chars2 += length();
				$words2 += scalar(split(/\s+/, $_));	
		}

		close $fh1;
		close $fh2;

		my $lineDiff = $lines1 - $lines2;
		my $wordDiff = $words1 - $words2;
		my $byteDiff = $chars1 - $chars2;

		print "File Comparison Report\n\n";

		print "File A: $file1\n";
		print "File B: $file2\n\n";

		print "File | Lines | Words | Bytes\n";
		print "-----------------------------------\n";
		print "A    |   $lines1   |  $words1  |  $chars1 \n";
		print "B    |   $lines2   |  $words2  |  $chars2 \n";
		print "A-B  |   $lineDiff    |   $wordDiff   |  $byteDiff \n\n";
}

#Sub routine to calculate the difference between 2 text files.
sub Difference {
		my $file1 = $ARGV[0];
		my $file2 = $ARGV[1];

		open(my $fh1, $file1) or die;
		open(my $fh2, $file2) or die;
		my $lineCount = 0;
		while (my $line1 = <$fh1> and my $line2 = <$fh2>) {
				$lineCount++;
				if($line1 ne $line2){	
						print "Line: $lineCount \n";
						print $line1;
						print $line2 . "\n";
				}
		}

		close $fh1;
		close $fh2;

}

FileRead();
FileCompare();
Difference();
