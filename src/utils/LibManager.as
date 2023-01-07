package utils
{
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import mx.controls.SWFLoader;
	
	public class LibManager extends Loader
	{
		private var calledInit:Boolean = false;
		
		public function LibManager(url:String=""):void
		{
			super();
			
			if(url != "" && url != null)
			{
				loadLib(url);
			}
		}
		
		public function loadLib(url:String):void 
		{			
			this.load(new URLRequest(url));
			
			calledInit = true;
		}
		
		public function get loaded():Boolean 
		{
			return (this.content != null);
		}
		
		public function getInstance(className:String):*
		{
			var SymbolClass:Class = getDefinition(className);
			return (SymbolClass) ? new SymbolClass() : null;
		}
		
		public function getDefinition(className:String):Class 
		{
			return loaded ? this.contentLoaderInfo.applicationDomain.getDefinition(className) as Class : null;
		} 
	}
}