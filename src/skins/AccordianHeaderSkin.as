package skins
{
	import mx.skins.halo.AccordionHeaderSkin;
	
	public class AccordianHeaderSkin extends mx.skins.halo.AccordionHeaderSkin
	{
		public function AccordianHeaderSkin()
		{
			super();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			graphics.clear();
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
		}
	}
}