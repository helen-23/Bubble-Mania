package 
{
	import flash.display.Sprite;
	import BubbleManiaGame;
	import flash.events.Event;
	import Input;
	/**
	 * ...
	 * @author Helen
	 */
	 
	public class Main extends Sprite 
	{
		public var game:BubbleManiaGame;
		public var _input:Input;
		//public var background:Screens;
		
		
		public function Main():void 
		{
			/*background = new Screens();
			addChild(background);
			background.x = 350;
			background.y = 300;*/
			
			game = new BubbleManiaGame();
			addChild(game);
			game.x = 0;
			game.y = 0;
			
			_input = new Input();
			addChild(_input);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:*):void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event:*):void {
			
		}
		
	}
	
}