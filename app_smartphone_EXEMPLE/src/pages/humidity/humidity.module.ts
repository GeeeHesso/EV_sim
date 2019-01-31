import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { HumidityPage } from './humidity';

import {RoundProgressModule} from 'angular-svg-round-progressbar';
@NgModule({
  declarations: [
    HumidityPage,
  ],
  imports: [
    RoundProgressModule,
    IonicPageModule.forChild(HumidityPage),
  ],
  exports: [
  	HumidityPage
  ]
})
export class HumidityPageModule {}
