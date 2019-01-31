import { NgModule } from '@angular/core';
import { IonicPageModule } from 'ionic-angular';
import { ThermoPage } from './thermo';

@NgModule({
  declarations: [
    ThermoPage,
  ],
  imports: [
    IonicPageModule.forChild(ThermoPage),
  ],
})
export class ThermoPageModule {}
