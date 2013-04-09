package FreeMind::Icon;

use 5.010001;
use strict;
use warnings;

BEGIN {
	$FreeMind::Icon::AUTHORITY = 'cpan:TOBYINK';
	$FreeMind::Icon::VERSION   = '0.000_01';
}

use XML::LibXML::Augment
	-type  => 'Element',
	-names => ['icon'],
;

require FreeMind::Document;

__PACKAGE__->FreeMind::Document::_has(
	BUILTIN => { required => 1 },
);

1;
