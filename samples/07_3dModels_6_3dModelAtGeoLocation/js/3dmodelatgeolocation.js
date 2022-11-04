    // coordinates({lat, lon, alt, acc})


    var World = {

        //objectsnames => contained by API call
        objectsNames: [],

        //startcoordinates => contained by API call
        startCoordinates: {},
        //Coordinates => push the user position coordinates
        coordinates: [],

        init: function initFn() {},
        //1: ------From Flutter to Wiki => Give information for models
        getModelNames: function getModelNamesFn(objectname, relLatitude, relLongitude) {
            console.log("STEP 1 : GET Modelnames from JS " + objectname)
            console.log("STEP 1 : GET Modelnames from JS " + relLatitude)
            console.log("STEP 1 : GET Modelnames from JS " + relLongitude)
            World.objectsNames.push({ 'name': objectname, 'relativelat': relLatitude, 'relativelon': relLongitude }, )
        },
        //2: ------From Flutter to Wiki => Give information for models
        setStartCoordinates: async function setStartCoordinatesFn(lat, lon, alt, acc) {
            console.log("STEP 2 : SET StartCoordinates from JS")
            console.log("THE LOCATION IS GIVEN " + lat);
            console.log("THE LOCATION IS GIVEN " + lon);
            console.log("THE LOCATION IS GIVEN " + alt);
            World.startCoordinates = { 'lat': lat, "lon": lon, "alt": alt, "acc": acc }
            console.log("STEP 2 : SET WORLDStartCoordinates from JS: lat: " + World.startCoordinates.acc)

            if (World.startCoordinates != null) {
                console.log("START CREATING THE MODELS NOW => FUNCTION CALLED")
                World.startCreatingModels();
            }

        },



        //3: ------Create Models now the objectsnames are filled
        startCreatingModels: function startCreatingModels() {
            console.log("STEP 3 : CREATE Models")
                //loop over the objects given from the javascript call

            World.objectsNames.forEach(element => {
                World.createModel(element.name, element.relativelat, element.relativelon);
                console.log("----- WIKITUDE ----- made object  :" + element.name);
            })

        },
        //4: ------Start to receive the coordinates from the user per 2 sec
        locationChanged: function locationChanged(lat, lon, alt, acc) {
            World.coordinates.push({ 'lat': lat, "lon": lon, "alt": alt, "acc": acc });

            // if (World.coordinates.length == 1) {
            //     World.objectsNames.forEach(element => {
            //         World.createModel(element.name, element.relativelat, element.relativelon);
            //         console.log("----- WIKITUDE ----- made object  :" + element.name);
            //     })
        },



        createModel: function createModelFn(modelname, rel_latitide, rel_longitude) {
            console.log("STEP 5 : CREATE Model")
                //abosolute location for the object, taking relative placing in count
            var location = new AR.GeoLocation(
                // parseFloat(World.coordinates[0].lat + (rel_latitide / 10000)),
                // parseFloat(World.coordinates[0].lon + (rel_longitude / 10000)),
                // parseFloat(World.coordinates[0].alt)
                parseFloat(World.startCoordinates.lat + (rel_latitide / 10000)),
                parseFloat(World.startCoordinates.lon + (rel_longitude / 10000)),
                parseFloat(World.startCoordinates.alt),
                console.log(World.startCoordinates.lat)
            )


            /* Next the model object is loaded. */
            var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
                onError: World.onError,
                scale: {
                    x: 10,
                    y: 10
                },
                onClick: function() {
                    //   console.log('-------WIKITUDE: --------------------------------MODEL CLICKED' + modelname);
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


    };

    World.init();

    //if location change is called upon in flutter => alert wikitude
    AR.context.onLocationChanged = World.locationChanged;