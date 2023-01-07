package pv3d.core
{
	import flash.events.Event;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.view.BasicView;
	
	public class Base3D extends BasicView
	{		
		public function Base3D(viewportWidth:Number = 640, viewportHeight:Number = 480, scaleToStage:Boolean = true, 
							   cameraType:String = "Target", singleInitRendering:Boolean=true)
		{
			super(viewportWidth,viewportHeight, true, true, CameraType.TARGET);
			camera.z = -1350;
			camera.zoom = 70;
			camera.focus = 7;
			
			init();
			
			if(singleInitRendering) 
			{
				startRendering();	
			}
		}
		
		protected function init():void
		{

		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			super.onRenderTick(event);
		}
	}
}