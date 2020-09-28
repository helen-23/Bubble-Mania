package  {
	/**
	 * ...
	 * @author Helen
	 */
	
	 import adobe.utils.CustomActions;
	 import flash.display.Bitmap;
	 import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import Arrow;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import Input;
	import flash.events.TimerEvent;
	
	public class BubbleManiaGame extends Sprite

	{	
		//game screen
		public var array:Array
		
		//arrow
		public var arrow:Arrow;                           //arrow
		public var arrowAngle:Number;                     //angle of arrow
		public var random:uint;                           //random integer passed in as parameter(for color)
		
		//randomBubble
		public var randomBubble:Bubble;                   //new bubble made at the bottom
		public var shootState:int;                        //state of bubble (0 = at rest, 1 = moving)
		public const snapRange:Number = 40;               //range in order to snap bubble
		public const startPosX:Number = 350;              //start x-position of randomBubble
		public const startPosY:Number = 550;              //start y-position of randomBubble
		public var speed:Number = 20;                     //velocity of bubble when moving
		public var shootAngle:Number                      //the angle it is shooting in
		public var velocityX:Number                       //change in x
		public var velocityY:Number                       //change in y
		
		public var mainScreen:Screens;                    //the screen that shows up
		public var count:Boolean = true;                  //whether to make new game
		public var timer:Timer;                           //timer
		public var clock:int;                             //clock number that shows up
		public var myText:TextField = new TextField();            //time counter printed
		public var myFormat:TextFormat = new TextFormat();
		public var myText2:TextField = new TextField();           //score during game printed
		public var myFormat2:TextFormat = new TextFormat();
		public var myText3:TextField = new TextField();           //final score printed
		public var myFormat3:TextFormat = new TextFormat();
		public var score:int = 0;                                 //score counter
		public var scoreKeeper:int;                               //final score keeper
		public var theme:int = 4;                        		  //indicator for the different themes
		public var pause:int = 0;                                 //whether or not the game is paused
		
		public var startShoot:Boolean = true;                     //whether or not to activate shootbubble
		
		public function BubbleManiaGame() {
			shootState = 0;                                       //bubble is not moving
			
			array = [];                                           //indices for entire game screen(15x10)
			for (var h:uint = 0; h < 15; h++) {
				array.push([null, null, null, null, null, null, null, null, null, null])	
			}
					
			arrow = new Arrow();                                  //arrow on screen
			addChild(arrow);
			arrow.x = startPosX
			arrow.y = startPosY
			
			mainScreen = new Screens();                           //add screen
			addChild(mainScreen);
			mainScreen.screenState = 0                            //add main screen
			mainScreen.x = 350;
			mainScreen.y = 300;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
		}
		
		public function game():void {                               //function for making new game
			for (var i:uint = 0; i < 5; i++) {
				var m:Number = i % 2 == 0 ? 10 : 9;
				for (var j:uint = 0; j < m; j++ ) {
					var num:int = Tools.randomInt(5)+1;
					array[i][j] = makeBubble(num);
					array[i][j].x = Tools.gridToCoord(i, j).x;
					array[i][j].y = Tools.gridToCoord(i, j).y;
				}
			}	
			
			randomBubble = makeBubble();                           //make a random bubble at bottom
			randomBubble.x = startPosX;
			randomBubble.y = startPosY;
		}
		
		public function timerListener(e:TimerEvent):int {           //function for timer
			clock--
			myFormat.size = 20;
			myText.defaultTextFormat = myFormat;
			myText.text = "" + clock;
			addChild(myText);
			myText.width = 150;
			myText.height = 50;
			myText.x = 50;
			myText.y = 125;
			myText.textColor = 0x000000
			
			if (clock <= 0){
				for (var u:int = 0; u < 15; u++) {
						var f:int = u % 2 == 0 ? 10 : 9;
						for (var t:int = 0; t < f; t++) {
							if (array[u][t] != null){
								array[u][t].destroy()
								array[u][t] = null
							}
						}
					}
				mainScreen.screenState = 2                                 //screen switch to score screen
				randomBubble.destroy();
				removeChild(myText)
				removeChild(myText2)
				removeChild(myText3)
				timer.removeEventListener(TimerEvent.TIMER, timerListener)
			}
			return clock
		}
		
		public function makeBubble(color:int=-1):Bubble{	        // function for making single bubbles
			var random:int;
			var newBubble:Bubble;
			if (color != -1) {
				random = color
			}
			else {
				random = Tools.randomInt(5)+1
			}
			newBubble = new Bubble(random);
			addChild(newBubble);
			return newBubble;
		}
		
		public function effect (x:Number, y:Number, color:int, state:int):void {       //function for popping and droping effects
			var bubble:Bubble = makeBubble(color);
			bubble.x = x
			bubble.y = y
			bubble.dropState = state
		}
		
		public function dropBubble():void {                    //function for determining when to drop bubble
			var queue:Array = []
			for (var z:int = 0; z < 10; z++) {
				if (array[0][z] != null){
					array[0][z].checked = true;
					queue.push([0, z]);
				}
			}
			var m:int;
			var n:int;
			var o:int;
			while (queue.length != 0) {
				m = queue[0][0]
				n = queue[0][1]
				o = m % 2 == 0 ? n - 1 : n + 1;
				if (array[m][n-1] != null && array[m][n-1].checked == false) {
					queue.push([m, n - 1]);
					array[m][n - 1].checked = true
				}
				if (array[m][n+1] != null && array[m][n+1].checked == false) {
					queue.push([m, n + 1]);
					array[m][n + 1].checked = true
				}
				if (m > 0 && array[m-1][n] != null && array[m-1][n].checked == false) {
					queue.push([m-1, n]);
					array[m - 1][n].checked = true
				}
				if (m > 0 && array[m-1][o] != null && array[m-1][o].checked == false) {
					queue.push([m-1, o]);
					array[m - 1][o].checked = true
				}
				if (m<14 && array[m+1][n] != null && array[m+1][n].checked == false) {
					queue.push([m+1, n]);
					array[m + 1][n].checked = true
				}
				if (m<14 && array[m+1][o] != null && array[m+1][o].checked == false) {
					queue.push([m+1, o]);
					array[m + 1][o].checked = true
				}
				queue.splice(0, 1);	
			}
			var i:int = 0;
			var j:int = 0;
			for (i = 0; i < 15; i++) {
				m = i % 2 == 0 ? 10 : 9;
				for (j = 0; j < m; j++ ) {
					if (array[i][j] != null && array[i][j].checked == false) {
						effect(array[i][j].x,array[i][j].y,array[i][j].color,1)
						array[i][j].destroy();
						array[i][j] = null;
						score ++
					}
					else if (array[i][j] != null){
						array[i][j].checked = false;
					}
				}
			}
		}
		
		public function popBubble(row:int, index:int):void {   //function for determining when to pop bubble
			var queue:Array = [[row,index]]
			array[row][index].visited = true
			var color:int = array[row][index].color
			var check:int = 1
			var m:int;
			var n:int;
			var o:int;
			while (queue.length != 0) {
				m = queue[0][0]
				n = queue[0][1]
				o = m % 2 == 0 ? n - 1 : n + 1;
				if (array[m][n-1] != null && array[m][n-1].visited == false && array[m][n-1].color == color) {
					queue.push([m, n - 1]);
					array[m][n - 1].visited = true
					check++;
				}
				if (array[m][n+1] != null && array[m][n+1].visited == false && array[m][n+1].color == color) {
					queue.push([m, n + 1]);
					array[m][n + 1].visited = true
					check++;
				}
				if (m > 0 && array[m-1][n] != null && array[m-1][n].visited == false && array[m-1][n].color == color) {
					queue.push([m-1, n]);
					array[m - 1][n].visited = true
					check++;
				}
				if (m > 0 && array[m-1][o] != null && array[m-1][o].visited == false && array[m-1][o].color == color) {
					queue.push([m-1, o]);
					array[m - 1][o].visited = true
					check++;
				}
				if (m<14 && array[m+1][n] != null && array[m+1][n].visited == false && array[m+1][n].color == color) {
					queue.push([m+1, n]);
					array[m + 1][n].visited = true
					check++
				}
				if (m<14 && array[m+1][o] != null && array[m+1][o].visited == false && array[m+1][o].color == color) {
					queue.push([m+1, o]);
					array[m + 1][o].visited = true
					check++;
				}
				queue.splice(0, 1);
			}
			var i:int = 0;
			var j:int = 0;
			if (check >= 3) {
				for (i = 0; i < 15; i++) {
					m = i % 2 == 0 ? 10 : 9;
					for (j = 0; j < m; j++ ) {
						if (array[i][j] != null && array[i][j].visited == true) {
							effect(array[i][j].x,array[i][j].y,array[i][j].color,2)
							array[i][j].destroy();
							array[i][j] = null;
							score ++
						}
					}
				}
			}
			else {
				for (i = 0; i < 15; i++) {
					m = i % 2 == 0 ? 10 : 9;
					for (j = 0; j < m; j++ ) {
						if (array[i][j] != null && array[i][j].visited == true) {
							array[i][j].visited = false
						}
					}
				}
			}
			
		}
		
		public function resetBubble():void {                //function for destroying bubbles when game over
			for (var w:int = 0; w < 10; w++) {
				if (array[14][w] != null) {
					for (var u:int = 0; u < 15; u++) {
						var f:int = u % 2 == 0 ? 10 : 9;
						for (var t:int = 0; t < f; t++) {
							if (array[u][t] != null){
								array[u][t].destroy()
								array[u][t] = null
							}
						}
					}
					mainScreen.screenState = 2
					count = true
					randomBubble.destroy();
					removeChild(myText)
					timer.removeEventListener(TimerEvent.TIMER, timerListener)
					removeChild(myText2)
				}
			}
		}
		
		public function checkForWin():void {                //function to check for win
			var countA:int = 0
			if (mainScreen.screenState == 4 || mainScreen.screenState == 5 || mainScreen.screenState == 6) {
				for (var u:int = 0; u < 10; u++) {
					if (array[0][u] == null){
						countA++
					}
				}
				if (countA >= 10) {
					mainScreen.screenState = 8
					randomBubble.destroy()
					removeChild(myText)
					removeChild(myText2)
				}
			}
		}
		
		public function shootBubble():void {                //function for shooting and snaping bubbles
			if (startShoot == true){
				arrowAngle = Math.atan2(stage.mouseY - arrow.y, stage.mouseX - arrow.x);
				arrowAngle = Math.min(Math.max(arrowAngle,-3),-0.14)
				arrow.rotation = arrowAngle / Math.PI * 180 + 90;
			}
			
			myFormat2.size = 50;
			myText2.defaultTextFormat = myFormat2;
			myText2.text = "" + score;
			addChild(myText2);
			myText2.width = 100;
			myText2.height = 100;
			myText2.x = 580;
			myText2.y = 450;
			myText2.textColor = 0x000000
			
			scoreKeeper = score
			
			if (Input.mouse_Clicked && mouseX >= 150 && mouseX <= 550 && shootState == 0 && startShoot == true) {
				shootState = 1;
				shootAngle = arrowAngle + Math.PI / 2;
				velocityX = Math.sin(shootAngle) * speed
				velocityY = Math.cos(shootAngle) * speed
			}
			if (shootState == 1) {
				randomBubble.x += velocityX
				randomBubble.y -= velocityY
				if (randomBubble.x <= 170) {
					randomBubble.x = 170;
					velocityX *= -1;
				}
				else if (randomBubble.x >= 530){
					randomBubble.x = 530;
					velocityX *= -1;
				}
				
				var coord:Object;
				var p:int = 0;
				var q:int = 0;
				for (var m:uint = 0; m < 15; m++) {    // different combinations for snaping bubble
					var o:int = m % 2 == 0 ? 10 : 9;
					for (var n:uint = 0; n < o; n++ ) {
						if (array[m][n] == null) {
							p = 0;
							q = 0;
							if (array[m][n - 1] != null) {
								p++;
							}
							if (array[m][n + 1] != null) {
								p++;
							}
							if (m > 0 && array[m - 1][n] != null) {
								p++;
								q++;
							}
							if (m > 0 && array[m - 1][m % 2 == 0 ? n - 1 : n + 1] != null) {
								p++;
								q++;
							}
							if (m % 2 == 0 && (n == 0 || n == 9)) {
								p++;
							}
							if ((p >= 2 && q > 0) || m == 0) {  //if these combinations are met, snap, pop, and drop
								coord = Tools.gridToCoord(m,n)
								if(Tools.getDistance(coord.x, coord.y, randomBubble.x, randomBubble.y) <= snapRange){
									shootState = 0;
									randomBubble.x = coord.x
									randomBubble.y = coord.y
									array[m][n] = makeBubble(randomBubble.color);
									array[m][n].x = randomBubble.x;
									array[m][n].y = randomBubble.y;
									popBubble(m, n);
									dropBubble();
									randomBubble.setColor();
									randomBubble.x = startPosX;
									randomBubble.y = startPosY;
									break;
								}
							}
						}
					}
				}
			}
		}
		
		private function onAddedToStage(event:*):void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:*):void {
			resetBubble();
			
			if (mainScreen.screenState == 0 && Input.mouse_Clicked) {
				if (mouseX >= 503 && mouseX <= 600 && mouseY >= 402 && mouseY <= 600) { // play button pressed:play
					mainScreen.screenState = theme
					count = true
				}
				if (mouseX >= 319 && mouseX <= 465 && mouseY >= 428 && mouseY <= 576) {  //instructions pressed
					mainScreen.screenState = 1
				}
				if (mouseX >= 414 && mouseX <= 541 && mouseY >= 303 && mouseY <= 414) {  // theme pressed
					mainScreen.screenState = 7
				}
			}
			
			if (mainScreen.screenState == 7 && Input.mouse_Clicked) {
				if (mouseX >= 64 && mouseX <= 221 && mouseY >= 236 && mouseY <= 357) {  //theme 1
					theme = 4
					mainScreen.screenState = 0
				}
				if (mouseX >= 270 && mouseX <= 428 && mouseY >= 236 && mouseY <= 357) {  //theme 2
					theme = 5
					mainScreen.screenState = 0
				}
				if (mouseX >= 477 && mouseX <= 634 && mouseY >= 236 && mouseY <= 357) {  //theme 3
					theme = 6
					mainScreen.screenState = 0
				}
			}
			
			if (mainScreen.screenState == 1 && Input.mouse_Clicked && mouseX >= 41 && mouseX <= 137 && mouseY >= 465 && mouseY <= 559) {  //back pressed
				mainScreen.screenState = 0
			}
			
			if (mainScreen.screenState == 2 && Input.mouse_Clicked) {
				 if (mouseX >= 433 && mouseX <= 690 && mouseY >= 20 && mouseY <= 260) {  // back to main menu
					mainScreen.screenState = 0
					removeChild(myText3)
				 }
				 else if (mouseX >= 414 && mouseX <= 688 && mouseY >= 293 && mouseY <= 571) {  // play again
					mainScreen.screenState = theme;
					removeChild(myText3)
					count = true
				 }
			}
			
			if (mainScreen.screenState == 8 && Input.mouse_Clicked) {
				if (mouseX >= 110 && mouseX <= 300 && mouseY >= 340 && mouseY <= 426) {  // back to main menu
					mainScreen.screenState = theme;
					count = true
				 }
				else if (mouseX >= 369 && mouseX <= 578 && mouseY >= 339 && mouseY <= 421) {  // play again
					mainScreen.screenState = 0
				 }
				 timer.addEventListener(TimerEvent.TIMER,timerListener)
			}
			
			if (mainScreen.screenState == 4 || mainScreen.screenState == 5 || mainScreen.screenState == 6){
				if (count == true){
					score = 0
					game()
					
					clock = 120
					timer = new Timer(1000, 120)
					timer.addEventListener(TimerEvent.TIMER, timerListener)
					timer.start()
					
					count = false
				}
				
				shootBubble()
				
				
				if (Input.mouse_Clicked && mouseX >= 22 && mouseX <= 100 && mouseY >= 485 && mouseY <= 563) { // if back pressed
					for (var u:int = 0; u < 15; u++) {
						var f:int = u % 2 == 0 ? 10 : 9;
						for (var t:int = 0; t < f; t++) {
							if (array[u][t] != null){
								array[u][t].destroy()
								array[u][t] = null
							}
						}
					}
					mainScreen.screenState = 0
					count = true
					randomBubble.destroy();
					removeChild(myText)
					timer.removeEventListener(TimerEvent.TIMER, timerListener)
					removeChild(myText2)
				}
				
				if (Input.mouse_Clicked && mouseX >= 22 && mouseX <= 100 && mouseY >= 368 && mouseY <= 446) { // pause button clicked
					if (pause % 2 == 0) {
						timer.stop();
						startShoot = false
					}
					else {
						timer.start();
						startShoot = true
					}
					pause++
				}
			}
			
			if (mainScreen.screenState == 2) {
				myFormat3.size = 150;
				myText3.defaultTextFormat = myFormat3;
				myText3.text = "" + scoreKeeper;
				addChild(myText3);
				myText3.width = 500;
				myText3.height = 500;
				myText3.x =170;
				myText3.y =295;
				myText3.textColor = 0xFFFFFF
			}
			
		checkForWin();
			
		}
	}
}
