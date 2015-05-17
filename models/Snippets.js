var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Post Model
 * ==========
 */

var Snippets = new keystone.List('Snippets', {
	map: { name: 'title' },
	autokey: { path: 'slug', from: 'title', unique: true }
});

Snippets.add({
	title: { type: String, required: true },
	gist: { type: String, required: false, default:'',
	format: function(item, file){
            return '<script src="' + file.href + '"></script>'
    }},
	state: { type: Types.Select, options: 'draft, published, archived', default: 'draft', index: true },
	author: { type: Types.Relationship, ref: 'Users', index: true },
	publishedDate: { type: Types.Date, index: true, dependsOn: { state: 'published' } },
	image: {type: Types.LocalFile,
        dest: './uploads/post/single',
        prefix: '/post/single',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    },
	content: {
		brief: { type: Types.Html, wysiwyg: true, height: 150 },
		extended: { type: Types.Html, wysiwyg: true, height: 400 }
	},
	categories: { type: Types.Relationship, ref: 'SnippetTag', many: true },
	images: {
        type: Types.LocalFiles,
        dest: './uploads/post/multiple',
        prefix: '/post/multiple',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    }
});

Snippets.schema.virtual('content.full').get(function() {
	return this.content.extended || this.content.brief;
});

Snippets.defaultColumns = 'title, state|20%, author|20%, publishedDate|20%';
Snippets.register();
