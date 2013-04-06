package FreeMind::Document;

use 5.010001;
use strict;
use warnings;

BEGIN {
	$FreeMind::Document::AUTHORITY = 'cpan:TOBYINK';
	$FreeMind::Document::VERSION   = '0.001';
}

use XML::LibXML::Augment
	-type  => 'Document',
	-names => ['map'],
;

require FreeMind::Map;
require FreeMind::Node;
require FreeMind::Icon;
require FreeMind::Edge;
require FreeMind::Font;
require FreeMind::Cloud;
require FreeMind::ArrowLink;
require FreeMind::Text;

use Carp;
use Types::Standard;

sub _has
{
	my $pkg = shift;
	while (@_)
	{
		my $name = shift;
		my $opts; $opts = shift if ref $_[0];
		next if $pkg->can($name);
		
		my $type     = $opts->{isa} || Types::Standard::Str;
		my $required = $opts->{required};
		
		my $sub = sub {
			my $node = shift;
			return $node->getAttribute($name) unless @_;
			
			my $v = $_[0];
			if (defined $v)
			{
				$type->assert_valid($v);
				$v = $v ? "true" : "false" if $type->name eq 'Bool';
				$node->setAttribute($name, $v);
			}
			else
			{
				croak "cannot set required attribute '$name' to undef" if $required;
				$node->removeAttribute($name);
			}
		};
		{ no strict "refs"; *{$pkg."::".lc $name} = $sub }
	}
}

sub load
{
	shift;
	"XML::LibXML::Augment"->rebless(
		"XML::LibXML"->load_xml(@_),
	);
}

sub root
{
	shift->findnodes('/map/node')->[0];
}

sub toHash
{
	shift->root->toHash;
}

sub toText
{
	shift->root->toText(@_);
}

1;

__END__

=pod

=encoding utf-8

=head1 NAME

FreeMind::Document - representation of a FreeMind-style mind map document

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=FreeMind-Document>.

=head1 SEE ALSO

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

