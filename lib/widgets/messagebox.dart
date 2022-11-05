import 'package:flutter/material.dart';

class MessageBoxWidget{
  final String message;
  final String type;

  const MessageBoxWidget ({required BuildContext context,required this.message, required this.type});

  static show(
    BuildContext context,
    String message, String type,
  ) {
    if (type =="error"){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 70,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(207, 75, 58, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Oh snap!",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ), 
              ),
              const Positioned(
                bottom: 15,
                left: 10,
                child: 
                  Image(
                    image: AssetImage("assets/icons/error.png"),
                    height: 40,
                    width: 40,
                  ),
              ),
            ],
          ),
        ),
      );
    } else if(type == "success"){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 70,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(156, 196, 178, 1),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 50),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Well done!",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ), 
              ),
              const Positioned(
                bottom: 15,
                left: 10,
                child: 
                  Image(
                    image: AssetImage("assets/icons/success.png"),
                    height: 40,
                    width: 40,
                  ),
              ),
            ],
          ),
        ),
      );


    }
  }
  
}