////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.staticControls.beads.layouts
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.html.staticControls.beads.IScrollBarBead;

	public class VScrollBarLayout implements IBead
	{
		public function VScrollBarLayout()
		{
		}
		
		private var sbModel:IScrollBarModel;
		private var sbView:IScrollBarBead;
		
		private var _strand:IStrand;
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			sbView = value as IScrollBarBead;
			sbModel = sbView.scrollBarModel;
			sbModel.addEventListener("maximumChange", changeHandler);
			sbModel.addEventListener("minimumChange", changeHandler);
			sbModel.addEventListener("snapIntervalChange", changeHandler);
			sbModel.addEventListener("stepSizeChange", changeHandler);
			sbModel.addEventListener("valueChange", changeHandler);
			sbModel.addEventListener("heightChanged", changeHandler);
			changeHandler(null);
		}
	
		private function changeHandler(event:Event):void
		{
			var h:Number = DisplayObject(sbView.strand).height;
			var increment:DisplayObject = sbView.increment;
			var decrement:DisplayObject = sbView.decrement;
			var track:DisplayObject = sbView.track;
			var thumb:DisplayObject = sbView.thumb;
			
			decrement.x = 0;
			decrement.y = 0;
			increment.x = 0;
			increment.y = h - increment.height;
			track.x = 0;
			track.y = decrement.height;
			track.height = increment.y - decrement.height;
			if (track.height > thumb.height)
			{
				thumb.visible = true;
				thumb.height = sbModel.pageSize / (sbModel.maximum - sbModel.minimum) * track.height;
				thumb.y = (sbModel.value / (sbModel.maximum - sbModel.minimum - sbModel.pageSize) * (track.height - thumb.height)) + track.y;
			}
			else
			{
				thumb.visible = false;
			}
		}
						
	}
}