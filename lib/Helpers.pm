package Helpers;

#Export functions
	require Exporter;
	@ISA = qw(Exporter);
	@EXPORT = qw(_call);

use Data::Dumper;

sub _call {
	
	my ($cmd,$type) = @_;
	my ($stdout,$stderr,$stdrc);
	my %ret;

	$stdout = "/tmp/_call.$$.tmpout";
	$stderr = "/tmp/_call.$$.tmperr";
	$stdrc = "/tmp/_call.$$.tmprc";

	print "$stdout\n" if($ENV{DEBUG});
	print "$stderr\n" if($ENV{DEBUG});
	print "$stdrc\n" if($ENV{DEBUG});

	## define the command including out,err,rc logfile
	$cmd = "$cmd > $stdout 2> $stderr; echo ReTcOdE=\$? > $stdrc";
	system($cmd);

	## read the output
	%ret = read_call_std($stdout,$stderr,$stdrc);

	## return everything
	return %ret;
}

sub read_file {
	my $file = shift;
	my @out;

	open(FH, '<', $file) or die $!;
	while (<FH>) {
		push @out,$_;
	}

	## always chomp
	chomp(@out);

	return @out;
}

sub read_call_std {
	my ($stdout,$stderr,$stdrc) = @_;
	my %ret;

	my @out = read_file($stdout);
	my @err = read_file($stderr);
	my @rc = read_file($stdrc);
	
	$rc[0] =~ s/ReTcOdE=//;

	$ret{out} = \@out;
	$ret{err} = \@err;
	$ret{rc} = \@rc;

	return %ret;
}

1;
