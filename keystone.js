 // Simulate config options from your production environment by
// customising the .env file in your project's root folder.
require('dotenv').load();

// Require keystone
var keystone = require('keystone');

// Initialise Keystone with your project's configuration.
// See http://keystonejs.com/guide/config for available options
// and documentation.

keystone.init({

	'name': 'Portfolio',
	'brand': 'Portfolio',
	
	'sass': 'public',
	'static': ['public', 'lib', 'uploads'],
	'favicon': 'public/favicon.ico',
	'views': 'templates/views',
	'view engine': 'jade',
	'auto update': true,
	'session': true,
	'auth': true,
	'user model': 'Users',
	'cookie secret': '1`[Z-*h|nF{1cykku}4y8VUMV4QT,|noJ:H4p<6u,0[+$`5>8(}aD`D-OKG_+4>)',
	'mongo':'mongodb://heroku_app35585747:6o3b5s27m7um8pkpo9rofvr17k@ds061391.mongolab.com:61391/heroku_app35585747',


'wysiwyg override toolbar': false,
'wysiwyg menubar': true,

'wysiwyg additional buttons':'table, media, sh4tinymce, image',

'wysiwyg additional plugins': 'table, sh4tinymce, media, image',
'valid_elements' : "a[href|target=_blank],strong/b,div[align],br"


});

// Load your project's Models

keystone.import('models');

// Setup common locals for your templates. The following are required for the
// bundled templates and layouts. Any runtime locals (that should be set uniquely
// for each request) should be added to ./routes/middleware.js

keystone.set('locals', {
	_: require('underscore'),
	env: keystone.get('env'),
	utils: keystone.utils,
	editable: keystone.content.editable
});

// Load your project's Routes

keystone.set('routes', require('./routes'));

// Setup common locals for your emails. The following are required by Keystone's
// default email templates, you may remove them if you're using your own.

// Configure the navigation bar in Keystone's Admin UI

keystone.set('nav', {
	'writing': ['posts', 'post-categories'],
	'projects':'projects',
	'pages':['pages', 'page-categories'],
	'galleries': 'galleries',
	'enquiries': 'enquiries',
	'users': 'users'
});

// Start Keystone to connect to your database and initialise the web server

//cloudinary
keystone.set('cloudinary config', { cloud_name: 'di8hqle2l', api_key: '355999169279577', api_secret: 'yOi8uRbK1Zl-IpsUECnDfuChOOM' });
 
// optional, will prefix all built-in tags with 'keystone_'
keystone.set('cloudinary prefix', 'keystone');
 
// optional, will prefix each image public_id with [{prefix}]/{list.path}/{field.path}/
keystone.set('cloudinary folders', true);
 
// optional, will force cloudinary to serve images over https
keystone.set('cloudinary secure', true);

keystone.start();
