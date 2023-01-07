package components
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.filters.GlowFilter;
	
	public class EMPlot extends UIComponent
	{
		public function EMPlot()
		{
			super();
			
			graphics.lineStyle(1, 0xFFFFFF, 1);
			draw();
			
			addEventListener(FlexEvent.CREATION_COMPLETE, draw);
			
			this.filters = [new GlowFilter(0xFFFFFF, 1, 2, 2, 1.3, 3)]
		}
		
		public function draw(event:Event=null):void
		{
			var lastPoint:Point = new Point( 1 , f(-this.width/2+1) + this.height/2);
			var newPoint:Point;
			
			for(var i:Number = -this.width/2 + 1; i < this.width/2; i++)
			{
				newPoint = new Point( i , f(i) );
				newPoint.x += this.width/2;
				newPoint.y += this.height/2;
				
				graphics.moveTo( lastPoint.x , lastPoint.y );
				graphics.lineTo( newPoint.x , newPoint.y );
				
				lastPoint = newPoint;
			}
		}
		
		private function f(x:Number):Number 
		{ 
			x+=320;
			return 18*Math.sin( 0.018 * Math.exp(0.0055*x) * x);
		}

	}
}