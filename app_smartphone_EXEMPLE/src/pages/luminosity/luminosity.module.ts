import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { LuminosityPage } from './luminosity';
import {RoundProgressModule} from 'angular-svg-round-progressbar';
@NgModule({
  declarations: [
    LuminosityPage,
  ],
  imports: [
    RoundProgressModule,
    IonicPageModule.forChild(LuminosityPage),
  ],
    exports: [
  	LuminosityPage
  ]
})
export class LuminosityPageModule {}
