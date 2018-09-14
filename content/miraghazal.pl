#!usr/bin/env perl

use strict;
use warnings;
use 5.026;

use utf8;
binmode STDOUT, ':utf8';

use YAML::Tiny;
use Path::Tiny;

#my $file = path("./ghazal.yaml")->slurp_utf8;

my $yaml = YAML::Tiny->read( 'ghazal.yaml' );

my $ghazal = $yaml->[0]->{ghazal};

foreach my $num ( keys %$ghazal ) {
    my $utid = sprintf"1000-%03d", $num;
    my $index = sprintf"%03d", $num;
    my $file = path("ghazal/$index.md");
    $file->touchpath;
    my $title = "غزل شماره $num";
    $title =~ tr/0123456789/۰۱۲۳۴۵۶۷۸۹/;
    my $first_mesra = @{ $ghazal->{$num} }[0];
    
    my $last_char;
    if ($first_mesra =~ /(\w)\W*$/) {
    $last_char = $1;
    }
    
    #my $last_char = substr $first_mesra, -1;
    #if ($last_char !~ /[ا-ی]/) {
    #	$last_char = substr $first_mesra, -2;
    #}
#    $first_mesra =~ /(\w+)\s*$/;
#    my $last_word = $1;

    open my $fh, '>:encoding(UTF-8)', $file or die $!;
    print $fh "---\n";
    print $fh "utid: $utid\n";
    print $fh "title: $title\n";
    print $fh "_index: $index\n";
    print $fh "list: غزلیات\n";
    print $fh "indexes: $last_char\n";
    print $fh "mesra:\n";

    foreach my $mesra ( @{ $ghazal->{$num} } ) {
    	$mesra =~ s/^\s*|\s*$//;
        print $fh "  - $mesra\n";
    }

    print $fh "---\n";
    close $fh;
}

#use Data::Dumper;
#print Dumper $ghazl;




