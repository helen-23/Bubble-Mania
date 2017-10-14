package  {
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class Input extends MovieClip {

		private var _key:Array;
		public var key:Object;
		private var held:Boolean;
		public static var current:Object;
		public static var mouse_Down:Boolean;
		public static var mouse_Clicked:Boolean;
		public function Input() {
			current = this;
			mouse_Down = false;
			mouse_Clicked = false;
			held = false;
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:*):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			stage.addEventListener(MouseEvent.MOUSE_UP,_mouse_isUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,_mouse_isDown);
			addEventListener(Event.ENTER_FRAME,onEnterFrame);
		}

		private	function onEnterFrame(event:*):void{
			mouse_Clicked = false;
			if (mouse_Down == false && held){
				mouse_Clicked = true;
			}
			held = mouse_Down;
		}

		private function _mouse_isUp(event:MouseEvent):void {
			mouse_Down = false
		}

		private function _mouse_isDown(event:MouseEvent):void {
			mouse_Down = true
		}


	}
	
}
