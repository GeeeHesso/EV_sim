import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { Tab1Root } from '../pages';
import { Tab2Root } from '../pages';
import { Tab3Root } from '../pages';
/**
 * Generated class for the TabsPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-tabs',
  templateUrl: 'tabs.html',
})
export class TabsPage {
	tab1Root: any = Tab1Root;
	tab2Root: any = Tab2Root;
	tab3Root: any = Tab3Root;

	tab1Title = "Humidité";
	tab2Title = "Luminosité";
	tab3Title = "Autres";

  constructor(public navCtrl: NavController, public navParams: NavParams) {
  	  
  	
  }



}
