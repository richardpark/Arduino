
 // Graphing sketch
 
 // By Richard Park
 
 import processing.serial.*;
 
 Serial myPort;        // The serial port
 
 int margin = 100;
 int xPos = margin;         
 int xInc = 20;
 int yInc = 20;
 int xMax = 200;
 int yMax = 1000;
 
 void setup () {
   // set the window size:
   size(1000, 800);        
   // Create a new file in the sketch directory
   //output = createWriter("positions.txt"); 
   // List all the available serial ports
   println(Serial.list());
   // I know that the first port in the serial list on my mac
   // is always my  Arduino, so I open Serial.list()[0].
   // Open whatever port is the one you're using.
   // myPort = new Serial(this, "/dev/ttyACM0", 9600);
   myPort = new Serial(this, Serial.list()[0], 9600);
   // don't generate a serialEvent() unless you get a newline character:
   myPort.bufferUntil('\n');
   // set inital background:
   background(191 , 239 , 255);
   
   
   rect(margin,margin,width - margin*2 ,height - margin*2 );
   
   
   
   for(int y = 0; y <= yInc; y++){
     line(margin - 10, margin + y*((height - margin*2)/yInc) , margin, margin + y*((height - margin*2)/yInc));
     textSize(10);
     fill(0);
     textAlign(CENTER,CENTER);
     text(yMax - (yMax/yInc)*y, margin - 25, margin + y*((height - margin*2)/yInc));
   }
   
   for(int x = 0; x <= xInc; x++){
     line( margin + x*(width - margin*2)/xInc , height - margin, margin + x*(width - margin*2)/xInc, height - margin +10 );
     textSize(10);
     fill(0);
     textAlign(CENTER,CENTER);
     text(0 + (xMax/xInc)*x, margin + x*(width - margin*2)/xInc , height - margin + 20);
   }
   


   
 }
 
 void draw () {
   // everything happens in the serialEvent()
 }
 
 void serialEvent (Serial myPort) {
   // get the ASCII string:
   String inString = myPort.readStringUntil('\n');
 
   if (inString != null) {
     // trim off any whitespace:
     inString = trim(inString);
     // convert to an int and map to the screen height:
     float inByte = float(inString); 
     inByte = map(inByte, 0, yMax, height - margin ,margin);
 
     // draw the line:
     stroke(0 , 139 , 69);
     ellipse(xPos, inByte, 1.5, 1.5);
 
     // at the edge of the screen, go back to the beginning:
       if (xPos >= width-margin) {
         xPos = margin;
         
         background(191 , 239 , 255);
         fill(255);
         rect(margin,margin,width - margin*2 ,height - margin*2 );
         
   
   for(int y = 0; y <= yInc; y++){
     line(margin - 10, margin + y*((height - margin*2)/yInc) , margin, margin + y*((height - margin*2)/yInc));
     textSize(10);
     fill(0);
     textAlign(CENTER,CENTER);
     text(yMax - (yMax/yInc)*y, margin - 25, margin + y*((height - margin*2)/yInc));
   }
   
   for(int x = 0; x <= xInc; x++){
     line( margin + x*(width - margin*2)/xInc , height - margin, margin + x*(width - margin*2)/xInc, height - margin +10 );
     textSize(10);
     fill(0);
     textAlign(CENTER,CENTER);
     text(0 + (xMax/xInc)*x, margin + x*(width - margin*2)/xInc , height - margin + 20);
   }
   
        
   

  
   
       }
     
     else {
       // increment the horizontal position:
       xPos++;
     }
   }
 }

