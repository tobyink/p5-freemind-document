package FreeMind::Map;

use 5.010001;
use strict;
use warnings;

BEGIN {
	$FreeMind::Map::AUTHORITY = 'cpan:TOBYINK';
	$FreeMind::Map::VERSION   = '0.001';
}

use XML::LibXML::Augment
	-type  => 'Element',
	-names => ['map'],
;

require FreeMind::Document;

__PACKAGE__->FreeMind::Document::_has(
	version => { required => 1 },
);

1;
