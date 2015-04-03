var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Gallery Model
 * =============
 */

var Gallery = new keystone.List('Gallery', {
	autokey: { from: 'name', path: 'key', unique: true }
});

Gallery.add({
	name: { type: String, required: true },
	publishedDate: { type: Date, default: Date.now },
	heroImage:  { type: Types.LocalFile,
        dest: './uploads/gallery/single',
        prefix: '/gallery/single',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    },
	images: {
        type: Types.LocalFiles,
        dest: './uploads/gallery/multiple',
        prefix: '/gallery/multiple',
        format: function(item, file){
            return '<img src="' + file.href + '" style="max-width: 300px">'
        }
    }

});

Gallery.register();
