   /**
   * Cube
   */
  function Cube(){
    
		//create box geometry object
		this.geometry = new THREE.BoxGeometry( 0, 0, 0 );
		//create material with colour
		this.material = new THREE.MeshBasicMaterial( { color: 0x0000ff } );
		//combine geometry with material to create the cube
		this.cube = new THREE.Mesh( this.geometry, this.material );
  }
  
  Cube.prototype={
    constructor:Cube,
    addCube:function(scene){
      //add light to the scene
      scene.add( this.cube );
    
    },
    update:function(camera, keyboard, clock){
      
      var delta = clock.getDelta(); // seconds.
    	var moveDistance = 150 * delta; // 200 pixels per second
    	var rotateAngle = Math.PI / 2 * delta;   // pi/2 radians (90 degrees) per second
    	
    	// local transformations
    
    	// move forwards/backwards/left/right
    	if ( keyboard.pressed("up") )
    		this.cube.translateZ( -moveDistance );
    	if ( keyboard.pressed("down") )
    		this.cube.translateZ(  moveDistance );
    	if ( keyboard.pressed("Z") )
    		this.cube.translateX( -moveDistance );
    	if ( keyboard.pressed("X") )
    		this.cube.translateX(  moveDistance );	
    
    	// rotate left/right
    	//var rotation_matrix = new THREE.Matrix4().identity();
    	if ( keyboard.pressed("left") )
    		this.cube.rotateOnAxis( new THREE.Vector3(0,1,0), rotateAngle);
    	if ( keyboard.pressed("right") )
    	 	this.cube.rotateOnAxis( new THREE.Vector3(0,1,0), -rotateAngle);
      
      // rotate up/down
    	// if ( keyboard.pressed("R") )
    	// 	this.cube.rotateOnAxis( new THREE.Vector3(1,0,0), rotateAngle);
    	// if ( keyboard.pressed("F") )
    	// 	this.cube.rotateOnAxis( new THREE.Vector3(1,0,0), -rotateAngle);
    	
    	if ( keyboard.pressed("P") )
    	{
    		this.cube.position.set(0,1,0);
    		this.cube.rotation.set(0,0,0);
    	}
    	
    	var relativeCameraOffset = new THREE.Vector3(0,1,20);
    
    	var cameraOffset = relativeCameraOffset.applyMatrix4( this.cube.matrixWorld );
    
    	camera.position.x = cameraOffset.x;
    	camera.position.y = cameraOffset.y;
    	camera.position.z = cameraOffset.z;
    	camera.lookAt( this.cube.position );
      
      
    }
  };