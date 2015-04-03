var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Projects Model
 * ==========
 */

var Projects = new keystone.List('Projects', {
	map: { name: 'title' },
	autokey: { path: 'slug', from: 'title', unique: true }
});

Projects.add({
	title: { type: String, required: true },
	state: { type: Types.Select, options: 'draft, published, archived', default: 'draft', index: true },
	author: { type: Types.Relationship, ref: 'Users', index: true },
	publishedDate: { type: Types.Date, index: true, dependsOn: { state: 'published' } },
	image: { type: Types.LocalFile,
        dest: './uploads/project/single',
        prefix: '/project/single',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    },
	content: {
		brief: { type: Types.Html, wysiwyg: true, height: 150 },
		extended: { type: Types.Html, wysiwyg: true, height: 400 }
	},
	images: {
        type: Types.LocalFiles,
        dest: './uploads/project/multiple',
        prefix: '/project/multiple',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    }
	// categories: { type: Types.Relationship, ref: 'PostCategory', many: true }
});

Projects.schema.virtual('content.full').get(function() {
	return this.content.extended || this.content.brief;
});

Projects.defaultColumns = 'title, state|20%, author|20%, publishedDate|20%';
Projects.register();
