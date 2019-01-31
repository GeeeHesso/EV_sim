import { Component } from '@angular/core';
import { NavController } from 'ionic-angular';
import firebase from 'firebase';
import { NgZone } from '@angular/core';
import {IonicPage, ToastController } from 'ionic-angular'


/**
 * Generated class for the ThermoPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-thermo',
  templateUrl: 'thermo.html',
})
export class ThermoPage {
public myPerson = {};
public number;
public night;
 current: number = 0;

  constructor(public navCtrl: NavController, private zone : NgZone, public toastCtrl: ToastController) {
    this.number = 0;
    this.night = 0;


this.zone = new NgZone({});
  }

    waterToast() {
    if( this.number == 0){
      this.number = 1;
          let toast = this.toastCtrl.create({
      message: 'eau détecté',
      showCloseButton: true,
      closeButtonText: 'Ok'

    });
    toast.present();
    }

  }

  nightToast() {
      if(this.night == 0){
        this.night = 1;
    let toast = this.toastCtrl.create({
      message: 'Nuit détecté',
      showCloseButton: true,
      closeButtonText: 'Ok'
   
    });
    toast.present();
  }
  }


ionViewDidLoad() {
  const personRef: firebase.database.Reference = 
  firebase.database().ref(`/luminositySensor/`);
  //.on() le code se souscrit au noeud et synchronise en temps réel

  personRef.on('value', personSnapshot => 
  {  this.zone.run(() =>{

    this.myPerson = personSnapshot.val();
  });

    });

}
}