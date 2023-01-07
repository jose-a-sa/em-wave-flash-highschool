package filters
{
	import spark.filters.ColorMatrixFilter;
	
	public class GreyScaleFilter extends ColorMatrixFilter
	{
		private var rLum:Number = 0.2225;
		private var gLum:Number = 0.7169;
		private var bLum:Number = 0.0606;
		
		private var bwMatrix:Array = [rLum, gLum, bLum, 0, 0,
									rLum, gLum, bLum, 0, 0,
									rLum, gLum, bLum, 0, 0,
									0, 0, 0, 1, 0];
		
		public function GreyScaleFilter(matrix:Array=null)
		{
			var usedMatrix:Array = (matrix == null) ? bwMatrix : matrix; 
						
			super(usedMatrix);
		}
	}
}