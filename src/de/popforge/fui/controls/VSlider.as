/**
 * Copyright(C) 2007 Andre Michelle and Joa Ebert
 *
 * PopForge is an ActionScript3 code sandbox developed by Andre Michelle and Joa Ebert
 * http://sandbox.popforge.de
 * 
 * This file is part of PopforgeAS3Audio.
 * 
 * PopforgeAS3Audio is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 * 
 * PopforgeAS3Audio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>
 */
package de.popforge.fui.controls
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * The VSlider class represents a vertical slider.
	 * 
	 * @author Joa Ebert
	 * @author André Michelle
	 */	
	public class VSlider extends Slider
	{
		override protected function build(): void
		{
			super.build();
			
			length = targetHeight;
						
			graphics.lineStyle( 2, 0x333333 );
			graphics.beginFill( 0x555555 );
			graphics.drawRoundRect( 0, 0, tileSize, length, tileSize, tileSize );
			graphics.endFill();

			var knob: Sprite = new Sprite;
			
			with ( knob.graphics )
			{
				lineStyle( 2, 0x333333 );
				beginFill( 0x999999 );
				drawCircle( 0, 0, tileSize * .5 );
				endFill();
			}
			
			addChild( knob );

			knobOffsetX = knob.x = tileSize * .5;
			knobOffsetY = knob.y = tileSize * .5;
			
			this.knob = knob;
		}
		
		override protected function updateKnobPosition(): void
		{
			knob.y = knobOffsetY + ( 1 - parameter.getValueNormalized() ) * ( length - 2 * knobOffsetY );
		}
		
		override protected function onMouseDown( event: MouseEvent ): void
		{
			if( event.target == knob )
				dragOffset = knob.mouseY;
			else
				dragOffset = 0;

			super.onMouseDown( event );
		}
		
		override protected function onStageMouseMove( event: MouseEvent ): void
		{
			var ratio: Number = ( ( length - mouseY ) + dragOffset - knobOffsetY ) / ( length - 2 * knobOffsetY );
			
			if( ratio < 0 ) ratio = 0;
			else if( ratio > 1 ) ratio = 1;
			
			if ( parameter != null )
			{
				parameter.setValueNormalized( ratio );
			}
		}
		
		override public function toString(): String
		{
			return '[VSlider]';
		}
	}
}