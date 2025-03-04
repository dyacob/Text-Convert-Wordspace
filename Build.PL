use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
	module_name		=> 'Text::Convert::Wordspace',
	dist_version_from	=> 'lib/Text/Convert/Wordspace.pm',
	dist_author		=> 'Daniel Yacob <dyacob\@cpan.org>',
	dist_abstract		=> "Convert between Ethiopic wordspaces and ASCII spaces.",
	release_status		=> 'stable',
	configure_requires	=> { 'Module::Build' => 0.42 },
	requires 		=> {
		'perl'		=> '5.6.1',
	},
	license			=> 'perl',
	add_to_cleanup		=> [ 'Text-*' ],
	create_makefile_pl	=> 0,  # change to 1 if desired.
	meta_merge		=> {
        	resources => {
			bugtracker => 'https://github.com/dyacob/Text-Convert-Wordspace/issues',
			repository => 'https://github.com/dyacob/Text-Convert-Wordspace.git',
			homepage => 'https://github.com/dyacob/Text-Convert-Wordspace'
		},
		x_authority	=> 'cpan:dyacob'
	}
);

$builder->create_build_script();
