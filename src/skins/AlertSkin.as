package skins
{
	import mx.skins.halo.PanelSkin;
	
	public class AlertSkin extends PanelSkin
	{
		public function AlertSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			with(this.graphics) {
				clear();
				
				lineStyle(1.5, 0x0c0d0d, 1, false, "normal", "none", "miter", 4);
				beginFill(0x262626, 1);
				drawRect( 0, 0, unscaledWidth, unscaledHeight);
				endFill();
				
				lineStyle(NaN, 0);
				beginFill(0x131313, 1);
				drawRect(3.5, 3.5, unscaledWidth - 7, 25);
				endFill();
			}
		}
	}
}