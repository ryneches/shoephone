#!/usr/bin/perl -w
use strict;
use warnings;
use Math::Trig;
use Math::Trig 'great_circle_distance';
# This script will reads GPS coordinates in the form of latitude and longitude
#  numbers and calculate distances between the points
#
# It will also calculate community similarity measures between samples
#
# The output will be a set of distances and similarity measures for all samples.
# The output would be processed in R to generate a plot colored by Site

# read in the metadata for the samples
# So we can figure out which Site distances to use
my $var = shift;
chomp($var);
my $metadata_file="ProjectMcellphoneshoes_MadeittoPhyloseq.tsv";
open(IN,$metadata_file);
my %metadata=();
<IN>;
while(<IN>){
    chomp($_);
    my @line=split(/\t/,$_);
    my $sample=$line[0];
    my $site = $line[4];

#    next if exists $distance_pcoa{$sample};
    next unless $sample =~ /CPR/;
    next if $site eq 'Unknown';
    next if $site eq 'KidScoop';
    next if $site eq 'Redskins';
    next if $site eq 'MiamiDolphins';
    next if $site eq '';
    next if $site eq 'Tufts';
    $metadata{$sample}=$site;
}

# read the GPS coordinates
# Expect headers:
# Site<tab>latitude<tab>longitude<\n>
my $gps_file="gps_coords.txt";

my %lats=();
my %longs=();


open(IN,$gps_file);
<IN>;
while(<IN>){
    chomp($_);
    if($_ =~ m/Girl Scouts\s+(\S+)\s+(\S+)$/){
	my $site = 'Girl Scouts';
	my $lat = $1;
	my $long = $2;
	$lats{$site}=$lat;
	$longs{$site}=$long;
    }else{
	$_=~ m/^(\S+)\s+(\S+)\s+(\S+)$/;
	my $site = $1;
	my $lat = $2;
	my $long = $3;
	$lats{$site}=$lat;
	$longs{$site}=$long;
    }
}
close(IN);

# compare all sites;
my %geo_dist=(); #geographic distances
my $earth_radius_km = "6371";
foreach my $sA (sort keys %lats){

    foreach my $sB(sort keys %longs){
	#print STDERR "$sA\t$sB\n";
	if($sA eq $sB){
	    $geo_dist{$sA}{$sB}=0;
	}else{
	    # compute the distance
	    my $a_lat = deg2rad($lats{$sA});
	    my $a_long = deg2rad($longs{$sA});
	    my $b_lat = deg2rad($lats{$sB});
	    my $b_long = deg2rad($longs{$sB});

	    # $distance = great_circle_distance($lon0, pi/2 - $lat0,
	    #                                   $lon1, pi/2 - $lat1, $rho);
	
	    
	    #	    print STDERR "Deg: 55.75\t".deg2rad(55.75)."\n";
	    my $a = sin(($b_lat-$a_lat)/2)**2 + cos($a_lat) * cos($b_lat) * sin(($b_long-$a_long)/2)**2 ;
#	    my $a = sin(($b_long-$a_long)/2)*sin(($b_long-$a_long)/2) + cos($a_long) * cos($b_long) * sin(($b_lat-$a_lat)/2)*sin(($b_lat-$a_lat)/2) ;
	    
	    # a = pow(sin((By-Ay)/2),2) + cos(Ay) * cos(By) * pow(sin((Bx-Ax)/2),2)

	    #c = 2*atan2(sqrt(a),sqrt(1-a))

	    my $c = 2 * atan2(sqrt($a),sqrt(1-$a));

	    my $distance_km = $c * $earth_radius_km;
	    #my $distance_fun_km=great_circle_distance($longs{$sA},pi/2-$lats{$sA}, $longs{$sB}, pi/2-$lats{$sB}, $earth_radius_km);
	    my $distance_fun_km=great_circle_distance($longs{$sA},pi/2-$lats{$sA},$longs{$sB}, pi/2-$lats{$sB}, $earth_radius_km); 
	    #print STDERR "Raw calc: $distance_km\tfunction: $distance_fun_km\nLAT\t LONG\nA:\t$a_lat\t$a_long\nB:\t$b_lat\t$b_long\n";
#	    print STDERR "GEODIST: $sA\n";
	    $geo_dist{$sA}{$sB}=$distance_km;
	    $geo_dist{$sB}{$sA}=$distance_km;	    
	}
    }
}
#exit;
open(OUT,">figure_dir_finaltest/$var.geodist.bysite.values.txt");
print OUT "Sample1\tSample2\tBray.Curtis\tGeographical Distance\tSampleType\n";
# print the geographic coordinates in the same matrix style
# as the Bray-Curtis distances printed by R
#open(IN,"ps8.redo.shoe.dist.txt");
open(IN,"figure_dir_finaltest/$var.shoe.event.dist.txt") or die "Could not open $var.shoe.event.dist.txt\n\n";

