 var World = {

     //objectsnames => contained by API call
     objectsNames: [

     ],

     //startcoordinates => contained by API call
     startPosition: {},
     //Coordinates => push the user position coordinates
     // coordinates({lat, lon, alt, acc})
     coordinates: [],


     init: function initFn() {},


     //------From Flutter to Wiki => Give information for models
     //1. load the modelitems in wikitude
     getModelNames: function getModelNamesFn(objectname, relLatitude, relLongitude) {
         World.objectsNames.push({ 'name': objectname, 'relativelat': relLatitude, 'relativelon': relLongitude }, )
     },
     //2: ------From Flutter to Wiki => Give information for models
     setStartPosition: async function setStartPositionFn(lat, lon, alt, acc) {
         console.log("STEP 2 : SET StartCoordinates from JS")
         World.startPosition = { 'lat': lat, "lon": lon, "alt": alt, "acc": acc }
         console.log("STEP 2 : SET WORLDStartCoordinates from JS: lat: " + World.startPosition.acc)

         if (World.startPosition != null) {
             console.log("START CREATING THE MODELS NOW => FUNCTION CALLED")
             World.startCreatingModels()
         }

     },


     //3: ------Create Models now the objectsnames are filled
     startCreatingModels: function startCreatingModels() {
         console.log("STEP 3 : CREATE Models")
             //loop over the objects given from the javascript call

         World.objectsNames.forEach(element => {
             World.createModel(element.name, element.relativelat, element.relativelon);

         })
     },
     //4: ------Start to receive the coordinates from the user per 2 sec
     locationChanged: function locationChanged(lat, lon, alt, acc) {
         World.coordinates.push({ 'lat': lat, "lon": lon, "alt": alt, "acc": acc })

     },



     createModel: function createModelFn(modelname, rel_latitide, rel_longitude) {
         console.log("STEP 5 : CREATE Model");
         console.log("relative lat en long: " + rel_latitide + ", " + rel_longitude);
         console.log(modelname);
         console.log("Positie " + modelname + " is lat/long/alt SOM: " + parseFloat(World.startPosition.lat + (rel_latitide / 100)) + ", " + parseFloat(World.startPosition.lon + (rel_longitude / 100)));
         console.log("Positie " + modelname + " is lat/long/alt STA: " + parseFloat(World.startPosition.lat) + ", " + parseFloat(World.startPosition.lon));

         objectlatitude = parseFloat(World.startPosition.lat) + parseFloat(rel_latitide / 100);
         objectlongitude = parseFloat(World.startPosition.lon) + parseFloat(rel_longitude / 100);
         objectaltitude = parseFloat(World.startPosition.alt);
         console.log("Positie " + modelname + " is lat/long/alt STA: " + parseFloat(World.startPosition.lat) + ", " + parseFloat(World.startPosition.lon));

         //abosolute location for the object, taking relative placing in count
         var location = new AR.GeoLocation(
             objectlatitude, objectlongitude, objectaltitude
         );
         console.log("Positie " + modelname + " is lat/long/alt: " + parseFloat(World.startPosition.lat + (rel_latitide / 100)) + ", " + parseFloat(World.startPosition.lon + (rel_longitude / 100)), )
             /* Next the model object is loaded. */
         var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
             onError: World.onError,
             scale: {
                 x: 1,
                 y: 1
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