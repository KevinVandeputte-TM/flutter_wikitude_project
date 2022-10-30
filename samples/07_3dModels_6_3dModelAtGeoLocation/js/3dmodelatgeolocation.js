var World = {

    init: function initFn() {
        //this.createModelAtLocation();
    },

    locationChanged: function locationChanged(lat, lon, alt, acc){
        console.log("----- WIKITUDE - LOCATION RECIEVED -------");
        console.log("USER LOCATION: " + lat + ' ' + lon + ' ' + alt + acc);
    },

    createModelAtLocation: function createModelAtLocationFn() {

        /*
            First a location where the model should be displayed will be defined. This location will be relativ to
            the user.
        */
        var location = new AR.RelativeLocation(null, 5, 0, 2);
        console.log("--------------------------ran")
            /* Next the model object is loaded. */
        var modelEarth = new AR.Model("assets/models/earth.wt3", {
            onError: World.onError,
            scale: {
                x: 1,
                y: 1,
                z: 1
            },
            rotate: {
                x: 180,
                y: 180
            },
            onClick: function() {
                console.log('--------------------------------MODEL CLICKED');
            }
        });

        var indicatorImage = new AR.ImageResource("assets/models/indi.png", {
            onError: World.onError
        });

        var indicatorDrawable = new AR.ImageDrawable(indicatorImage, 0.1, {
            verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP
        });

        /* Putting it all together the location and 3D model is added to an AR.GeoObject. */
        this.geoObject = new AR.GeoObject(location, {
            drawables: {
                cam: [modelEarth],
                indicator: [indicatorDrawable]
            }
        });
    },

    onError: function onErrorFn(error) {
        alert(error);
    }
};

World.init();

AR.context.onLocationChanged = World.locationChanged;