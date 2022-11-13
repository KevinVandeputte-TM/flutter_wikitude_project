 var World = {
     isHomeClicked: false,

     isHomeClickedFn: function isHomeClickedFn(value) {
         World.isHomeClicked = value;
     },

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
         World.startPosition = { 'lat': lat, "lon": lon, "alt": alt, "acc": acc }

         if (World.startPosition != null) {

             World.startCreatingModels()
         }

     },


     //3: ------Create Models now the objectsnames are filled
     startCreatingModels: function startCreatingModels() {

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


         objectlatitude = parseFloat(World.startPosition.lat) + parseFloat(rel_latitide / 10000);
         objectlongitude = parseFloat(World.startPosition.lon) + parseFloat(rel_longitude / 10000);
         objectaltitude = parseFloat(World.startPosition.alt);

         //abosolute location for the object, taking relative placing in count
         var location = new AR.GeoLocation(
             objectlatitude, objectlongitude, objectaltitude
         );
         /* Next the model object is loaded. */
         var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
             onError: World.onError,
             scale: {
                 x: 1,
                 y: 1
             },
             onClick: function() {
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