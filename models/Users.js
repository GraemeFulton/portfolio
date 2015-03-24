var keystone = require('keystone'),
	Types = keystone.Field.Types;

/**
 * Users Model
 * ==========
 */

var Users = new keystone.List('Users');

Users.add({
	name: { type: Types.Name, required: true, index: true },
	email: { type: Types.Email, initial: true, required: true, index: true },
	password: { type: Types.Password, initial: true, required: true }
}, 'Permissions', {
	isAdmin: { type: Boolean, label: 'Can access Keystone', index: true }
});

// Provide access to Keystone
Users.schema.virtual('canAccessKeystone').get(function() {
	return this.isAdmin;
});


/**
 * Relationships
 */

Users.relationship({ ref: 'Post', path: 'posts', refPath: 'author' });


/**
 * Registration
 */

Users.defaultColumns = 'name, email, isAdmin';
Users.register();
