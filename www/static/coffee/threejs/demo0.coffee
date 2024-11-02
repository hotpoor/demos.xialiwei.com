# import * as THREE from '/static/js/threejs/three/build/three.module.js'
# console.log "THREE",THREE
# scene = new THREE.Scene()
# console.log scene
# camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
# console.log camera
# renderer = new THREE.WebGLRenderer()
# console.log renderer


# geometry = new THREE.BoxGeometry( 1, 1, 1 )
# material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )
# cube = new THREE.Mesh(geometry,material )
# console.log cube
# scene.add(cube )

# camera.position.z = 5
# animate=()->
#    console.log "animate"
#    cube.rotation.x += 0.01
#    cube.rotation.y += 0.01
#    renderer.render(scene,camera )

# renderer.setAnimationLoop(animate )
# renderer.setSize( window.innerWidth, window.innerHeight )
# document.body.appendChild(renderer.domElement )

root = exports ? this
root.Hs or= {}
Hs = root.Hs

$ ->
   THREE = THREEJS
   console.log "THREEJS",THREEJS
   console.log "THREE",THREE
   scene = new THREE.Scene()
   console.log scene
   camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
   console.log camera
   renderer = new THREE.WebGLRenderer()
   console.log renderer


   geometry = new THREE.BoxGeometry( 1, 1, 1 )
   material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } )
   cube = new THREE.Mesh(geometry,material )
   console.log cube
   scene.add(cube )

   camera.position.z = 5
   animate=()->
      console.log "animate"
      cube.rotation.x += 0.01
      cube.rotation.y += 0.01
      renderer.render(scene,camera )

   renderer.setAnimationLoop(animate )
   renderer.setSize( window.innerWidth, window.innerHeight )
   document.body.appendChild(renderer.domElement )