my $shoeheaders=<IN>;
$shoeheaders =~ s/"//g;
my @shoeheaders=split(/\t/,$shoeheaders);
my $shoenum = scalar(@shoeheaders);
while(<IN>){
    chomp($_);
    $_=~ s/"//g;
    my @line=split(/\t/,$_);
    for(my $i =1 ; $i < $shoenum; $i++){
	#	$shoedist{$line[0]}{$shoeheaders[$i]}=$line[$i] unless defined  $shoedist{$line[0]}{$shoeheaders[$i]};
#	print STDERR "line0: $line[0]\n$shoeheaders[$i]\n";

#	next unless exists $metadata{$shoeheaders[$i]};
#	next unless exists $metadata{$line[0]};
#	next unless exists $geo_dist{$metadata{$line[0]}};
	#	next unless exists $geo_dist{$metadata{$shoeheaders[$i]}};`
	next if $line[0] =~ /Unknown/;
	next if $line[0] =~ /KidScoop/;
	next if $shoeheaders[$i] =~ /Unknown/;
	next if $shoeheaders[$i] =~ /KidScoop/;
	next if $line[0] =~ /Redskins/;
	next if $line[0] =~ /MiamiDolphins/;
	next if $shoeheaders[$i] =~ /Redskins/;
	next if $shoeheaders[$i] =~ /MiamiDolphins/;
	next unless exists $geo_dist{$shoeheaders[$i]};
	next unless exists $geo_dist{$line[0]};
	next if $line[0] =~ /Tufts/;
	next if $shoeheaders[$i] =~ /Tufts/;
	#print "TESTING:$line[0]\t$shoeheaders[$i]\t";
	print OUT "$line[0]\t$shoeheaders[$i]\t";
	print OUT "$line[$i]\t";

#	if(exists $metadata{$line[0]}){
	print OUT "$geo_dist{$line[0]}{$shoeheaders[$i]}";
	    
#	}else{
#	    print STDERR "can't find $line[0]\n";
#	}
#	print OUT "$geo_dist{$metadata{$line[0]}}{$metadata{$shoeheaders[$i]}}";
	print OUT "\tshoe\n";
    }
}
#exit;
close(IN);
#open(IN,"ps8.redo.phone.dist.txt");
open(IN,"figure_dir_finaltest/$var.phone.event.dist.txt");
my $phoneheaders=<IN>;
$phoneheaders=~ s/"//g;
my @phoneheaders=split(/\t/,$phoneheaders);
my $phonenum = scalar(@phoneheaders);
while(<IN>){
    chomp($_);
    $_ =~ s/"//g;
    
    my @line=split(/\t/,$_);
    for(my $i =1 ; $i < $phonenum; $i++){
	#$phonedist{$line[0]}{$phoneheaders[$i]}=$line[$i] unless defined  $phonedist{$line[0]}{$phoneheaders[$i]};
#	next unless exists $metadata{$phoneheaders[$i]};
#	next unless exists $metadata{$line[0]};
#	next unless exists $geo_dist{$metadata{$line[0]}};
	#	next unless exists $geo_dist{$metadata{$phoneheaders[$i]}};
	next if $line[0] =~ /Unknown/;
	next if $line[0] =~ /KidScoop/;
	next if $phoneheaders[$i] =~ /Unknown/;
	next if $phoneheaders[$i] =~ /KidScoop/;
	print STDERR "$line[0]\t$phoneheaders[$i]\t$line[$i]\n";
	next unless exists $geo_dist{$phoneheaders[$i]};
	next unless exists $geo_dist{$line[0]};
	
	print OUT "$line[0]\t$phoneheaders[$i]\t$line[$i]\t";
#	if(exists $metadata{$line[0]}){
	    print OUT "$geo_dist{$line[0]}{$phoneheaders[$i]}";
#	}else{
#	    print STDERR "can't find $line[0]\n";
#	}
	print OUT "\tphone\n";
    }
}
close(OUT);
#exit;

