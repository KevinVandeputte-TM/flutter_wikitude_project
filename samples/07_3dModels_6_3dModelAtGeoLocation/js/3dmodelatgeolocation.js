    // coordinates({lat, lon, alt, acc})

    var coordinates = [];

    var World = {

        objectsNames: [
            { 'name': 'earth', 'relativelat': 1, 'relativelon': 1, 'relativeacc': 1 },
            { 'name': 'earth', 'relativelat': -1, 'relativelon': -1, 'relativeacc': 1 }
        ],


        init: function initFn() {
            console.log("----- WIKITUDE ----- INIT  ");
            //    const myTimeout = setTimeout(

            console.log("----- WIKITUDE ----- END INIT ");

        },




        locationChanged: function locationChanged(lat, lon, alt, acc) {
            console.log("----- WIKITUDE locationChanged USER LOCATION: " + lat + ' ' + lon + ' ' + alt + acc);
            // coordinates.push({ lat, lon, alt, acc })
            coordinates.push({ 'lat': lat, "lon": lon, "acc": acc })
            console.log("----- WIKITUDE locationChanged  added values in coordinates array " + coordinates[coordinates.length - 1].lat)

            if (coordinates.length == 1) {
                console.log("----- WIKITUDE CREATE MODELS")
                console.log(World.objectsNames)
                World.objectsNames.forEach(element => {
                        World.createModelAtLocation(element.name, element.relativelat, element.relativelon, element.relativeacc);
                        console.log("----- WIKITUDE ----- made object  " + element.name);
                    })
                    //, 5000);

            }
        },

        createModelAtLocation: function createModelAtLocationFn(modelname, rel_latitide, rel_longitude) {
            console.log('-------WIKITUDE: CreateModel')

            // var location = new AR.RelativeLocation(null, northing, easting, altitudedelta);


            // //plaatsen tov absolute waardes bij opstart spel

            var location = new AR.GeoLocation(
                parseFloat(coordinates[0].lat + (rel_latitide / 10000)), // about 1 meter easting
                parseFloat(coordinates[0].lon + (rel_longitude / 10000)), //about 2 meter northing.
                1 //altitude
            );



            console.log("-------WIKITUDE: --------------------------ran createModel, ")
                /* Next the model object is loaded. */
            var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
                onError: World.onError,
                scale: {
                    x: 10,
                    y: 10,
                    z: 10
                },
                rotate: {
                    x: 180,
                    y: 180
                },
                onClick: function() {
                    console.log('-------WIKITUDE: --------------------------------MODEL CLICKED' + modelname);
                    AR.platform.sendJSONObject({
                        "modelname": modelname
                    });
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
                drawables: {
                    cam: [modelEarth],
                    // indicator: [indicatorDrawable]
                }
            });
        },

        onError: function onErrorFn(error) {
            alert(error);
        }
    };

    World.init();

    AR.context.onLocationChanged = World.locationChanged;