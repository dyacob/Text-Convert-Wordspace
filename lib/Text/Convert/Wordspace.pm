package Convert::Number::Digits;

use utf8;
binmode(STDERR, ":utf8");
binmode(STDOUT, ":utf8");

BEGIN
{
use strict;
use warnings;
use vars qw( $VERSION );

$VERSION = "0.01";

local $spacesBetweenLetters = qr/([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E])( +)([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E])/;
local $spacesBetweenLetterAndNumberOrOpenPunct = qr/([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E])( +)([{\[(\uAB\u2039\u201C\u2018\u1369-\u137C])/;
local $spacesBetweenNumberOrClosePunctAndLetter = qr/([\u2019\u201D\u203A\uBB)\]}\u1369-\u137C])( +)([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E])/;
local $endOfLine = qr/([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E\u2019\u201D\u203A\uBB\u29\u5D\u7D])\n/;

local $fromSpaceToWordspace = 1;
}

# Replace one or more space symbols with Ethiopic Wordspace
#
# Letters: [\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E]
# Nonpunctuation symbols: [\u1200-\u135A\u1369-\u138F\u2D80-\u2DDE\uAB01-\uAB2E]
# Punctuatioon symbols: [\u135B-\u1368]
# Numbers: [\u1369-\u137C]
# Numbers And Punctuation: [\u1358-\u137C]
# Tonal Marks: [\u1390-\u1399]  -these absolutely should not be applicable
# Opening Punctuation: [\u7B\u5B\u28\uAB\u2039\u201C\u2018]  /  {[(«‹“‘
# Closing Punctuation: [\u2019\u201D\u203A\uBB\u29\u5D\u7D]  /  ’”›»)]}



sub setSubstitutionDirection
{
	my($value) = shift;
	$fromSpaceToWordspace = ( $value == "fromAscii" )
		? 1
		: 0
		;
}

sub spaceToWordspace
{
	$_ = shift;
	s/$spacesBetweenLetters/$1፡$3/g
	s/$spacesBetweenLetterAndNumberOrOpenPunct/$1፡$3/g;
	s/$spacesBetweenNumberOrClosePunctAndLetter/$1፡$3/g;
	s/$endOfLine/$1፡\n/g;
	s/([\u1200-\u135A\u1380-\u138F\u2D80-\u2DDE\uAB01-\uAB2E])$/'$1፡/;

	$_;
}

sub wordspaceToSpace
{
	$_ = shift;
	s/፡፡/።/g;  # sneak in some cleanup
	s/፡-/፦/g;  # sneak in some cleanup
	s/( )?፡( )?/ /g;

	$_;
}


#########################################################
# Do not change this, Do not put anything below this.
# File must return "true" value at termination
1;
##########################################################


__END__

=encoding utf8

=head1 NAME

Convert::Number::Digits - Convert Digits Between the Scripts of Unicode.


=head1 SYNOPSIS

 use utf8;
 require Convert::Number::Digits;

 my $number = 12345;
 my $d = new Convert::Number::Digits ( $number );
 print "$number => ", $d->toArabic, "\n";

 my $gujarti = $d->toGujarti;
 my $khmer = reverse ( $d->toKhmer );
 $d->number ( $khmer );  # reset the number
 print "$number => $gujarti => ", $d->number, " => ", $n->convert, "\n";


=head1 DESCRIPTION

The C<Convert::Number::Digits> will convert a sequence of digits from one
script supported in Unicode, into another.  UTF-8 encoding is used
for all scripts.



=head1 CAVAETS

Ethiopic, Roman and Tamil scripts do not have a zero.  Western 0 is used instead.

Though a script has digits its numeral system is not necessarily digital.
For example, Roman, Coptic, Ethiopic, Greek and Hebrew.  If you convert
digits into these systems it is assumed that you know what you are doing
(and your starting number is an applicable sequence).  The C<Convert::Number::Digits>
package converts digits and not numbers.


=head1 REQUIRES

The package is known to work on Perl 5.6.1 and 5.8.0 but has not been tested on
other versions of Perl by the author. 

=head1 COPYRIGHT

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=head1 BUGS

None presently known.

=head1 AUTHOR

Daniel Yacob,  L<dyacob@cpan.org|mailto:dyacob@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2003-2025, Daniel Yacob C<< <dyacob@cpan.org> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

=head1 SEE ALSO

L<Convert::Number::Coptic>    L<Convert::Number::Ethiopic>

Included with this package:

  examples/digits.pl

=cut
