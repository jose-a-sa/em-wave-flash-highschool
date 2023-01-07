package components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.Accordion;
	import mx.core.Container;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	
	public class Accordion extends mx.containers.Accordion
	{
		[Embed(source="assets/lib.swf",symbol="AccordionUp")]
		[Bindable]
		public var upIcon:Class;
		
		[Embed(source="assets/lib.swf",symbol="AccordionUp")]
		[Bindable]
		public var downIcon:Class;
		
		[Embed(source="assets/lib.swf",symbol="AccordionSelected")]
		[Bindable]
		public var selectedIcon:Class;
		
		public function Accordion()
		{
			super();
		}
		
		override protected function childrenCreated():void{
			//setIcons(this.selectedIndex);
			this.addEventListener(Event.CHANGE,changed);
			this.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, changed);
		}
		
		/**
		 * @private 
		 * 
		 * The changed function is called when the Accordion changes state
		 */
		private function changed(event:Event):void{
			setIcons(event.target.selectedIndex);
		}
		
		/**
		 * @private 
		 * 
		 * Assigns each pane the with either the upIcon, downIcon, or selectedIcon
		 */
		private function setIcons(selectedIndex:int):void
		{
			if(selectedIndex >= 0)
			{
				for(var i:int=0; i<this.numChildren; i++)
				{
					if(i>=selectedIndex)
					{
						// if pane is above selectedIndex, set with upIcon
						Container(this.getChildAt(i)).icon = upIcon;
					} 
					else 
					{
						// if pane is above selectedIndex, set with downIcon
						Container(this.getChildAt(i)).icon = downIcon;
					}
				}
				// set the selectedIcon to the selected pane
				Container(this.getChildAt(selectedIndex)).icon = selectedIcon;
				
				updateHeadersButtonMode();
			}
		}
		
		private function updateHeadersButtonMode(event:Event=null):void
		{
			for(var i:int = 0; i < getChildren().length; i++)
			{
				i != selectedIndex ? getHeaderAt(i).buttonMode = true : getHeaderAt(i).buttonMode = false;
			}	
		}
	}
}