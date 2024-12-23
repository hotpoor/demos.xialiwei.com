root = exports ? this
root.Hs or= {}
Hs = root.Hs

$ ->
    THREE = THREEJS
    # console.log "THREEJS",THREEJS
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
    camera = null
    scene = null
    renderer = null
    isPlaying = false
    isUserInteracting = false
    lon = 0
    lat = 0
    phi = 0
    theta = 0
    onPointerDownPointerX = 0
    onPointerDownPointerY = 0
    onPointerDownLon = 0
    onPointerDownLat = 0

    distance = 0.5

    current_texture = null
    material = null


    # 全景视频
    Hs.init=()->
        container = document.getElementById( 'container' )
        camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, .25, 10 )
        scene = new THREE.Scene()
        geometry = new THREE.SphereGeometry( 5, 60, 40 )
        geometry.scale( - 1, 1, 1 )
        video = document.getElementById( 'video' )
        # video.play()
        current_texture = new THREE.VideoTexture( video )

        current_texture.colorSpace = THREE.SRGBColorSpace
        material = new THREE.MeshBasicMaterial( { map: current_texture } )

        mesh = new THREE.Mesh( geometry, material )
        scene.add( mesh )

        renderer = new THREE.WebGPURenderer( { antialias: true } )
        renderer.setPixelRatio( window.devicePixelRatio )
        renderer.setSize( window.innerWidth, window.innerHeight )
        renderer.setAnimationLoop( animate )
        container.appendChild( renderer.domElement )

        document.addEventListener( 'pointerdown', onPointerDown )
        document.addEventListener( 'pointermove', onPointerMove )
        document.addEventListener( 'pointerup', onPointerUp )


        window.addEventListener( 'resize', onWindowResize )


    onWindowResize = ()->
        camera.aspect = window.innerWidth / window.innerHeight
        camera.updateProjectionMatrix()
        renderer.setSize( window.innerWidth, window.innerHeight )

    onPointerDown=( event )->
        isUserInteracting = true

        onPointerDownPointerX = event.clientX
        onPointerDownPointerY = event.clientY

        onPointerDownLon = lon
        onPointerDownLat = lat
    onPointerMove=( event )->
        if isUserInteracting
            lon = ( onPointerDownPointerX - event.clientX ) * 0.1 + onPointerDownLon
            lat = ( onPointerDownPointerY - event.clientY ) * 0.1 + onPointerDownLat
    onPointerUp=()->
        isUserInteracting = false
    animate=()->
        if isPlaying
            update()
    update=()->
        lat = Math.max( - 85, Math.min( 85, lat ) )
        phi = THREE.MathUtils.degToRad( 90 - lat )
        theta = THREE.MathUtils.degToRad( lon )

        camera.position.x = distance * Math.sin( phi ) * Math.cos( theta )
        camera.position.y = distance * Math.cos( phi )
        camera.position.z = distance * Math.sin( phi ) * Math.sin( theta )

        camera.lookAt( 0, 0, 0 )

        renderer.render( scene, camera )
    Hs.init()
    video_list = [
        "02CloudIntro_V2.mp4",
        "03Santorini_V2.mp4",
        "04Matterhorn_01Zermatt_V2.mp4",
        "04Matterhorn_02Riffelsee_V2.mp4",
        "05Russia31_Baikal_V2.mp4",
        "05Russia31_Moscow_V2.mp4",
        "05Russia31_Volga_V2.mp4",
        "06Norway_V2.mp4",
        "07Finland_V2.mp4",
        "08Uganda_01Griaffes_V2.mp4",
        "08Uganda_02Elephants_V2.mp4",
        "09Sahara_V2.mp4",
        "10Petra_Colosseum_V2.mp4",
        "10Petra_Temple_V2.mp4",
        "11Antarctica_Ice_V2.mp4",
        "11Antarctica_Penguin_V2.mp4",
        "12NewYork_2_v2.mp4",
        "12NewYork_V2.mp4",
        "13America31_Carribean_V2.mp4",
        "13America31_Rio_V2.mp4",
        "13America31_SF_V2.mp4",
        "14Mexico_V2.mp4",
        "15AngelFalls_V2.mp4",
        "16Shanghai_V2.mp4",
        "18Dream31_City_V2.mp4",
        "18Dream31_Grassland_V2.mp4",
        "18Dream31_Mountain_V2.mp4",
    ]
    video_list_index = 0
    $("body").on "click","#play_btn",(e)->
        if video.muted
            video.muted = false
        video.play()
    $("#video").on "play",(evt)->
        isPlaying = true
    $("#video").on "ended",(evt)->
        isPlaying = false
        video_list_index +=1
        if video_list_index >=video_list.length
            return
        video.src = "/static/video/"+video_list[video_list_index]
        video.play()

        current_texture = new THREE.VideoTexture( video )
        current_texture.colorSpace = THREE.SRGBColorSpace
        material.map = current_texture
        material.needsUpdate = true  # 告诉 Three.js 需要更新材质
