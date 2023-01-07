package preloader
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.geom.Matrix;
	
	import mx.preloaders.SparkDownloadProgressBar;
	
	import spark.core.SpriteVisualElement;
	
	public class CustomPreloader extends SparkDownloadProgressBar
	{
		private var container:Sprite;
		private var topRect:Sprite;
		private var bottomRect:Sprite;
		private var topLineRect:Sprite;
		private var bottomLineRect:Sprite;
		
		private var numField:TextPreloader;
		private var titleField:TextPreloader;
		
		private var currentRatio:Number = 0;
		
		public function CustomPreloader()
		{
			super();
			
			container = new Sprite();
			topRect = new Sprite();
			bottomRect = new Sprite();
			topLineRect = new Sprite();
			bottomLineRect = new Sprite();
			
			numField = new TextPreloader();
			numField.text = "LOADING  000";
			
			titleField = new TextPreloader();
			titleField.text = "A  FÍSICA  E  AS  RADIOFREQUÊNCIAS";
			
			topRect.addChild(numField);
			topRect.addChild(topLineRect);
			
			bottomRect.addChild(titleField);
			bottomRect.addChild(bottomLineRect);
			
			container.addChild(topRect);
			container.addChild(bottomRect);
			
			addChild(container);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(event:Event):void
		{			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			setObjectsOnStage();
			drawRectsGraphics();
			
			stage.addEventListener(Event.RESIZE, onStageResize);
		}
		
		protected function onStageResize(event:Event):void
		{
			setObjectsOnStage();
			drawRectsGraphics();
			drawLoadingLine();
		}
		
		override protected function initProgressHandler(event:Event):void
		{
			
		}
		
		override protected function progressHandler(event:ProgressEvent):void
		{
			currentRatio = event.bytesLoaded/event.bytesTotal;
			drawLoadingLine();
			
			var numStr:String = Math.ceil( currentRatio*100 ).toFixed();
			
			while(numStr.length < 3)
			{
				numStr = "0" + numStr;
			}
			
			numField.text = "LOADING  " + numStr;	
		}
		
		override protected function initCompleteHandler(event:Event):void
		{
			stage.removeEventListener(Event.RESIZE, onStageResize);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		protected function setObjectsOnStage():void
		{
			topLineRect.y = stage.stageHeight/2 - 1;
			bottomRect.y = stage.stageHeight/2;
			
			numField.x = stage.stageWidth/2 - numField.width/2;
			numField.y =  stage.stageHeight/2 - numField.height/2 - 12;
			
			titleField.x = stage.stageWidth/2 - numField.width/2;
			titleField.y =  3;
		}
		
		protected function drawRectsGraphics():void
		{
			/* FOR THE GRADIENT STUFF
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( stage.stageWidth, stage.stageHeight/2, Math.PI/2);
			
			var gType:String = GradientType.LINEAR;
			var sprMethod:String = SpreadMethod.PAD;
			
			var alphas:Array = [ 1, 1, 1, 1];
			var colors:Array;
			var ratios:Array;
			
			ratios = [ 0, 0.25*255, 0.4*255, 255];
			colors = [ 0xAAAAAA, 0xD4D4D4, 0xEAEAEA, 0xFFFFFF];
			*/
			
			topRect.graphics.clear();
			//topRect.graphics.beginGradientFill(gType, colors, alphas, ratios, matrix);
			topRect.graphics.beginFill(0xFFFFFF);
			topRect.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight/2);
			bottomRect.graphics.endFill();
			
			
			//matrix.createGradientBox( stage.stageWidth, stage.stageHeight/2, -Math.PI/2);
			
			bottomRect.graphics.clear();
			//bottomRect.graphics.beginGradientFill(gType, colors, alphas, ratios, matrix);
			bottomRect.graphics.beginFill(0xFFFFFF);
			bottomRect.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight/2);
			bottomRect.graphics.endFill();
		}
		
		protected function drawLoadingLine():void
		{
			topLineRect.graphics.clear();
			topLineRect.graphics.beginFill( /*0xAA0000*/ 0x000000 );
			topLineRect.graphics.drawRect( 0, 0, currentRatio*stage.stageWidth, 2);
			
			bottomLineRect.graphics.clear();
			bottomLineRect.graphics.beginFill( 0x000000 );
			bottomLineRect.graphics.drawRect( 0, 0, currentRatio*stage.stageWidth, 2);
		}
	}
}