package pv3d.events
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.papervision3d.core.render.data.RenderHitData;
	import org.papervision3d.objects.DisplayObject3D;
	
	public class CubeEvent extends Event
	{
		public static const CUBE_MOVE:String = "cubeMove";
		public static const CUBE_OUT:String = "cubeOut";
		public static const CUBE_OVER:String = "cubeOver"; 
		public static const CUBE_PRESS:String = "cubePress";
		public static const CUBE_REALESE:String = "cubeRelease"; 
		public static const CUBE_CLICK:String = "cubeClick";
		
		public var displayObject3D				:DisplayObject3D = null;
		public var sprite						:Sprite = null;
		public var face3D						:String = null;
		public var x							:Number = 0;
		public var y							:Number = 0;
		public var renderHitData				:RenderHitData;
		
		public var faceLabel:DisplayObject;
				
		public function CubeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var event:CubeEvent = new CubeEvent(type, bubbles, cancelable);
			event.face3D = this.face3D;
			event.faceLabel = this.faceLabel;
			return event;
		}
	}
}