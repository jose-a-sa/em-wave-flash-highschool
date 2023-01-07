package org.papervision3d.materials.special
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	import org.papervision3d.core.material.TriangleMaterial;
	import org.papervision3d.core.render.command.RenderTriangle;
	import org.papervision3d.core.render.data.RenderSessionData;
	import org.papervision3d.core.render.draw.ITriangleDrawer;
	
	public class CubeEdgeWireframeMaterial extends TriangleMaterial implements ITriangleDrawer
	{
		public function CubeEdgeWireframeMaterial( color:Number=0xFF00FF, alpha:Number=1, thickness:Number = 0 )
		{
			this.lineColor     = color;
			this.lineAlpha     = alpha;
			this.lineThickness = thickness;
			
			this.doubleSided = false;
		}
		
		public override function drawTriangle(tri:RenderTriangle, graphics:Graphics, renderSessionData:RenderSessionData, 
											  altBitmap:BitmapData=null, altUV:Matrix=null):void 
		{
			var x0:Number = tri.v0.x;
			var y0:Number = tri.v0.y;
			var x1:Number = tri.v1.x;
			var y1:Number = tri.v1.y;
			var x2:Number = tri.v2.x;
			var y2:Number = tri.v2.y;
			
			if( lineAlpha )
			{
				graphics.lineStyle(lineThickness, lineColor, lineAlpha );
				if (tri.uv0.u == 1 )
				{
					graphics.moveTo( x0, y0 );
					graphics.lineTo( x1, y1 );
				}
				if (tri.uv0.u == 0)
				{
					graphics.moveTo( x0, y0 );
					graphics.lineTo( x2, y2 );
				}
				
				if (tri.uv1.v == 0)
				{
					graphics.moveTo( x0, y0 );
					graphics.lineTo( x1, y1 );
				}
				
				if (tri.uv1.v == 1)
				{
					graphics.moveTo( x2, y2 );
					graphics.lineTo( x1, y1 );
				}
				graphics.lineStyle();
			}
			
			renderSessionData.renderStatistics.triangles++;
		}
	}
}