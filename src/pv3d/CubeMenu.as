package pv3d
{
	import com.greensock.TweenMax;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapMaterial;
	import org.papervision3d.materials.special.CubeEdgeWireframeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Cube;
	
	import pv3d.core.Base3D;
	import pv3d.events.CubeEvent;
	
	import utils.LibManager;
	import utils.VarManager;
	
	[Event(type="pv3d.events.CubeEvent", name="cubeOver")]
	[Event(type="pv3d.events.CubeEvent", name="cubeOut")]
	[Event(type="pv3d.events.CubeEvent", name="cubeClick")]
	[Event(type="pv3d.events.CubeEvent", name="cubeMove")]
	[Event(type="pv3d.events.CubeEvent", name="cubePress")]
	[Event(type="pv3d.events.CubeEvent", name="cubeRelease")]
	
	public class CubeMenu extends Base3D
	{
		private var cube:DisplayObject3D;
		private var paperCube:Cube;
		private var wireCube:Cube;
		
		private var cubeSize:Number = 125;
		private var cubeStartScale:Number = 0.88;
		private var cubeStartRotY:Number = -45;
		private var cubeStartRotX:Number = 45;
		
		private var areaWidth:Number = VarManager.MENU_WIDTH;
		private var areaHeight:Number = VarManager.MENU_HEIGHT;
		
		private var _changing:Boolean = false;
		private var _hidden:Boolean = false;
		
		private var faces:Array = VarManager.CUBE_FACES;
		private var faceSymbols:Array = VarManager.CUBE_FACE_SYMBOLS;
		
		private var libManager:LibManager;
		
		public function CubeMenu()
		{
			super(areaWidth, areaHeight, true, CameraType.TARGET, false);
		}
		
		override protected function init():void
		{
			libManager = new LibManager("assets/cubeLib.swf");
			
			if(libManager.loaded)
				initCube();
			else
				libManager.contentLoaderInfo.addEventListener(Event.COMPLETE, initCube);
		}
		
		private function initCube(event:Event=null):void
		{
			var wireMat:CubeEdgeWireframeMaterial = new CubeEdgeWireframeMaterial(0xFFFFFF, 1, 3);
			
			cube = new DisplayObject3D();
			wireCube = new Cube(new MaterialsList({ all:wireMat }), cubeSize+1, cubeSize+1, cubeSize+1);
			paperCube = new Cube( cubeMaterialsList() , cubeSize, cubeSize, cubeSize);
						
			cube.addChild(paperCube);
			cube.addChild(wireCube);
			
			cube.scale = 0;
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, cubeMouseHandler);
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, cubeMouseHandler);
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, cubeMouseHandler);
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_MOVE, cubeMouseHandler);
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, cubeMouseHandler);
			paperCube.addEventListener(InteractiveScene3DEvent.OBJECT_RELEASE, cubeMouseHandler);
			
			scene.addChild(cube);
			
			_changing = true;
			TweenMax.to(cube, 0.75, { rotationX: cubeStartRotX, rotationY: cubeStartRotY, scale: cubeStartScale, onComplete: finishChanging });
			
			super.onRenderTick();
			startRendering();
		}
		
		private function cubeMaterialsList():MaterialsList
		{
			var materialsObj:Object = new Object();
			
			for(var i:int = 0; i < 6; i++)
			{
				var bmpData:BitmapData = libManager.getInstance( faceSymbols[i] ) as BitmapData;
				
				var bmpMat:BitmapMaterial = new BitmapMaterial(bmpData, true);
				bmpMat.interactive = true;
				bmpMat.smooth = true;
				bmpMat.name = faces[i];
				
				materialsObj[ faces[i] ] = bmpMat;
			}
			
			var matList:MaterialsList = new MaterialsList( materialsObj );
			
			return matList;
		}
		
		private function cubeMouseHandler(event:InteractiveScene3DEvent):void
		{
			if(event.type == InteractiveScene3DEvent.OBJECT_OVER || event.type == InteractiveScene3DEvent.OBJECT_MOVE)
			{
				viewport.buttonMode = true;
			} 
			else if(event.type == InteractiveScene3DEvent.OBJECT_OUT)
			{
				viewport.buttonMode = false;
			}
			
			var currentFace:String = event.face3d ? event.face3d.material.name : "NONE";
			
			var events:Array = [CubeEvent.CUBE_CLICK, CubeEvent.CUBE_MOVE, CubeEvent.CUBE_OUT, 
				CubeEvent.CUBE_OVER, CubeEvent.CUBE_PRESS, CubeEvent.CUBE_REALESE];
			
			var eventType:String;
			
			for(var i:int = 0; i < events.length; i++)
			{
				var ds:String = event.type.slice(5);
				
				if(events[i].toString().indexOf(ds) != -1)
				{
					eventType = events[i].toString();
				}
			}
			
			var eventObj:CubeEvent = new CubeEvent(eventType);
			eventObj.face3D = currentFace.toUpperCase();
			eventObj.displayObject3D = event.displayObject3D;
			eventObj.renderHitData = event.renderHitData;
			eventObj.sprite = event.sprite;
			eventObj.x = event.x;
			eventObj.y = event.y;
			
			this.dispatchEvent(eventObj);
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			if( !isMouseOffBounds() && !_hidden)
			{
				var valueX:Number = viewport.containerSprite.mouseX/areaWidth * 2;
				var valueY:Number = viewport.containerSprite.mouseY/areaHeight * 2;
				
				_changing = true;
				TweenMax.to(cube, 0.5, { rotationX: valueY*145, rotationY: valueX*145, scale: 1, onComplete: finishChanging });
			}
			else if( isMouseOffBounds() && !isStartCube() && !_hidden)
			{
				_changing = true;
				TweenMax.to(cube, 0.5, { rotationX: cubeStartRotX, rotationY: cubeStartRotY, scale: cubeStartScale, onComplete: finishChanging });
			}
			
			if(_changing) //SAVES PROCESSING TIME
			{
				super.onRenderTick(event);
			}
		}
		
		private function isMouseOffBounds():Boolean
		{
			var offBoundsLeft:Boolean = (viewport.containerSprite.mouseX <= -areaWidth/2);
			var offBoundsRight:Boolean = (viewport.containerSprite.mouseX >= areaWidth/2);
			var offBoundsTop:Boolean = (viewport.containerSprite.mouseY <= -areaHeight/2);
			var offBoundsBottom:Boolean = (viewport.containerSprite.mouseY >= areaHeight/2);
			
			return offBoundsLeft || offBoundsRight || offBoundsTop || offBoundsBottom;
		}
		
		private function isStartCube():Boolean
		{
			return cube.scale == cubeStartScale && cube.rotationX == 45 && cube.rotationY == -45;
		}
		
		private function finishChanging():void
		{
			_changing = false;
		}
		
		public function hideCube():void
		{
			if(!_hidden)
			{
				_hidden = true;
				_changing = true;
				TweenMax.to(cube, 0.5, { rotationX: cubeStartRotX, rotationY: cubeStartRotY, scale: 0, alpha: 0, onComplete: hiddingFinish });
			}
		}
		
		public function showCube():void
		{
			if(_hidden)
			{
				_hidden = false;
				_changing = true;
				TweenMax.to(cube, 0.5, { rotationX: cubeStartRotX, rotationY: cubeStartRotY, scale: cubeStartScale, alpha: 1, onComplete: finishChanging });	
			}
		}
		
		private function hiddingFinish():void
		{
			_changing = false;
			cube.alpha = 0;
			cube.scale = 0;
		}
	}
}