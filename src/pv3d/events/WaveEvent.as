package pv3d.events
{
	import flash.events.Event;
	
	import mx.core.mx_internal;
	
	public class WaveEvent extends Event
	{
		public static const CHANGE_MOV:String = "changeMov";
		public static const CHANGE_MOV_FINISH:String = "changeMovFinish";
		public static const HIDDING:String = "hidding";
		public static const HIDDING_FINISH:String = "hiddingFinish";
		
		public var currentMovType:String;
		public var toMovType:String = "NONE";
		public var fromMovType:String = "NONE";
		public var waveHidden:Boolean;
		public var waveType:String;
		
		public function WaveEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var eventObj:WaveEvent = new WaveEvent(type, bubbles, cancelable);
			
			eventObj.currentMovType = this.currentMovType;
			eventObj.toMovType = this.toMovType;
			eventObj.fromMovType = this.fromMovType;
			eventObj.waveHidden = this.waveHidden;
			eventObj.waveType = this.waveType;
			
			return eventObj;
		}
	}
}