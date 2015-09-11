  
  /**
   * Terrain array
   */
  function TerrainMatrix(scene){
    
    this.floor = [];
    this.tileHeight=1200;
    this.tileWidth=1200;
    this.tileRowNumber = 2;
    this.canvas;
    
    this.scene= scene;
    
    //create perlin noise
    var date = new Date();
    this.perlinNoise = new Perlin('rnd' + date.getTime());
    
  }
  
  /**
   * Terrain functions
   */
  TerrainMatrix.prototype={
    
    constructor: TerrainMatrix,
    
    /**
     * createTerrainMatrix
     * @TODO: create the matrix of terrains - need to add 9 bits of terrain
     */
    createTerrainMatrix:function(){

          //we want a 2 by 2 matrix
          for(var row = 0; row<2; row+=1){
            
            var xPos = this.getXPosition(row);
          
           
            //every 100px on the z axis, add a bit of ground
            for ( var z= this.tileHeight; z > (this.tileHeight * -(this.tileRowNumber-1)); z-=this.tileHeight ) {
        
              //Create the perlin noise for the surface of the ground
      	      var perlinSurface = this.createPerlinSurface( this.tileWidth, this.tileHeight, z, xPos, row);
              //rotate 90 degrees around the xaxis so we can see the terrain 
              perlinSurface.rotation.x = -Math.PI/-2;
    
              //add the ground to the scene
              this.scene.add(perlinSurface); 
              //finally push it to the floor array 
              this.floor.push(perlinSurface); 
            }
          }
      
    },
    
    /**
     * Create Canvas
     */
     createCanvas:function(){
       
      //create the ground material using MeshLambert Material
      var groundMaterial = new THREE.MeshLambertMaterial( {color: 0xffffff, side: THREE.DoubleSide}  );

      //create the plane geometry
      var geometry = new THREE.PlaneGeometry(2400,2400,300,300);
           
      //ensure light is computed correctly
      geometry.computeFaceNormals();
      geometry.computeVertexNormals();
      
      //convert geometry to buffer geometry as it's less memory intensive
      //src: http://stackoverflow.com/questions/18262868/transforming-geometry-to-buffergeometry (what a hero)
      var bufferGeometry = new THREE.BufferGeometry().fromGeometry(geometry) 
      geometry='';
      //create the ground form the geometry and material
      this.canvas = new THREE.Mesh(bufferGeometry,groundMaterial); 
      // Then set the z position to where it is in the loop (distance of camera)
      this.canvas.position.z = 0;
      this.canvas.position.y -= 45;
      this.canvas.position.x =0;
      
      this.canvas.rotation.x = -Math.PI/-2;
      
      this.scene.add(this.canvas)
       
     },
    
    /**
     * moveWithCamera
     * when the camera gets past the first terrain, put the other in front of it
     */
     moveWithCamera(camera){
        // loop through each terrain
        for(var i=0; i<this.floor.length; i++) {
          
          //if the camera has moved past the entire square, move the square
          if((this.floor[i].position.z - this.tileHeight)>camera.position.z){
            
            this.floor[i].position.z-=(this.tileHeight*2);
          }
         //if the camera has moved past the entire square in the opposite direction, move the square the opposite way
          else if((this.floor[i].position.z + this.tileHeight)<camera.position.z){
            
            this.floor[i].position.z+=(this.tileHeight*2);
          }
          
          //x positions
          else if((this.floor[i].position.x - this.tileWidth)>camera.position.x){
            
            this.floor[i].position.x-=(this.tileWidth*2);
          }
          //if the camera has moved past the entire square in the opposite direction, move the square the opposite way
          else if((this.floor[i].position.x + this.tileWidth)<camera.position.x){
            
            this.floor[i].position.x+=(this.tileWidth*2);
          }
           
        }
       
     },
     /**
      * getXPosition
      * @param: int row
      * @returns: an x Position for the row
      */
     getXPosition:function(row){
       /**
        * for the first row, return 'x' as
        * minus the width of the tile so 
        * it is on the left
        */
        if(row==0){
              return -this.tileWidth;
            }
       /**
        * for the second row, return 'x' as
        * 0, so it in the center
        */
         else if(row==1){
             return 0;
         }
       /**
        * for the third row, return 'x' as
        * plus the tile width, 
        * so it on the right
        */
        else if (row==2){
          return this.tileWidth;
        }
     },
     
     /************************
      * Create perlin surface
      ************************/
     createPerlinSurface:function(width, height, zPos, xPos, row){
       
        //create the ground material using MeshLambert Material
     this.groundMaterial = new THREE.MeshLambertMaterial( {color: 0xffffff, side: THREE.DoubleSide}  );

     //create the plane geometry
     this.geometry = new THREE.PlaneGeometry(width,height,300,300);
          
     
     //make the terrain bumpy with perlin noise
     for (var i = 0, l = this.geometry.vertices.length; i < l; i++) {

          if(row<1){
            var vertex = this.geometry.vertices[i];
            var value =  - this.perlinNoise.noise(vertex.x / 100, vertex.y /100, 0);
            vertex.z = value *50;
            var yPos= 50;
          }
          else{
            var yPos=100;
            var vertex = this.geometry.vertices[i];
            var value = - this.perlinNoise.noise(vertex.x / 200, vertex.y /200, 0);
            vertex.z = value *150;
          }
          
        
      }
      
      //ensure light is computed correctly
      this.geometry.computeFaceNormals();
      this.geometry.computeVertexNormals();
      
      //convert geometry to buffer geometry as it's less memory intensive
      //src: http://stackoverflow.com/questions/18262868/transforming-geometry-to-buffergeometry (what a hero)
      var bufferGeometry = new THREE.BufferGeometry().fromGeometry( this.geometry) 
      this.geometry='';
      //create the ground form the geometry and material
      var perlinSurface = new THREE.Mesh(bufferGeometry,this.groundMaterial); 
      // Then set the z position to where it is in the loop (distance of camera)
      perlinSurface.position.z = zPos;
      perlinSurface.position.y -= yPos;
      perlinSurface.position.x =xPos;
      
      return perlinSurface;

       
       
     }
    
  };