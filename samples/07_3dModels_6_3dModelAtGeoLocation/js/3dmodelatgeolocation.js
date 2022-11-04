    // coordinates({lat, lon, alt, acc})
    var coordinates = [];

    var World = {

        //objectsnames => contained by API call
        objectsNames: [
            // { 'name': 'OFF_Sword', 'relativelat': 1, 'relativelon': 1, },

        ],

        startCoordinates: {},


        init: function initFn() {},

        // get the location of the user by flutter and add to array.
        locationChanged: function locationChanged(lat, lon, alt, acc) {
            coordinates.push({ 'lat': lat, "lon": lon, "alt": alt, "acc": acc })

            //start creating models if startcoordinates are in.
            //   if (this.startCoordinates != null) {
            if (coordinates.length == 1) {
                //for each object in the objecNames => make model
                World.objectsNames.forEach(element => {
                    World.createModelAtLocation(element.name, element.relativelat, element.relativelon, element.relativeacc);
                    console.log("----- WIKITUDE ----- made object  :" + element.name + "_end");
                })
            }
        },


        createModelAtLocation: function createModelAtLocationFn(modelname, rel_latitide, rel_longitude, rel_altitude) {
            //      console.log('-------WIKITUDE: CreateModel at startlocation: ' + modelname + "loc: " + startCoordinates.lat)
            //abosolute locations
            var location = new AR.GeoLocation(
                parseFloat(coordinates[0].lat + (rel_latitide / 10000)),
                parseFloat(coordinates[0].lon + (rel_longitude / 10000)),
                // parseFloat(startCoordinates.lat + (rel_latitide / 10000)),
                // parseFloat(startCoordinates.lon + (rel_longitude / 10000)),
            );
            /* Next the model object is loaded. */
            var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
                onError: World.onError,
                scale: {
                    x: 1,
                    y: 1
                },
                onClick: function() {
                    console.log('-------WIKITUDE: --------------------------------MODEL CLICKED' + modelname);
                    AR.platform.sendJSONObject({
                        "modelname": modelname
                    });
                }
            });


            /* Putting it all together the location and 3D model is added to an AR.GeoObject. */
            this.geoObject = new AR.GeoObject(location, {
                onError: World.onError,
                drawables: {
                    cam: [modelEarth],
                    // indicator: [indicatorDrawable]
                }
            });

        },
        onError: function onErrorFn(error) {
            alert(error);
        },

        //------From Flutter to Wiki => Give information for models
        getModelNames: function getModelNamesFn(objectname, relLatitude, relLongitude) {
            this.objectsNames.push({ 'name': objectname, 'relativelat': relLatitude, 'relativelon': relLongitude }, )
        },
        //------From Flutter to Wiki => Give information for models
        setStartCoordinates: function setStartCoordinatesFn(lat, lon, alt, acc) {
            this.startCoordinates = { 'lat': lat, "lon": lon, "alt": alt, "acc": acc }
        }
    };

    World.init();

    //if location change is called upon in flutter => alert wikitude
    AR.context.onLocationChanged = World.locationChanged;