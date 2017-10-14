package  
{
	import flash.display.Bitmap;
	 import Assets;
	 import flash.display.Sprite;
	 import flash.events.Event;
	 import Tools;
	 
	public class Bubble extends Sprite
	{
		public var image1:Bitmap;
		public var image2:Bitmap;
		public var image3:Bitmap;
		public var image4:Bitmap;
		public var image5:Bitmap;
		public var color:int;
		public var visited:Boolean;
		public var checked:Boolean;
		
		public var dropState:int;
		
		public function Bubble(a)
		{
			color = a;
			visited = false;
			checked = false;
			dropState = 0;
			
			image1 = new Assets.blueBubble();
			image1.x = -image1.width / 2;
			image1.y = -image1.height / 2;
			image2 = new Assets.cyanBubble();
			image2.x = -image2.width / 2;
			image2.y = -image2.height / 2;
			image3 = new Assets.redBubble();
			image3.x = -image3.width / 2;
			image3.y = -image3.height / 2;
			image4 = new Assets.yellowBubble();
			image4.x = -image4.width / 2;
			image4.y = -image4.height / 2;
			image5 = new Assets.whiteBubble();
			image5.x = -image5.width / 2;
			image5.y = -image5.height / 2;
			
			image1.visible = false
			image2.visible = false
			image3.visible = false
			image4.visible = false
			image5.visible = false
			
			this["image" + a].visible = true;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage(event:*):void {
			addChild(image1);
			addChild(image2);
			addChild(image3);
			addChild(image4);
			addChild(image5);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:*):void {
			if (dropState == 1) {
				this.y += 8;
				if (this.y > 620) {
					this.destroy();
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
			if (dropState == 2) {
				this.scaleX += 0.5;
				this.scaleY += 0.5;
				this.alpha -= 0.2;
				if (this.alpha <=0) {
					this.destroy();
					this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				}
			}
		}
		
		public function setColor(xcolor:int=-1):void {
			var random:int;
			if (xcolor != -1) {
				random = xcolor
			}
			else {
				random = Tools.randomInt(5)+1
			}
			color = random;
			image1.visible = false
			image2.visible = false
			image3.visible = false
			image4.visible = false
			image5.visible = false
			
			this["image" + random].visible = true;
		}
		
		public function destroy():void {
			parent.removeChild(this);
		}
	}

}