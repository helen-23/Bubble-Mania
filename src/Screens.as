package  
{
	/**
	 * ...
	 * @author Helen
	 */
	 import flash.display.Bitmap;
	 import Assets;
	 import flash.display.Sprite;
	 import flash.events.Event;
	 import Tools;
	 import Input;
	 
	public class Screens extends Sprite
	{
		public var imageA:Bitmap;
		public var imageB:Bitmap;
		public var imageC:Bitmap;
		public var imageD:Bitmap;
		public var imageE:Bitmap;
		public var imageF:Bitmap;
		public var imageG:Bitmap;
		public var imageH:Bitmap;
		public var imageI:Bitmap;
		public var screenState:int;
		//a:String = ""
		
		public function Screens() 
		{
			screenState = 0
			
			imageA = new Assets.mainManu;
			imageA.x = -imageA.width / 2;
			imageA.y = -imageA.height / 2;
			imageB = new Assets.how;
			imageB.x = -imageB.width / 2;
			imageB.y = -imageB.height / 2;
			imageC = new Assets.result;
			imageC.x = -imageC.width / 2;
			imageC.y = -imageC.height / 2;
			imageD = new Assets.gameOver;
			imageD.x = -imageD.width / 2;
			imageD.y = -imageD.height / 2;
			imageE = new Assets.theme1;
			imageE.x = -imageE.width / 2;
			imageE.y = -imageE.height / 2;
			imageF = new Assets.theme2;
			imageF.x = -imageF.width / 2;
			imageF.y = -imageF.height / 2;
			imageG = new Assets.theme3;
			imageG.x = -imageG.width / 2;
			imageG.y = -imageG.height / 2;
			imageH = new Assets.chooseTheme;
			imageH.x = -imageH.width / 2;
			imageH.y = -imageH.height / 2;
			imageI = new Assets.congrats;
			imageI.x = -imageI.width / 2;
			imageI.y = -imageI.height / 2;

			imageA.visible = false
			imageB.visible = false
			imageC.visible = false
			imageD.visible = false
			imageE.visible = false
			imageF.visible = false
			imageG.visible = false
			imageH.visible = false
			imageI.visible = false

			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:*):void {
			addChild(imageA);
			addChild(imageB);
			addChild(imageC);
			addChild(imageD);
			addChild(imageE);
			addChild(imageF);
			addChild(imageG);
			addChild(imageH);
			addChild(imageI);
			addEventListener(Event.ENTER_FRAME, onEnterFrame)
		}
		
		private function onEnterFrame(event:*):void {
			if (screenState == 0) {
				imageA.visible = true
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 1) {
				imageB.visible = true
				imageA.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 2) {
				imageC.visible = true
				imageA.visible = false
				imageB.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 3) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = true
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 4) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = true
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 5) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = true
				imageG.visible = false
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 6) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = true
				imageH.visible = false
				imageI.visible = false
			}
			else if (screenState == 7) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = true
				imageI.visible = false
			}
			else if (screenState == 8) {
				imageA.visible = false
				imageB.visible = false
				imageC.visible = false
				imageD.visible = false
				imageE.visible = false
				imageF.visible = false
				imageG.visible = false
				imageH.visible = false
				imageI.visible = true
			}
		}
	}

}