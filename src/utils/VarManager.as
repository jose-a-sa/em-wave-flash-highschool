package utils 
{
	public class VarManager
	{		
		public static const BACKGROUND_COLOR:uint = 0x0D0D0D;
		
		//MECHANICAL WAVE RELATED CONSTANTS
		
		public static const MECH_MIN_AMPLITUDE:Number = 10;
		public static const MECH_MAX_AMPLITUDE:Number = 230;
		public static const MECH_START_AMPLITUDE:Number = 150;
		
		public static const MECH_MIN_FREQUENCY:Number = 0.1;
		public static const MECH_MAX_FREQUENCY:Number = 1;
		public static const MECH_START_FREQUENCY:Number = 0.5;
		
		public static const MECH_START_ROTATION:Number = -48; //BETWEEN max AND min DEGREES
		public static const MECH_MAX_ROTATION:Number = 180; //DEGREES
		public static const MECH_MIN_ROTATION:Number = -180; //DEGREES
		
		public static const MECH_ANGLE_PHASE_DISTANCE:Number = Math.PI/3; //RADIANS
		public static const MECH_PARTICLE_DISTANCE:Number = 270;
		
		public static const MECH_NUM_PARTICLES:uint = 15;
		
		//MECHANICAL WAVE RELATED CONSTANTS
		
		public static const EM_SPEED:Number = 200;
		
		public static const EM_AMPLITUDE:Number = 200;
		
		public static const EM_AXIS_COLOR:uint = 0XFFFFFF;
		public static const EM_MAGNETIC_FIELD_COLOR:uint = 0xFFCC33;
		public static const EM_ELECTRIC_FIELD_COLOR:uint = 0x66CC33;
		
		public static const EM_MIN_FREQUENCY:Number = 0.3;
		public static const EM_MAX_FREQUENCY:Number = 8;
		public static const EM_START_FREQUENCY:Number = 3;
		
		public static const EM_START_ROTATION_X:Number = -5; //BETWEEN max AND min DEGREES
		public static const EM_MAX_ROTATION_X:Number = 30; //DEGREES
		public static const EM_MIN_ROTATION_X:Number = -30; //DEGREES
		
		public static const EM_START_ROTATION_Y:Number = 15; //BETWEEN max AND min DEGREES
		public static const EM_MAX_ROTATION_Y:Number = 50; //DEGREES
		public static const EM_MIN_ROTATION_Y:Number = -50; //DEGREES
		
		//CUBE MENU RELATED CONSTANTS
		
		public static const MENU_WIDTH:Number = 138;
		public static const MENU_HEIGHT:Number = 108;
		
		public static const CUBE_FACES:Array = ["front","back","right","left","top","bottom"];
		public static const CUBE_FACE_SYMBOLS:Array = ["Face","Face2","Face4","Face3","Face5","Face1"];
		
		public static const MENU_LABELS_WIDTH:Array = [180, 190, 170, 90, 140];
		
		public static const MENU_LABELS:Object = {
			back: "MOSTRAR OS TÓPICOS DE INFORMAÇÃO",
			right: "MOSTRAR INFORMAÇÃO DO PROJECTO",
			top: "REINICIAR A ONDA",
			left: "MUDAR PARA ELECTROMAGNÉTICA",	
			bottom : "MUDAR PARA ECRÂ INTEIRO"
		};
		
		public static const MENU_LABELS_CLICKED:Object = {
			back: "OCULTAR OS TÓPICOS DE INFORMAÇÂO",
			right: "OCULTAR INFORMAÇÃO DO PROJECTO",
			top: "REINICIAR A ONDA",
			left: "MUDAR PARA MECÂNICA",
			bottom: "MUDAR PARA ECRÂ NORMAL"
		};
		
		//TOOLTIPS
		
		public static const EM_LEFT_SLIDER_TIP:String = "Frequência";
		public static const EM_RIGHT_SLIDER_TIP:String = "Rotação vertical";
		public static const EM_BOTTOM_SLIDER_TIP:String = "Rotação horizontal";
		
		public static const MECH_LEFT_SLIDER_TIP:String = "Frequência";
		public static const MECH_RIGHT_SLIDER_TIP:String = "Amplitude";
		public static const MECH_BOTTOM_SLIDER_TIP:String = "Rotação horizontal";
		
		public static const INFO_CONTENT_TIP:String = "Painel informativo";
		
		public static const COLOR_CHANGER_TIP:String = "Muda de cor";
	}
}