package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Helen
	 */
	public class Tools extends Sprite
	{
		private static var xcord:int;
		private static var ycord:int;
		private static var row:int;
		private static var index:int;
		
		public static function gridToCoord(row:int, index:int):Object {
			ycord = row * 35 + 20
			if (row % 2==0){
				xcord = index * 40 + 170
			}
			else {
				xcord = index *40 + 190
			}
			
			var point:Object = {x:xcord,y:ycord}
			
			return point
		}
	
		public static function randomInt(max:int):int {
			return Math.min(Math.max(Math.floor(Math.random() * max),0),max-1)
		}

		public static function getDistance(targetx:Number,targety:Number,fromx:Number=0,fromy:Number=0):Number{
			return Math.sqrt((targetx-fromx)*(targetx-fromx)+(targety-fromy)*(targety-fromy))
		}
	}

}