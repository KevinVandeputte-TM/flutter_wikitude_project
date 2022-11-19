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
         //  console.log("Positie " + modelname + " is lat/long/alt: " + parseFloat(World.startPosition.lat + (rel_latitide / 100)) + ", " + parseFloat(World.startPosition.lon + (rel_longitude / 100)), )
         /* Next the model object is loaded. */
         var modelEarth = new AR.Model("assets/models/" + modelname + ".wt3", {
             onError: World.onError,
             scale: {
                 x: 1,
                 y: 1
             },
             rotate: {
                 z: 0,
                 z: 0
             },
             onClick: function() {
                 AR.platform.sendJSONObject({
                     "modelname": modelname
                 });
             }
         });

         /*
             As a next step, an appearing animation is created. For more information have a closer look at the function
             implementation.
         */
         //      this.appearingAnimation = this.createAppearingAnimation(this.modelEarth, 0.045);

         /*
             The rotation animation for the 3D model is created by defining an AR.PropertyAnimation for the rotate.roll
             property.
         */
         this.rotationAnimation = new AR.PropertyAnimation(modelEarth, "rotate.y", -25, 335, 10000);


         /* Putting it all together the location and 3D model is added to an AR.GeoObject. */
         this.geoObject = new AR.GeoObject(location, {
             onError: World.onError,
             drawables: {
                 cam: [modelEarth],
             },
             //    onEnterFieldOfVision: this.appear
         });
         /*
                  createAppearingAnimation: function createAppearingAnimationFn(model, scale) {
                      /*
                          The animation scales up the 3D model once the target is inside the field of vision. Creating an
                          animation on a single property of an object is done using an AR.PropertyAnimation. Since the car model
                          needs to be scaled up on all three axis, three animations are needed. These animations are grouped
                          together utilizing an AR.AnimationGroup that allows them to play them in parallel.
                          Each AR.PropertyAnimation targets one of the three axis and scales the model from 0 to the value passed
                          in the scale variable. An easing curve is used to create a more dynamic effect of the animation.
                 
                      var sx = new AR.PropertyAnimation(model, "scale.x", 0, scale, 1500, {
                          type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC
                      });
                      var sy = new AR.PropertyAnimation(model, "scale.y", 0, scale, 1500, {
                          type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC
                      });
                      var sz = new AR.PropertyAnimation(model, "scale.z", 0, scale, 1500, {
                          type: AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC
                      });

                      return new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [sx, sy, sz]);
                  }
               /*   appear: function appearFn() {

                      /* Resets the properties to the initial values. 
                      World.appearingAnimation.start();
                  }

                  resetModel: function resetModelFn() {
                      World.rotationAnimation.stop();
                      World.rotating = false;
                      World.modelCar.rotate.z = -25;
                  }
         */
         World.rotationAnimation.start(-1);


     },
     onError: function onErrorFn(error) {
         alert(error);
     },



 };

 World.init();

 //if location change is called upon in flutter => alert wikitude
 AR.context.onLocationChanged = World.locationChanged;