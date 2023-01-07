package pv3d
{
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	
	import mx.utils.ColorUtil;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.geom.TriangleMesh3D;
	import org.papervision3d.core.proto.MaterialObject3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Sphere;
	
	import pv3d.core.Base3D;
	import pv3d.events.WaveEvent;
	
	import utils.VarManager;
	
	[Event(type="pv3d.events.WaveEvent", name="changeMov")]
	[Event(type="pv3d.events.WaveEvent", name="changeMovFinish")]
	[Event(type="pv3d.events.WaveEvent", name="hidding")]
	[Event(type="pv3d.events.WaveEvent", name="hiddingFinish")]
	
	public class MechWaveAnimation extends Base3D
	{
		//class constants
		
		public static const LONGITUDINAL:String = "longitudinal";
		public static const TRANSVERSAL:String = "transversal";
		
		//class constants
		
		public var amplitude:Number = VarManager.MECH_START_AMPLITUDE;
		public var frequence:Number = VarManager.MECH_START_FREQUENCY;
		
		private var _rotationSpeed:Number = 0;
		private var angleDistance:Number = VarManager.MECH_ANGLE_PHASE_DISTANCE;
		private var particleDistance:Number = VarManager.MECH_PARTICLE_DISTANCE;
		
		private var light:PointLight3D;
		private var holder:DisplayObject3D;
		
		private var particles:Vector.<Sphere> = new Vector.<Sphere>();
		//private var particles:Vector.<GeodesicSphere> = new Vector.<GeodesicSphere>();
		private var numParticles:uint = VarManager.MECH_NUM_PARTICLES;
		
		private var particleColors:Array = [];
		
		private var _currentMovementType:String;
		private var _ambientColor:uint = 0x0D0D0D;
		
		private var _changing:Boolean = false;
		private var _paused:Boolean = false;
		private var _hidden:Boolean = true;
		
		private var t:Number = 0;
		
		private var i:uint;
		
		public function MechWaveAnimation(viewportWidth:Number=640, viewportHeight:Number=480)
		{
			super(viewportWidth, viewportHeight, true, CameraType.TARGET);
		}
		
		override protected function init():void
		{
			light = new PointLight3D();
			light.z = camera.z - 50;
			
			holder = new DisplayObject3D();
			
			for(var i:uint = 0; i < numParticles;i++)
			{
				var color:uint = Math.random()*0xFFFFFF;
				particleColors.push(color);
					
				var mat:MaterialObject3D = new FlatShadeMaterial(light, color, ColorUtil.adjustBrightness(_ambientColor, -150));
				
				//var particle:GeodesicSphere = new GeodesicSphere(mat, 25, 3);
				var particle:Sphere = new Sphere(mat, 25, 9, 7);
				particle.useOwnContainer = true;
				
				particles.push(particle);
				
				//start transversal
				_currentMovementType = TRANSVERSAL;
				particle.x = - particleDistance*(numParticles)/2 + particleDistance*i;
				particle.y = amplitude * Math.sin( -2*Math.PI*t + angleDistance*i);
				
				//start logitudinal
				//_currentMovementType = LONGITUDINAL;
				//particle.x = - particleDistance*(numParticles)/2 + particleDistance*i;
				//particle.y = 0;
				
				particle.scale = 0;
				
				holder.addChild(particle);
			}
			
			scene.addChild(holder);
			
			holder.z = -50;
			holder.x = -650
			holder.rotationY = -VarManager.MECH_START_ROTATION;
			
			//showWave();
		}
		
		override protected function onRenderTick(event:Event=null):void
		{
			if(!_paused && !_hidden) 
			{	
				t += 1/25 * frequence;
				updateParticles();
			}
			
			light.x = viewport.containerSprite.mouseX * 0.9;
			light.y = -viewport.containerSprite.mouseY * 1.0;
			
			if(!_hidden)
			{
				super.onRenderTick(event);
			}
		}
		
		private function updateParticles():void
		{
			for(i = 0; i < particles.length; i++)
			{
				switch(_currentMovementType)
				{
					case TRANSVERSAL:
						particles[i].y = - amplitude * Math.sin( 2*Math.PI*t + angleDistance*i);
						break;
					case LONGITUDINAL:
						particles[i].x = -particleDistance*(numParticles)/2 + particleDistance*i - amplitude * Math.sin( -2*Math.PI*t + angleDistance*i);
						break;
				}
			}
		}
		
		public function changeMovementType(type:String):void
		{			
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.CHANGE_MOV, false, true);
			eventObj.currentMovType = this._currentMovementType;
			eventObj.fromMovType = this._currentMovementType;
			eventObj.toMovType = type;
			eventObj.waveType = "mech";
			eventObj.waveHidden = _hidden;
			
			if( _currentMovementType != type && !_changing && !_hidden && this.dispatchEvent(eventObj) ) 
			{
				_changing = true;
				_currentMovementType = type;
				
				changeParticlePlaces(type, 0.750);
			}
		}
		
		private function changeParticlePlaces(type:String, time:Number):void
		{
			switch(type)
			{
				case TRANSVERSAL:
					
					pauseAnimation();
					
					for(i = 0; i < particles.length; i++)
					{
						TweenMax.to(particles[i], time, {
							x: -particleDistance*(numParticles)/2 + particleDistance*i,
							y: amplitude * Math.sin( -2*Math.PI*t + angleDistance*i),
							onComplete: finishChanging
						});
					}
					
					break;
				case LONGITUDINAL:
					
					for(i = 0; i < particles.length; i++)
					{
						TweenMax.to(particles[i], time, {
							x: -particleDistance*(numParticles)/2 + particleDistance*i,
							y: 0,
							onComplete: finishChanging
						});
					}
					
					break;
			}
		}
		
		private function finishChanging():void
		{
			playAnimation();
			_changing = false;
			
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.CHANGE_MOV_FINISH);
			eventObj.currentMovType = this._currentMovementType;
			eventObj.waveType = "mech";
			eventObj.waveHidden = _hidden;
			
			this.dispatchEvent(eventObj);
		}
		
		public function pauseAnimation():void
		{
			_paused = true;
		}
		
		public function playAnimation():void
		{
			_paused = false;
		}
		
		public function set waveRotation(value:Number):void
		{
			TweenMax.to(holder, 0.5, {rotationY: -value});
		}
		
		public function get waveRotation():Number
		{				
			return -holder.rotationY;
		}
		
		public function get currentMovementType():String
		{
			return _currentMovementType;
		}

		public function get ambientColor():uint
		{
			return _ambientColor;
		}

		public function set ambientColor(value:uint):void
		{
			_ambientColor = value;
			
			for(var i:int = 0; i < particles.length; i++)
			{
				var particle:TriangleMesh3D = particles[i] as TriangleMesh3D;
				
				particle.material = new FlatShadeMaterial(light, particleColors[i], ColorUtil.adjustBrightness(_ambientColor, -150));
			}
		}
		
		public function hideWave():void
		{
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING, false, true);
			eventObj.currentMovType = this._currentMovementType;
			eventObj.waveHidden = false;
			eventObj.waveType = "mech";
			
			if( !_hidden && this.dispatchEvent(eventObj) )
			{
				for(var i:int = 0; i < particles.length; i++)
				{
					var tweenObj:Object = { scale: 0, onComplete: hiddingFinish, onCompleteParams:[0,_changing]}
					
					if(_changing)
					{
						switch(_currentMovementType)
						{
							case TRANSVERSAL:
								tweenObj.x = -particleDistance*(numParticles)/2 + particleDistance*i;
								tweenObj.y = amplitude * Math.sin( -2*Math.PI*t + angleDistance*i);
								break;
							case LONGITUDINAL:
								tweenObj.x = -particleDistance*(numParticles)/2 + particleDistance*i;
								tweenObj.y = 0;
								break;
						}
					}
					
					TweenMax.to(particles[i], 0.750, tweenObj);
				}
			}
		}
		
		public function showWave():void
		{
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING, false, true);
			eventObj.currentMovType = this._currentMovementType;
			eventObj.waveHidden = true;
			eventObj.waveType = "mech";
			
			if( _hidden && this.dispatchEvent(eventObj) )
			{
				_hidden = false;
				
				for(var i:int = 0; i < particles.length; i++)
				{
					var tweenObj:Object = { scale: 1, onComplete: hiddingFinish, onCompleteParams:[1,_changing]}
					
					if(_changing)
					{						
						switch(_currentMovementType)
						{
							case TRANSVERSAL:
								tweenObj.x = -particleDistance*(numParticles)/2 + particleDistance*i;
								tweenObj.y = amplitude * Math.sin( -2*Math.PI*t + angleDistance*i);
								break;
							case LONGITUDINAL:
								tweenObj.x = -particleDistance*(numParticles)/2 + particleDistance*i;
								tweenObj.y = 0;
								break;
						}
					}
					
					TweenMax.to(particles[i], 0.750, tweenObj);
				}
			}
		}
		
		private function hiddingFinish(value:Number, wasChanging:Boolean):void
		{
			if(wasChanging)
			{
				finishChanging();
			}
			
			if(value == 0)
			{
				_hidden = true;
			}
			
			for(var i:int = 0; i < particles.length; i++)
			{
				particles[i].scale = value;
			}
			
			var eventObj:WaveEvent = new WaveEvent(WaveEvent.HIDDING_FINISH);
			eventObj.currentMovType = this._currentMovementType;
			eventObj.waveHidden = value == 0;
			eventObj.waveType = "mech";
			this.dispatchEvent(eventObj);
		}
		
		public function get hidden():Boolean
		{
			return _hidden;
		}
		
		public function get changeTypeLabel():String
		{
			var nextMov:String = _currentMovementType == TRANSVERSAL ? LONGITUDINAL : TRANSVERSAL;
			
			return "Mudar para movimento " +nextMov.toLowerCase();
		}
	}
}