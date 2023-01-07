package utils
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.HexColorsPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.StageDisplayState;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import utils.color.ColorUtils;
	
	public class AppManager
	{
		[Bindable]
		public static var isMechWave:Boolean = true;
		[Bindable]
		public static var isEMWave:Boolean = false;
		[Bindable]
		public static var infoContentTip:String = "";
		[Bindable]
		public static var colorChangerTip:String = "";
		[Bindable]
		public static var leftSliderTip:String = "";
		[Bindable]
		public static var rightSliderTip:String = "";
		[Bindable]
		public static var bottomSliderTip:String = "";
		
		
		private static var ambientColorObj:Object = {};
		
		public static function toogleFullscreen():void
		{
			FlexGlobals.topLevelApplication.stage.displayState = FlexGlobals.topLevelApplication.stage.displayState == StageDisplayState.NORMAL ?
				StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
		}
		
		public static function get isFullscreen():Boolean
		{
			if(FlexGlobals.topLevelApplication.stage)
			{
				return FlexGlobals.topLevelApplication.stage.displayState == StageDisplayState.FULL_SCREEN;
			} 
			else
			{
				return false;
			}
			
		}
		
		public static function changeAppBackgroundColor(color:uint):void
		{
			ColorUtils.changeStyleColor(FlexGlobals.topLevelApplication as UIComponent, "backgroundColor", color);
			
			ambientColorObj = { ambientColor: FlexGlobals.topLevelApplication.wave.ambientColor };
			
			TweenMax.to(ambientColorObj, 1.5, {
				hexColors: { ambientColor: color },
				onUpdate: function():void {
					FlexGlobals.topLevelApplication.wave.ambientColor = ambientColorObj.ambientColor;
				}
			});
		}
		
		public static function get appBackgroundColor():uint
		{
			return FlexGlobals.topLevelApplication.getStyle("backgroundColor");
		}
	}
}