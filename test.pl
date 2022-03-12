#!/usr/bin/perl
use strict;
use warnings;

use lib '/opt/devel/perl/lib';
use Helpers;
use Data::Dumper;

my ($cmd,%out);

$cmd = "ls /tmp/peter";
%out = _call($cmd,"PERL");
print "OUT\n";
print Dumper \%out;

$cmd = "ls -latr /tmp/paul";
%out = _call($cmd,"PERL");
print "OUT\n";
print Dumper \%out;

$cmd = "perl ./blub";
%out = _call($cmd,"PERL");
print "OUT\n";
print Dumper \%out;
