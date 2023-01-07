package pv3d.core
{
	import flash.events.Event;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.view.AnaglyphView;
	
	public class Base3DAnaglyph extends AnaglyphView
	{		
		public function Base3DAnaglyph(viewportWidth:Number = 640, viewportHeight:Number = 480, scaleToStage:Boolean = true, cameraType:String = "Target", initRendering:Boolean=true)
		{
			super(false,0,viewportWidth,viewportHeight,true, true, CameraType.TARGET);
			camera.z = -1350;
			camera.zoom = 70;
			camera.focus = 7;
			
			init();
			
			if(initRendering) 
			{
				startRendering();	
			}
		}
		
		protected function init():void {

		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);
		}
	}
}