# All samples
#%done=();
# X Y values for each interaction
#open(OUT1,">ps8.redo.distances.shoe.txt");
#open(OUT2,">ps8.redo.distances.phone.txt");
# full matrix for all samples
#open(OUT3,">ps8.redo.geodist.site.matrix.shoe.txt");
open(OUT4,">figure_dir_finaltest/$var.geodist.site.matrix.txt");
#open(OUT5,">ps8.redo.pcoadist.matrix.shoe.txt");
#open(OUT6,">ps8.redo.pcoadist.matrix.phone.txt");


#print OUT1 "SampleComp\tgeo_dist\tpcoa_dist\n";
#print OUT2 "SampleComp\tgeo_dist\tpcoa_dist\n";

my @samples = sort keys %geo_dist;
for(my $i=0;$i<scalar(@samples);$i++){
    next if $samples[$i] eq 'Unknown';
    next if $samples[$i] eq 'KidScoop';
    next if $samples[$i] eq 'Redskins';
    next if $samples[$i] eq 'MiamiDolphins';
    next if $samples[$i] eq 'Tufts';
#    print OUT3 "\t$samples[$i]" if $samples[$i] =~ m/CPR_SH/;
    print OUT4 "\t$samples[$i]" ;#if $samples[$i] =~ m/CPR_CP/;
#    print OUT5 "\t$samples[$i]" if $samples[$i] =~ m/CPR_SH/;
#    print OUT6 "\t$samples[$i]" if $samples[$i] =~ m/CPR_CP/;
}
#print OUT3 "\n" ;
print OUT4 "\n" ;
#print OUT5 "\n" ;
#print OUT6 "\n" ;

for(my $j=0;$j<scalar(@samples);$j++){
    next unless exists $samples[$j];
    next if $samples[$j] eq 'Unknown';
    next if $samples[$j] eq 'KidScoop';
    next if $samples[$j] eq 'Redskins';
    next if $samples[$j] eq 'MiamiDolphins';
    next if $samples[$j] eq 'Tufts';
#    print OUT3 "$samples[$j]" if $samples[$j] =~ m/CPR_SH/;
    print OUT4 "$samples[$j]" ;#if $samples[$j] =~ m/CPR_CP/;
#    print OUT5 "$samples[$j]" if $samples[$j] =~ m/CPR_SH/;
#    print OUT6 "$samples[$j]" if $samples[$j] =~ m/CPR_CP/;
    for(my $i=0; $i<scalar(@samples);$i++){
	next if $samples[$i] eq 'Unknown';
	next if $samples[$i] eq 'KidScoop';
	next if $samples[$i] eq 'Tufts';
	next if $samples[$i] eq 'Redskins';
	next if $samples[$i] eq 'MiamiDolphins';
	#	next unless exists $metadata{$samples[$i]};
	print OUT4 "\t$geo_dist{$samples[$j]}{$samples[$i]}";
#	print OUT3 "\t$geo_dist{$metadata{$samples[$j]}}{$metadata{$samples[$i]}}" if $samples[$j] =~ /CPR_SH/ && $samples[$i] =~ /CPR_SH/;
#	print OUT6 "\t$distance_pcoa{$samples[$j]}{$samples[$i]}" if $samples[$j] =~ /CPR_CP/ && $samples[$i] =~ /CPR_CP/;
#	print OUT5 "\t$distance_pcoa{$samples[$j]}{$samples[$i]}" if $samples[$j] =~ /CPR_SH/ && $samples[$i] =~ /CPR_SH/;
    }
    print OUT4 "\n";
#    print OUT3 "\n";
#    print OUT6 "\n";
#    print OUT5 "\n";
    
}
close(OUT4);

exit;
