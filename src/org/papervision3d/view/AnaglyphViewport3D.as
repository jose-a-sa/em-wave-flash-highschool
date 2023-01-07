package org.papervision3d.view {
	
	import org.papervision3d.view.Viewport3D;
	
	public class AnaglyphViewport3D extends Viewport3D {
		
		public function AnaglyphViewport3D(viewportWidth:Number = 640, viewportHeight:Number = 480, autoScaleToStage:Boolean = false, interactive:Boolean = false, autoClipping:Boolean = true, autoCulling:Boolean = true) {
			
			super(viewportWidth, viewportHeight, autoScaleToStage, interactive, autoClipping, autoCulling);
		}
	}
}