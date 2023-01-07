package topics.events
{	
	import flash.events.Event;
	
	public class TopicEvent extends Event
	{
		public static const TOPIC_CLICK:String = "topicClick";
		
		public static const SHOW_CONTENT:String = "showContent";
		public static const SHOW_CONTENT_COMPLETE:String = "showContentComplete";
		public static const HIDE_CONTENT:String = "hideContent";
		public static const HIDE_CONTENT_COMPLETE:String = "hideContentComplete";
		
		public static const SHOW_TOPICS:String = "showTopics";
		public static const SHOW_TOPICS_COMPLETE:String = "showTopicsComplete";
		public static const HIDE_TOPICS:String = "hideTopics";
		public static const HIDE_TOPICS_COMPLETE:String = "hideTopicsComplete";
		
		public var topicTitle:String = "";
		public var topicCharacter:String = "";
		
		public function TopicEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var eventObj:TopicEvent = new TopicEvent(type,bubbles,cancelable);
			eventObj.topicTitle = this.topicTitle;
			eventObj.topicCharacter = this.topicCharacter;
			
			return eventObj;
		}
	}
}