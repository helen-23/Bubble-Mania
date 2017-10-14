package  
{
	import flash.display.Bitmap;
	 import Assets;
	 import flash.display.Sprite;
	 import flash.events.Event;
	 
	public class Arrow extends Sprite
	{
		public var image:Bitmap;
		
		public function Arrow() 
		{
			image = new Assets.arrow();
			image.scaleX = 0.1
			image.scaleY = 0.2
			image.x = -image.width / 2;
			image.y = -image.height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:*):void {
			addChild(image);
		}
		
	}

}