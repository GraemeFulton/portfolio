var keystone = require('keystone');

/**
 * PostCategory Model
 * ==================
 */

var SnippetTag = new keystone.List('SnippetTag', {
	autokey: { from: 'name', path: 'key', unique: true }
});

SnippetTag.add({
	name: { type: String, required: true }
});

SnippetTag.relationship({ ref: 'Snippets', path: 'snippettag' });

SnippetTag.register();
