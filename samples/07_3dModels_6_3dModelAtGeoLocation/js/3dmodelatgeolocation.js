    // coordinates({lat, lon, alt, acc})
    var coordinates = [];

    var World = {

        //objectsnames => contained by API call
        objectsNames: [
            { 'name': 'earth', 'relativelat': 1, 'relativelon': 1, 'relativeacc': 1 },
            { 'name': 'earth', 'relativelat': -1, 'relativelon': -3, 'relativeacc': 2 }
        ],

        rotating: false,


        init: function initFn() {},

        // get the location of the user by flutter and add to array.
        locationChanged: function locationChanged(lat, lon, alt, acc) {
            coordinates.push({ 'lat': lat, "lon": lon, "alt": alt, "acc": acc })

            //if array contains one record => make the objects based on the first coordinates in the array
            if (coordinates.length == 1) {

                World.objectsNames.forEach(element => {
                    World.createModelAtLocation(element.name, element.relativelat, element.relativelon, element.relativeacc);
                    console.log("----- WIKITUDE ----- made object  " + element.name);
                })
            }
        },


        createModelAtLocation: function createModelAtLocationFn(modelname, rel_latitide, rel_longitude, rel_altitude) {
            console.log('-------WIKITUDE: CreateModel')
                //abosolute locations
            var location = new AR.GeoLocation(
                parseFloat(coordinates[0].lat + (rel_latitide / 10000)),
                parseFloat(coordinates[0].lon + (rel_longitude / 10000)),
                parseFloat(coordinates[0].alt + (rel_altitude / 10000)),

            );
            console.log("-------WIKITUDE: --------------------------ran createModel, ")
                /* Next the model object is loaded. */
            var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
                onError: World.onError,
                scale: {
                    x: 1,
                    y: 1,
                    z: 1
                },
                onClick: function() {
                    console.log('-------WIKITUDE: --------------------------------MODEL CLICKED' + modelname);
                }
            });

            // var indicatorImage = new AR.ImageResource("assets/models/indi.png", {
            //     onError: World.onError
            // });

            // var indicatorDrawable = new AR.ImageDrawable(indicatorImage, 0.1, {
            //     verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP
            // });


            /* Putting it all together the location and 3D model is added to an AR.GeoObject. */
            this.geoObject = new AR.GeoObject(location, {
                onError: World.onError,
                drawables: {
                    cam: [modelEarth],
                    // indicator: [indicatorDrawable]
                }
            });
            /*
                        this.appearingAnimation = this.createAppearingAnimation(this.modelEarth, 5, 1000);
                        this.trackable = new AR.ImageTrackable(this.tracker, "*", {
                            drawables: {
                                cam: [this.modelEarth]
                            },
                            onImageRecognized: World.appear,
                            onError: World.onError
                        });
            */
        },
        onError: function onErrorFn(error) {
            alert(error);
        },
        /*
                createAppearingAnimation: function createAppearingAnimationFn(model, scale, time) {

                    var sx = new AR.PropertyAnimation(model, "scale.x", 0, scale, time, {
                        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC
                    });
                    var sy = new AR.PropertyAnimation(model, "scale.y", 0, scale, time, {
                        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC

                    });
                    var sz = new AR.PropertyAnimation(model, "scale.z", 0, scale, time, {
                        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC
                    });
                    var rz = new AR.PropertyAnimation(model, "rotate.tilt", 360, time, {
                        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_CIRC
                    });
                    var ry = new AR.PropertyAnimation(model, "rotate.y", 360, time, {
                        type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_CIRC
                    });
                    var animationgroup = AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [sx, sy, sz, rz, ry]);
                    animationgroup.start(-1)
                },

                appear: function appearFn() {
                    World.hideInfoBar();
                    World.appearingAnimation.start();
                },
        */
    };

    World.init();

    //if location change is called upon in flutter => alert wikitude
    AR.context.onLocationChanged = World.locationChanged;