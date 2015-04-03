$(document).ready(function(){
    
    //load ontology
    jOWL.load("uk.owl", function(){
        reason : true;
        
     //once loaded, remove the loading display
		$('.loader').hide(); $('#demo').show();
		//initialize UI components
		var tree = $('#treeview').owl_treeview({rootThing: true});
                
                //tooltip requires jquery.tooltip.js script (removed crappy $$rdfcomment)
		var tooltip = $('#thingtooltip').owl_propertyLens({
			tooltip : true,
			"sparql-dl:PropertyValue(owl:Thing, ?y, ?z)": { sort: "?y" }
		});
                
                //individuals
                var individuals = $('#individuals').owl_propertyLens({
			chewsize : 100,
			onChange : {
				"owl:Thing": function(source, target, resourcebox){
				tooltip.display(target, this);
				}
			}
			});
                        
                        
                        
                 
                 //inserts navbar box
                 var navbar = $('#navbar').owl_navbar();
                 
                 //autocomplete?
                 var autocomplete = $('#owlauto').owl_autocomplete({focus : true, chars : 2, filter : 'Class'});
                 
                 //making sure components respond to each others input:
		navbar.addListener([individuals, tree]);
		autocomplete.addListener([navbar, individuals, tree]);
		tree.addListener([individuals, navbar]);
                
                
                
                
                //set focus on the text input for user.
		$('#owlauto').focus(); 
                
                
        //fire up the components, on the owl Class wine
		var shop = jOWL("http://www.csc.liv.ac.uk/~m1gf/shopping#NamedShop");

		navbar.propertyChange(shop);
		navbar.broadcast(shop);
                
                
        
    }, {reason : true});//end of jOWL.load
    
});//end of document ready





