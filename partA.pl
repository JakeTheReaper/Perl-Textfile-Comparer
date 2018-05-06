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

 Text File Comparer.
 Write a script which compares all combinations
 of plain text file specified via command-line
 arguments by using external Unix/Linux commands.

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

#Compare 2 text files using Unix/Linux commands wc & diff.
sub FileCompare {
		
		my @value = Permute();
		my $file1 = $value[0];
		my $file2 = $value[1];
		
		my $difference = `diff $file1 $file2`;

		my $wordCount1 = `wc < $file1`;
		my @wcArray1 = split(" ", $wordCount1); 
		my $wordCount2 = `wc < $file2`;
		my @wcArray2 = split(" ", $wordCount2); 
		my $lineDiff = $wcArray1[0] - $wcArray2[0];
		my $wordDiff = $wcArray1[1] - $wcArray2[1];
		my $byteDiff = $wcArray1[2] - $wcArray2[2];

		print "File Comparison Report\n\n";

		print "File A: $file1\n";
		print "File B: $file2\n\n";

		print "File | Lines | Words | Bytes\n";
		print "-----------------------------------\n";
		print "A    |   $wcArray1[0]   |  $wcArray1[1]  |  $wcArray1[2] \n";
		print "B    |   $wcArray2[0]   |  $wcArray2[1]  |  $wcArray2[2] \n";
		print "A-B  |   $lineDiff    |   $wordDiff   |   $byteDiff \n\n";

		print $difference;
}

#Create hash containing permutations and return values.
sub Permute {
		my %hash = (1 => ['file1.txt', 'file2.txt'], 2 => ['file1.txt', 'file3.txt'], 3 => ['file2.txt', 'file3.txt']);
		my $value;
		foreach my $key(keys %hash){
				$value = $hash{$key};
				return @$value;
		}
		
}
FileRead();
FileCompare();
