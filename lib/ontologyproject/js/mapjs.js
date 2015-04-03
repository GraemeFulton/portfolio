$(document).ready(function(){
    $("#refresh").hide();
      $("#uk").hide();
      $("#de").hide();
      $("#es").hide();
      $(".loading").hide();
    
    
  ///////////////////////////////////////
 ////////RANDOM COLOUR GENERATOR/////////
 ///////////////////////////////////////
 
      //function to get random colours for each road, hopefully they end up different colours!
       function get_random_color()
 {
       
    var letters = '0123456789ABCDEF'.split('');
    var color = '#';
    for (var i = 0; i < 6; i++ ) 
    {
        color += letters[Math.round(Math.random() * 15)];
    }
    return color;
}
/////////////////////////////////////////////////////

///////////////////////////////////////
 ////////GET HIGHSTREET ROADS/////////
 ////////////////////////////////////
 
     function getRoad()
     {
         
         var allRoads = "Type(?Road, HighstreetRoad)";
        
          submitRoad(allRoads); 
           
     }
        
        function submitRoad(query)
        {
        
	new jOWL.SPARQL_DL(query).execute({ onComplete : displayRoads});
           	
	}
        
        
        var roadIndex=[];
        
        function displayRoads(obj)
        {
                                            
	     for(var i=0;i<obj.results.length;i++)
             {
		  var txt = [];
                                        
		   for(x in obj.results[i])
                   { 
		     var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label(); 
                      txt.push(str);
                      str=str.replace(/\s+/g,''); //remove all spaces from str so that it can be used as an ID tag
                                                
                      roadIndex.push(str);  //adding to road index array    
                                                
		  }
                                     
               var rds =  '<ul id="'+str+'" data-color="'+get_random_color()+'" data-label="'+txt+'"> </ul>'
                                       
               $('.subway-map').append(rds);
                                       
	      }     
       }
        
       
         var roadBuilder=3;//global variable will be incremented to move roads onto the next line
         var streetMatch=0;//global variable will be incremented to change the <ul> road element
         //
         //function passover: go through each road, and ask what shops are present. Then invoke the display shops function
       function passover(){
           
           for (var i=0;i<roadIndex.length;i++){
               var query=[]; //create an array to store all of the queries
               
   //TEST            $('.qry').append("<p> "+roadIndex[i]+" </p>"); //test - printing each shop out 
               
               //create a query from each roadIndex name that will be used to find the shops on that road
                query[i]= "Type(?Shoptype, Shop), PropertyValue(?Shoptype, hasRoad, "+roadIndex[i]+" )"; 
                
   //TestOnly              $('.qry').append("<div> "+query[i]+" </div>"); //test - printing out each query generated 
   
              //TASK DONE: now im gonna change the roads just to represent the highstreet, because then no queries will show errors
              //now send the query to be processed one at a time (one iteration at a time)
          
          
                submit(query[i]);
                roadBuilder++;
                streetMatch++;
                
        //TestOnly        $('.qry').append("<br>"); //just adding spaces between each query
                
                //by here, each query has been processed.
           }
       }
       
       
     
       
        //////////////////////////////////////////////
 
    function submit(query){
       	
	  new jOWL.SPARQL_DL(query).execute({ onComplete : displayShops});
               
	}
        ///////////////////////////////////////////
        /////////////////////////////////////////
         //////DISPLAYSHOPS///////////////////////////
        ///////////////////////////////////////////
    
   
       function displayShops(obj){
          
		//var display = $('.qry');
                 var shops=[];
			
				for(var i=0;i<obj.results.length;i++){
					var txt = [];
					for(x in obj.results[i]){ 
						var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label();
						txt.push(str);
                                                var  shopIndex=i+10;
                                                
                                                shops.push(str);  //shops to array  
                                                
                                  //all query results have been put in an array,
                                
						}
			//Testonly		display.append("<div>"+txt+"</div>"); //test - printing the results of the query
                                        
                                         
                                        
                                      var info = '<li data-coords="'+shopIndex+','+ roadBuilder +'" data-marker="'+HS+'" data-labelPos="'+hsdir+'">'+txt+'</li>'
                                     txt
                                      $('#' + roadIndex[streetMatch]).append(info);
				}
			
		}
              
         ///////////////////////////////////////////////
        //////////////////////////////////////////////
        
      /////////////////////////////////////////////////////
      ///END OF HIGHSTRET, NOW GET THE SUPERMARKETS ://////
      /////////////////////////////////////////////////////



 function getSuperMarket()
     {
         
         var superMarket = "Type(?Supermarket, Shop), PropertyValue(?Supermarket, hasComplex, SupermarketComplex)";
        
           new jOWL.SPARQL_DL(superMarket).execute({ onComplete : displaySupermarkets});
           
     }
        
        
 function displaySupermarkets(obj){
           var stuff=  "<ul id='Road' data-color='#C7C7C7' data-label='Road'> </ul>"
            
            $(".subway-map").append(stuff);
            
            
		var display = $('.qry');
                 var supermark=[];
			
				for(var i=0;i<obj.results.length;i++){
					var txt = [];
					for(x in obj.results[i]){ 
						var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label();
						txt.push(str);
                                               
                                                
                                                supermark.push(str);  //shops to array  
                                                
                                  //all query results have been put in an array,
                                
						}
			//		display.append("<div>"+txt+"</div>"); //test - printing the results of the query
                                        
                                         
                                        
                                      var info = '<li data-coords="1,'+(i+2)+'" data-marker="'+LS+'" data-labelPos="'+supermarkt+'">'+txt+'</li>'
                                      $('#Road' ).append(info);
				}
			
		}







 ////////////////
 ///END //////
  /////////////
  
  
  
      /////////////////////////////////////////////////////
      ///NOW GET THE RETAIL PARK SHOPS ://////
      /////////////////////////////////////////////////////



 function getRetailPark()
     {
         
         var retailParkShop = "Type(?RetailParkShop, Shop), PropertyValue(?RetailParkShop, hasComplex, RetailParkComplex)";
        
           new jOWL.SPARQL_DL(retailParkShop).execute({ onComplete : displayRetailParkShops});
           
     }
        
        
 function displayRetailParkShops(obj){
           var stuff=  "<ul id='RetailParkRoad' data-color='#C7C7C7' data-label='Road'> </ul>"
            
            $(".subway-map").append(stuff);
            
            
		var display = $('.qry');
                 var retpark=[];
			
				for(var i=0;i<obj.results.length;i++){
					var txt = [];
					for(x in obj.results[i]){ 
						var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label();
						txt.push(str);
                                               
                                                
                                                retpark.push(str);  //shops to array  
                                                
                                  //all query results have been put in an array,
                                
						}
			//		display.append("<div>"+txt+"</div>"); //test - printing the results of the query
                                        
                                         
                                        
                                      var info = '<li data-coords="4,'+(i+2)+'" data-marker="'+RS+'" data-labelPos="'+rsdir+'">'+txt+'</li>'
                                      $('#RetailParkRoad' ).append(info);
				}
			
		}







 /////////////
 ///END //////
  ////////////
  
      ////////////////////////////////////////////
      ///NOW GET THE OUTSKIRTS AREA SHOPS ://////
      //////////////////////////////////////////



 function getOutskirtShop()
     {
         
         var outskirtShop = "Type(?WarehouseShop, Shop), PropertyValue(?WarehouseShop, hasRoad, MotorwayRoad)";
        
           new jOWL.SPARQL_DL(outskirtShop).execute({ onComplete : displayOutskirtShops});
           
     }
        
        
 function displayOutskirtShops(obj){
           var stuff=  "<ul id='Outskirts' data-color='#C7C7C7' data-label='Road'> </ul>"
            
            $(".subway-map").append(stuff);
            
            
		var display = $('.qry');
                 var outshop=[];
			
				for(var i=0;i<obj.results.length;i++){
					var txt = [];
					for(x in obj.results[i]){ 
						var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label();
						txt.push(str);
                                               
                                                
                                                outshop.push(str);  //shops to array  
                                                
                                  //all query results have been put in an array,
                                
						}
			//		display.append("<div>"+txt+"</div>"); //test - printing the results of the query
                                        
                                         
                                        
                                      var info = '<li data-coords="19,'+(i+2)+'" data-marker="'+WS+'" data-labelPos="SW">'+txt+'</li>'
                                      $('#Outskirts' ).append(info);
				}
			
		}

  
  /////////////////////////////////////////
 ////////HIGHLIGHT SEARCH RESULTS////////
 ///////////////////////////////////////
 
 
    function submitQuery(query){
       	
	  new jOWL.SPARQL_DL(query).execute({ onComplete : highlightShops});
               
	}
        ///////////////////////////////////////////
        
         function highlightShops(obj){
           
          
		var display = $('.qry');
                display.empty();
                display.append("<h3>Search Results</h3>"); 
                 
			
				for(var i=0;i<obj.results.length;i++){
					var txt = [];
					for(x in obj.results[i]){ 
						var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label();
						txt.push(str);
                                               
                                                                                               
                                  //all query results have been put in an array,
                                
						}
					display.append("<p>"+txt+"</p>"); //test - printing the results of the query
                                
                            //on the results of the product search, shops that sell the products are returned in the array. 
                            //next, we just match each shop returned with the same text on the map layout, and replace it with css
                                  $('span:contains('+txt+')').each(function(){
                                     $(this).html(
                                     $(this).html().replace(''+txt+'','<span id= "foo" class="highlight">'+txt+'</span>')
                                     );
                                    });
                                
                                  ////color: aqua; font-style:italic; font-size:larger; font-weight:900;
				}
			
		}
  
  
   
   

///////////////////////////////////////////////////////////////////////////////////////////////
//Equivalent to a main method: Loads the owl document, and then sets the map up on the page///
/////////////////////////////////////////////////////////////////////////////////////////////
var HS= "station";
var RS= "station";
var LS= "interchange";
var WS= "interchange";

 var supermarkt="se";
var rsdir= "e";
var hsdir="n";
//icons

   //////////////////
   //MENU FORM//////
   ////////////////
   var ctry;
   //on submit
  $("#form1").submit (function(){
 ctry=  $("select#slt_country").val();
var zm=  $("select#slt_zoom").val();
var ic=  $("select#slt_icons").val();

//if buildings selected, change icons and background
if (ic=="Buildings"){
     //change icons
     HS= "hshop";
     RS= "rshop";
     LS= "bigbox";
     WS= "warehouse";
    
    
    rsdir= "rs";
    hsdir="hs";
    supermarkt="rs";
    //change background css: TODO
}

if (ic=="Buildings2D"){
     //change icons
     HS= "hsshop2d";
     RS= "rsshop2d";
     LS= "su2d";
     WS= "wh2d";
    
    
    rsdir= "rs";
    hsdir="hs";
    supermarkt="rs";
    //change background css: TODO
}



//if zoom is set to in, make changes to grid cell size and text size
if (zm=="Out"){
    
    
    $(".subway-map").attr("data-cellSize", "60").attr("data-textClass", "text");
}
 
//$(".qry").append(ctry);
//$(".qry").append(zm);
$(".Instructions").hide();
$(".loading").show();
 $('#loading_image').show();
 
if (ctry=="uk.owl"){
    $("#uk").fadeIn(2000);
}
if (ctry=="german.owl"){
    $("#de").fadeIn(2000);
}
if (ctry=="spain.owl"){
    $("#es").fadeIn(2000);
}

setTimeout (function(){printinfo()}, 1800);
setTimeout(function(){load(ctry)}, 2000); //calls the load function

return false;
});
 
  function printinfo(){
   $(".loading").append("<h2> Loading Ontology....</h2> <font color='red'>Please allow up to 30 seconds for ontology to be loaded</font>");
  $("#refresh").show();
  
  }
     function load(x){
             
  
   var go= new loadOnt (x);
 
}

    
  

$("#refresh").click(function(){
      
       location.reload();

});
   
 



   //load ontology
   function loadOnt(x){
 
    this.x=x;

    jOWL.load(x, function(){
      $(".Instructions").hide();
   
      $(".loading").hide();
        
        reason : true;
    
        getRoad();

        passover();
        
        getSuperMarket();
        
        getRetailPark();
        
        getOutskirtShop();
        
        addRoad();
        
        
       
 ///////////////////////////////////////////////////////////////////////////////
 ////////////////////END OF MAIN METHOD////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////
       
       //////////////////
       //QUERY BOX///////
       //////////////////

        //after the map has been loaded, we start processing queries.
       // searchProduct();
        
             $('#sparql').show().submit(function(){
             
            
            $('span#foo').removeClass('highlight');  //remove previous search highlighting

            var userInput=  $('input', this).val();   //stores textbox input into a variable
            
            userInput=userInput.replace(/\s+/g,''); //remove all spaces from str so that it can be used as an ID tag
                      
            userInput = userInput.replace(/([a-z])(?=[0-9])/ig, '$1_'); //if number next to letter, add underscore
            
            var runInput= 'Type(?x, Shop),  PropertyValue(?x, sellsItem,'+userInput+')'; //adds user input to query
            
            submitQuery(runInput);
            
            return false; 
		
            });
        //////////////////////////////
       
            
    
   ///////////////////////////////////////
  //////AUTOCOMPLETE BOX/////////////////
 ///////////////////////////////////////
 
     //return all individuals      
       function searchProduct(){
         
         var go = "Thing(?i)";
        
          submitProduct(go); 
           
        }
        
        
        function submitProduct(query){
       	
	  new jOWL.SPARQL_DL(query).execute({ onComplete : getIndividuals});
               
	}
      
        var indi=[];
      
        function getIndividuals(obj)
        {
                                            
	     for(var i=0;i<obj.results.length;i++)
             {
		  var txt = [];
                                        
		   for(x in obj.results[i])
                   { 
		     var str = (typeof obj.results[i][x] == 'string') ? obj.results[i][x] : obj.results[i][x].label(); 
                      txt.push(str);
                                                                      
                      indi.push(str);  //adding to road index array    
                                                
		  }
                                     
	      }     
       }
        
        
     //autocomplete part
        
      $(function() {
                
                searchProduct();
                                        
		$( "#tags" ).autocomplete({
			source: indi
		});
	});
      


          }, {reason : true});//end of jOWL.load
   }
    
});//end of document ready




 function addRoad(){
              
       //add highstreet road
         $('.subway-map').append( '<ul data-color="#D6D6D6" ><li data-marker="town" data-labelPos="e" data-coords="11,2" data-dir="W">.</li><li data-coords="11,16" data-dir="S"></li>')
           
        //add base road
         $('.subway-map').append( '<ul data-color="#D6D6D6"><li data-coords="0,1" ></li><li data-coords="10,1"></li><li data-coords="11,2" data-dir="E"></li>')   
        
     
        
        //add residential roads
         $('.subway-map').append( '<ul data-color="#D6D6D6"><li data-coords="7,1" ></li><li data-coords="6,2" data-dir="S"></li><li data-coords="1,2" sdata-dir="S"></li>')   
         $('.subway-map').append( '<ul data-color="#D6D6D6"><li data-marker="res" data-labelPos="w" data-coords="1,1" >.</li><li data-coords="1,6" data-dir="S"></li>')   
        //add outskirt roads
         $('.subway-map').append( '<ul data-color="#D6D6D6"><li data-coords="10,1" ></li><li data-marker="out" data-labelPos="s" data-coords="19,1">.</li><li data-coords="19,2"></li><li data-coords="19,1"></li><li data-coords="25,1"></li>')   
        
       
        
         $(".subway-map").subwayMap({ debug: true });
      
      }