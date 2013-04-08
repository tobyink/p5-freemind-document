package FreeMind::Node;

use 5.010001;
use strict;
use warnings;

BEGIN {
	$FreeMind::Node::AUTHORITY = 'cpan:TOBYINK';
	$FreeMind::Node::VERSION   = '0.001';
}

use XML::LibXML::Augment
	-type  => 'Element',
	-names => ['node'],
;

require FreeMind::Document;
require Types::Standard;
require Type::Utils;

__PACKAGE__->FreeMind::Document::_has(
	BACKGROUND_COLOR  => { },
	COLOR             => { },
	FOLDED            => { isa => Types::Standard::Bool },
	ID                => { },
	LINK              => { },
	POSITION          => { isa => Type::Utils::enum(Position => [qw/left right/]) },
	STYLE             => { },
	TEXT              => { required => 1 },
	CREATED           => { isa => Types::Standard::Int },
	MODIFIED          => { isa => Types::Standard::Int },
	HGAP              => { isa => Types::Standard::Int },
	VGAP              => { isa => Types::Standard::Int },
	VSHIFT            => { isa => Types::Standard::Int },
	ENCRYPTED_CONTENT => { },
);

sub nodes
{
	shift->findnodes('./node')
}

sub toHash
{
	my $self = shift;
	return {
		$self->text => { map %{$_->toHash}, $self->nodes },
	}
}

sub toText
{
	require Text::Wrap;
	
	my $self = shift;
	my ($indent, $wrap) = @_;
	$indent ||= 0;
	local $Text::Wrap::columns = $wrap || 72;
	
	my $text = Text::Wrap::wrap(
		(q[ ] x ($indent * 4)).q[  * ],
		(q[ ] x (($indent+1) * 4)),
		$self->text,
	);
	
	join("\n", $text, $self->nodes->map(sub { $_->toText($indent+1, $wrap) }));
}

1;
