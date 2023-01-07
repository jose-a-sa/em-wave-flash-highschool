package pv3d
{
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.geom.Lines3D;
	import org.papervision3d.core.geom.renderables.Line3D;
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.special.LineMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Sphere;
	
	import pv3d.core.Base3D;
	import pv3d.events.WaveEvent;
	
	import utils.VarManager;
	
	[Event(type="pv3d.events.WaveEvent", name="hidding")]
	[Event(type="pv3d.events.WaveEvent", name="hiddingFinish")]
	
	public class EMWaveAnimation extends Base3D
	{
		private var _changing:Boolean = false;
		private var _paused:Boolean = false;
		private var _hidden:Boolean = true;
		
		private var magVertexCache:Vertex3D;
		private var electVertexCache:Vertex3D;
		
		private var holder:DisplayObject3D;
		
		private var light:PointLight3D;
		
		private var axis:Lines3D;
		private var magneticLines:Lines3D;
		private var electricLines:Lines3D;
		private var particle:Sphere;
		
		private var electMaterial:LineMaterial;
		private var magMaterial:LineMaterial;
		private var axisMaterial:LineMaterial;
		
		private var _frequence:Number = VarManager.EM_START_FREQUENCY;
		
		private var amplitude:Number = VarManager.EM_AMPLITUDE;
		private var speed:Number = VarManager.EM_SPEED;
		
		private var ty:Number = 0;
		private var tx:Number = 0;
		
		public function EMWaveAnimation(viewportWidth:Number=640, viewportHeight:Number=480)
		{
			electMaterial = new LineMaterial( VarManager.EM_ELECTRIC_FIELD_COLOR );
			magMaterial = new LineMaterial( VarManager.EM_MAGNETIC_FIELD_COLOR );
			axisMaterial = new LineMaterial( VarManager.EM_AXIS_COLOR );
			
			super(viewportWidth, viewportHeight, true, CameraType.TARGET);
		}
		
		override protected function init():void
		{
			holder = new DisplayObject3D();
			holder.z = 0;
			holder.rotationX = VarManager.EM_START_ROTATION_X;
			holder.rotationY = - VarManager.EM_START_ROTATION_Y;
			
			camera.z = -2500;
			
			holder.useOwnContainer = true;
			//holder.scale = 0;
			holder.alpha = 0;
			
			scene.addChild(holder);
			
			magVertexCache = new Vertex3D(0,0,0);
			electVertexCache = new Vertex3D(0,0,0);
			
			initLines();
			initParticle();
			
			light = new PointLight3D();
			light.z = camera.z;
			scene.addChild(light);
			
			//showWave();
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			if(!_paused && !_hidden) 
			{	
				ty += 1/25 * frequence;
				tx += 1/25;
				updateLines();
			}
			
			if(!_hidden)
			{
				super.onRenderTick(event);
			}
			
			light.x = viewport.containerSprite.mouseX * 0.9;
			light.y = -viewport.containerSprite.mouseY * 1.0;
		}
		
		private function initLines():void
		{			
			magneticLines = new Lines3D(magMaterial);
			electricLines = new Lines3D(electMaterial);
			
			axis = new Lines3D(new LineMaterial(0xFFFFFF));
			axis.addLine(new Line3D(axis,axisMaterial,1,new Vertex3D(-300,0,0),new Vertex3D(300,0,0)));
			axis.addLine(new Line3D(axis,axisMaterial,1,new Vertex3D(0,-300,0),new Vertex3D(0,300,0)));
			
			holder.addChild(axis);
			holder.addChild(magneticLines);
			holder.addChild(electricLines);
		}
		
		private function initParticle():void
		{
			particle = new Sphere(new FlatShadeMaterial(light,0xFFFFFF*Math.random()), 40, 9, 7);
			
			particle.x = 0;
			particle.z = 0;
			particle.y = amplitude*Math.sin(ty);
			
			holder.addChild(particle);
		}
		
		protected function updateLines():void
		{
			var magV0:Vertex3D = magVertexCache;
			var electV0:Vertex3D = electVertexCache;
			
			var magV1:Vertex3D = new Vertex3D(0,amplitude*Math.sin(ty),speed*tx);
			var electV1:Vertex3D = new Vertex3D(amplitude*Math.sin(ty),0,speed*tx);
			
			magneticLines.addLine( new Line3D(magneticLines,magMaterial, 2, magV0, magV1) );
			electricLines.addLine( new Line3D(electricLines,electMaterial, 2, electV0, electV1) );
			
			magneticLines.z = -speed * tx;
			electricLines.z = -speed * tx;
			
			particle.y = amplitude*Math.sin(ty);
			
			if( (Math.round(10000*tx))%300 == 0 )
			{
				magneticLines.addLine( new Line3D(magneticLines,magMaterial, 1, new Vertex3D(0,0,speed*tx), magV1) );
				electricLines.addLine( new Line3D(electricLines,electMaterial, 1, new Vertex3D(0,0,speed*tx), electV1) );
			}
			
			magVertexCache = magV1;
			electVertexCache = electV1;
		}
		
		public function resetLines():void
		{
			tx = 0;
			ty = 0;
			electricLines.removeAllLines();
			magneticLines.removeAllLines();
			magVertexCache = new Vertex3D(0,0,0);
			electVertexCache = new Vertex3D(0,0,0);
		}
		
		public function set waveRotationX(value:Number):void
		{
			TweenMax.to(holder, 0.5, { 
				rotationX: value
			});
		}
		
		public function get waveRotationX():Number
		{
			return holder.rotationX;
		}
		
		public function set waveRotationY(value:Number):void
		{
			TweenMax.to(holder, 0.5, { 
				rotationY: -value
			});
		}
		
		public function get waveRotationY():Number
		{
			return -holder.rotationY;
		}
		
		public function pauseAnimation():void
		{
			_paused = true;
		}
		
		public function playAnimation():void
		{
			_paused = false;
		}
		
		public function get frequence():Number
		{
			return _frequence;
		}
		
		public function set frequence(value:Number):void
		{
			_frequence = value;
		}
		
		public function setFrequence(value:Number):void
		{
			TweenMax.to(this, 0.5, {frequence: value});
		}
		
		public function showWave():void
		{
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING, false, true);
			eventObj.waveHidden = false;
			eventObj.waveType = "em";
			
			if(_hidden && this.dispatchEvent(eventObj) )
			{
				_hidden = false;
				
				TweenMax.to(holder, 0.750, {
					//scale: 1, 
					alpha: 1,
					onComplete: hideWaveFinish,
					onCompleteParams: [ false ]
				});
			}
		}
		
		public function hideWave():void
		{
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING, false, true);
			eventObj.waveHidden = true;
			eventObj.waveType = "em";
			
			if(!_hidden && this.dispatchEvent(eventObj) )
			{
				TweenMax.to(holder, 0.750, {
					//scale: 0,
					alpha: 0,
					onComplete: hideWaveFinish,
					onCompleteParams: [ true ]
				});
			}
		}
		
		public function get hidden():Boolean
		{
			return _hidden;
		}
		
		private function hideWaveFinish(value:Boolean):void
		{
			//holder.scale = value ? 0 : 1;
			holder.alpha = value ? 0 : 1;
			
			_hidden = value;
			
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING_FINISH);
			eventObj.waveHidden = _hidden;
			eventObj.waveType = "em";
			this.dispatchEvent(eventObj);
		}
	}
}